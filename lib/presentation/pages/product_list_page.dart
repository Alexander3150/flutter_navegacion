import 'package:flutter/material.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final List<String> products = [
    // Lista final
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

      /**
       * LISTA DE PRODUCTOS:
       * 
       * Muestra los productos en formato de lista desplazable.
       * Cada item es una Card que contiene:
       * - Nombre del producto
       * - Icono indicador de navegación
       */
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return Card(
            margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            child: ListTile(
              title: Text(product, style: TextStyle(fontSize: 18.0)),
              trailing: Icon(Icons.arrow_forward_ios),

              /**
               * NAVEGACIÓN A PANTALLA DE DETALLE:
               * 
               * Al seleccionar un producto, navega a la pantalla de detalle
               * enviando solo el nombre del producto como argumento (String).
               */
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/productDetail',
                  arguments: product, // Solo envía el nombre como String
                );
              },
            ),
          );
        },
      ),
    );
  }
}
