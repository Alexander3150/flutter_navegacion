import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_navegacion/presentation/pages/product_detail_page.dart';
import 'package:flutter_navegacion/presentation/pages/product_list_page.dart';
import 'package:flutter_navegacion/presentation/pages/cart_page.dart';
import 'package:flutter_navegacion/presentation/providers/cart_provider.dart';

void main() {
  // Inicializa la aplicación envolviéndola con el ChangeNotifierProvider
  // Esto hace que CartProvider esté disponible en toda el árbol de widgets
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(), // Crea una instancia de CartProvider
      child: MyApp(), // Widget raíz de la aplicación
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Productos Ficticios',
      debugShowCheckedModeBanner: false, // Oculta la banda de debug
      theme: ThemeData(
        primarySwatch: Colors.blue, // Color principal de la aplicación
        visualDensity:
            VisualDensity.adaptivePlatformDensity, // Densidad visual adaptable
      ),
      home: MainTabScreen(), // Pantalla inicial con el sistema de tabs
      routes: {
        // Ruta con nombre para la página de detalle de producto
        '/productDetail': (context) => ProductDetailPage(),
      },
    );
  }
}

class MainTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack mantiene el estado de las pantallas al cambiar de tab
      body: IndexedStack(
        // Obtiene el índice actual del tab usando select para optimización
        index: context.select<CartProvider, int>(
          (provider) => provider.currentTabIndex,
        ),
        // Las dos pantallas principales de la aplicación
        children: [
          ProductListPage(), // Página de lista de productos
          CartPage(), // Página del carrito
        ],
      ),
      // Barra de navegación inferior
      bottomNavigationBar: BottomNavigationBar(
        // Índice actual obtenido del provider (watch para escuchar cambios)
        currentIndex: context.watch<CartProvider>().currentTabIndex,
        // Al tocar un tab, actualiza el estado en el provider
        onTap: (index) => context.read<CartProvider>().changeTab(index),
        // Items de la barra de navegación
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Productos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrito',
          ),
        ],
      ),
    );
  }
}
