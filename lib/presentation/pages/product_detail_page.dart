import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_navegacion/presentation/providers/cart_provider.dart';

class ProductDetailPage extends StatelessWidget {
  // Método privado para convertir nombres de productos a rutas de imágenes
  String _getImagePath(String productName) {
    // Convierte el nombre del producto a un formato válido para nombres de archivo:
    // 1. Convierte a minúsculas
    // 2. Reemplaza espacios por guiones bajos
    // 3. Elimina acentos y caracteres especiales
    return 'assets/images/${productName.toLowerCase().replaceAll(' ', '_') // Espacios a guiones bajos
    .replaceAll('á', 'a') // Elimina acentos
    .replaceAll('é', 'e').replaceAll('í', 'i').replaceAll('ó', 'o').replaceAll('ú', 'u').replaceAll('ñ', 'n') // ñ a n
    .replaceAll('-', '') // Elimina guiones
    }.png'; // Agrega extensión .png
  }

  @override
  Widget build(BuildContext context) {
    // Obtiene el nombre del producto pasado como argumento de navegación
    final String productName =
        ModalRoute.of(context)?.settings.arguments as String;
    // Genera la ruta de la imagen usando el método _getImagePath
    final imagePath = _getImagePath(productName);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Producto'),
        leading: IconButton(
          // Botón de retroceso
          icon: const Icon(Icons.arrow_back),
          onPressed:
              () => Navigator.pop(context), // Navega a la pantalla anterior
        ),
      ),
      // SingleChildScrollView permite desplazamiento si el contenido es muy largo
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Espaciado interno general
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Nombre del producto
              Text(
                productName,
                style: const TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20.0), // Espaciador
              // Contenedor para la imagen del producto
              Container(
                height: 250.0, // Altura fija
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ), // Bordes redondeados
                ),
                // Widget de imagen con manejo de errores
                child: Image.asset(
                  imagePath, // Ruta generada dinámicamente
                  fit:
                      BoxFit
                          .contain, // Ajusta la imagen manteniendo proporciones
                  errorBuilder: (context, error, stackTrace) {
                    // Si hay error cargando la imagen, muestra:
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icono de error
                        Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(height: 10), // Espaciador
                        // Imagen por defecto
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

              const SizedBox(height: 30.0), // Espaciador
              // Descripción del producto
              Text(
                'Descripción detallada del producto $productName. '
                'Este artículo exclusivo ofrece características únicas '
                'y calidad premium. Fabricado con los más altos estándares '
                'de calidad para garantizar durabilidad y rendimiento.',
                style: const TextStyle(fontSize: 16.0),
                textAlign: TextAlign.justify, // Texto justificado
              ),

              const SizedBox(height: 40.0), // Espaciador
              // Botón para añadir al carrito
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, // Espaciado horizontal interno
                    vertical: 15.0, // Espaciado vertical interno
                  ),
                  backgroundColor: const Color.fromARGB(
                    255,
                    228,
                    180,
                    21,
                  ), // Color de fondo
                ),
                onPressed: () {
                  // Acción al presionar el botón:
                  // 1. Obtiene el CartProvider
                  final cartProvider = Provider.of<CartProvider>(
                    context,
                    listen: false,
                  );
                  // 2. Añade el producto al carrito (con nombre y ruta de imagen)
                  cartProvider.addItem(productName, imagePath);

                  // 3. Muestra un SnackBar de confirmación
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$productName añadido al carrito'),
                      duration: const Duration(
                        seconds: 2,
                      ), // Duración 2 segundos
                      behavior: SnackBarBehavior.floating, // Flotante
                      action: SnackBarAction(
                        // Acción "DESHACER"
                        label: 'DESHACER',
                        onPressed: () {
                          cartProvider
                              .removeLastAdded(); // Elimina el último añadido
                        },
                      ),
                    ),
                  );

                  // 4. Regresa a la pantalla anterior
                  Navigator.pop(context);
                },
                child: const Text(
                  'Añadir al carrito',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white, // Texto blanco
                    fontWeight: FontWeight.bold, // Negrita
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
