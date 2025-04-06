import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /**
     * OBTENCIÓN DEL NOMBRE DEL PRODUCTO:
     * 
     * Recupera el nombre del producto pasado como argumento.
     * Se hace casting directo a String ya que siempre recibiremos
     * un nombre válido de la lista principal.
     */
    final String productName =
        ModalRoute.of(context)?.settings.arguments as String;

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
              // Style
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
              //Imagen de producto prueba
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
              //Justificado mediante Aling.justify
              Text(
                'Descripción detallada del producto $productName. '
                'Este artículo exclusivo ofrece características únicas '
                'y calidad premium. Fabricado con los más altos estándares '
                'de calidad para garantizar durabilidad y rendimiento.',
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
