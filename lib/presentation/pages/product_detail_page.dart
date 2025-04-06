import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_navegacion/presentation/providers/cart_provider.dart';

class ProductDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtiene el nombre del producto pasado como argumento de navegación
    final String productName =
        ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Producto'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Navega back
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Título del producto
              Text(
                productName,
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 20.0), // Espaciador
              // Placeholder de imagen del producto
              Container(
                height: 200.0,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Icon(
                  Icons.image_search,
                  size: 100.0,
                  color: Colors.grey[600],
                ),
              ),

              SizedBox(height: 30.0), // Espaciador
              // Descripción del producto
              Text(
                'Descripción detallada del producto $productName. '
                'Este artículo exclusivo ofrece características únicas '
                'y calidad premium. Fabricado con los más altos estándares '
                'de calidad para garantizar durabilidad y rendimiento.',
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.justify,
              ),

              SizedBox(height: 40.0), // Espaciador
              // Botón para añadir al carrito
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 15.0,
                  ),
                ),
                onPressed: () {
                  // Obtiene el CartProvider sin suscribirse a cambios (listen: false)
                  final cartProvider = Provider.of<CartProvider>(
                    context,
                    listen: false,
                  );

                  // Añade el producto al carrito
                  cartProvider.addItem(productName);

                  // Muestra feedback al usuario
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$productName añadido al carrito'),
                      duration: Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );

                  // Regresa a la pantalla anterior
                  Navigator.pop(context);
                },
                child: Text(
                  'Añadir al carrito',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
