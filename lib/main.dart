import 'package:flutter/material.dart';
import 'package:flutter_navegacion/presentation/pages/product_detail_page.dart';
import 'package:flutter_navegacion/presentation/pages/product_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Productos Ficticios',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ProductListPage(), // Pantalla inicial Lista de productos
      routes: {
        '/productDetail':
            (context) => ProductDetailPage(), // Ruta para detalles
      },
    );
  }
}
