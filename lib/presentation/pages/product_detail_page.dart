import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_navegacion/presentation/providers/cart_provider.dart';

class ProductDetailPage extends StatelessWidget {
  // Función para convertir nombres de productos a rutas de imágenes
  String _getImagePath(String productName) {
    // Formatea el nombre del producto para que coincida con los nombres de archivo
    return 'assets/images/${productName.toLowerCase().replaceAll(' ', '_').replaceAll('á', 'a').replaceAll('é', 'e').replaceAll('í', 'i').replaceAll('ó', 'o').replaceAll('ú', 'u').replaceAll('-', '')}.png';
  }

  @override
  Widget build(BuildContext context) {
    final String productName =
        ModalRoute.of(context)?.settings.arguments as String;
    final imagePath = _getImagePath(productName);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Producto'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                productName,
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 20.0),
              // Contenedor de imagen actualizado
              Container(
                height: 250.0,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    // Si la imagen no existe, muestra un icono y la imagen por defecto
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: Colors.grey[600],
                        ),
                        SizedBox(height: 10),
                        Image.asset(
                          'assets/images/default_product.png',
                          height: 150,
                          fit: BoxFit.contain,
                        ),
                      ],
                    );
                  },
                ),
              ),

              SizedBox(height: 30.0),
              Text(
                'Descripción detallada del producto $productName. '
                'Este artículo exclusivo ofrece características únicas '
                'y calidad premium. Fabricado con los más altos estándares '
                'de calidad para garantizar durabilidad y rendimiento.',
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.justify,
              ),

              SizedBox(height: 40.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 15.0,
                  ),
                  backgroundColor: Colors.blue[800], // Color del botón
                ),
                onPressed: () {
                  final cartProvider = Provider.of<CartProvider>(
                    context,
                    listen: false,
                  );
                  cartProvider.addItem(productName);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$productName añadido al carrito'),
                      duration: Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      action: SnackBarAction(
                        label: 'DESHACER',
                        onPressed: () {
                          cartProvider.removeLastAdded();
                        },
                      ),
                    ),
                  );

                  Navigator.pop(context);
                },
                child: Text(
                  'Añadir al carrito',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
