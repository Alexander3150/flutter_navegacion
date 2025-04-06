import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_navegacion/presentation/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtiene la instancia de CartProvider y se suscribe a cambios
    // Cuando notifyListeners() se llama en el provider, este widget se reconstruye
    final cartProvider = Provider.of<CartProvider>(context);
    // Accede a la lista actual de productos en el carrito
    final cartItems = cartProvider.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Carrito'),
        actions: [
          // Muestra el botón de vaciar carrito solo si hay items
          if (cartItems.isNotEmpty)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Llama al método clearCart() del provider
                cartProvider.clearCart();
                // Muestra un mensaje temporal
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Carrito vaciado'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
        ],
      ),
      body:
          cartItems.isEmpty
              ? Center(
                // Muestra estado vacío si no hay productos
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Tu carrito está vacío',
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                  ],
                ),
              )
              : ListView.builder(
                // Construye la lista de productos en el carrito
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Dismissible(
                    // Widget que se puede deslizar para eliminar
                    key: Key(item['name']), // Clave única para cada item
                    direction:
                        DismissDirection
                            .endToStart, // Dirección del deslizamiento
                    background: Container(
                      // Fondo que aparece al deslizar
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (_) {
                      // Acción al deslizar: elimina el producto
                      cartProvider.removeItem(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${item['name']} eliminado'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Card(
                      // Tarjeta que muestra cada producto
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Nombre del producto
                            Text(
                              item['name'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Contador de cantidad
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Cant: ',
                                    style: TextStyle(
                                      color: Colors.blue[800],
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    item['quantity'].toString(),
                                    style: TextStyle(
                                      color: Colors.blue[800],
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
