import 'package:flutter/material.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  // Lista de productos disponibles
  final List<String> products = [
    'Camiseta Reactiva',
    'Zapatos Voladores',
    'Gorra Inteligente',
    'Camisa Blindada',
    'Pantalones Anti-Gravedad',
    'Reloj Multidimensional',
    'Anillo del Infinito',
    'Guantelete de Thanos',
    'Escudo del Capitán América',
    'Martillo de Thor',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Productos Ficticios'), centerTitle: true),

      // ListView.builder es eficiente para listas largas (renderiza solo lo visible)
      body: ListView.builder(
        itemCount: products.length, // Total de productos
        itemBuilder: (context, index) {
          // Obtiene el producto actual basado en el índice
          final product = products[index];

          return Card(
            // Margen alrededor de cada Card
            margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            child: ListTile(
              // Nombre del producto
              title: Text(product, style: TextStyle(fontSize: 18.0)),
              // Icono indicador de navegación
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navega a la página de detalle del producto
                Navigator.pushNamed(
                  context,
                  '/productDetail', // Ruta definida en MaterialApp
                  arguments:
                      product, // Envía el nombre del producto como argumento
                );
              },
            ),
          );
        },
      ),
    );
  }
}
