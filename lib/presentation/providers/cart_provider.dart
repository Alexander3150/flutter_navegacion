import 'package:flutter/material.dart';

/// [CartProvider] es un administrador de estado que maneja:
/// 1. La pestaña actual seleccionada en la navegación inferior
/// 2. Los productos agregados al carrito de compras
///
/// Utiliza el patrón ChangeNotifier para notificar a los widgets
/// cuando ocurren cambios en el estado.
class CartProvider extends ChangeNotifier {
  // ========== VARIABLES DE ESTADO ==========

  /// Índice de la pestaña actual (0 = Productos, 1 = Carrito)
  int _currentTabIndex = 0;

  /// Lista de productos en el carrito.
  /// Cada producto es un mapa con:
  /// - 'name': String (nombre del producto)
  /// - 'quantity': int (cantidad)
  final List<Map<String, dynamic>> _cartItems = [];

  // ========== GETTERS ==========

  /// Obtiene el índice de la pestaña actual (solo lectura)
  int get currentTabIndex => _currentTabIndex;

  /// Obtiene una copia de la lista de productos del carrito (solo lectura)
  List<Map<String, dynamic>> get cartItems => List.from(_cartItems);

  // ========== MÉTODOS PÚBLICOS ==========

  /// Cambia la pestaña seleccionada y notifica a los listeners
  /// [index]: 0 para Productos, 1 para Carrito
  void changeTab(int index) {
    if (_currentTabIndex != index) {
      _currentTabIndex = index;
      // Notifica a todos los widgets que escuchan este provider
      notifyListeners();
    }
  }

  /// Agrega un producto al carrito o incrementa su cantidad si ya existe
  /// [productName]: Nombre del producto a agregar
  void addItem(String productName) {
    // Busca si el producto ya existe en el carrito
    final existingIndex = _cartItems.indexWhere(
      (item) => item['name'] == productName,
    );

    if (existingIndex >= 0) {
      // Si existe, incrementa la cantidad
      _cartItems[existingIndex]['quantity']++;
    } else {
      // Si no existe, lo agrega con cantidad 1
      _cartItems.add({'name': productName, 'quantity': 1});
    }
    // Notifica a los widgets sobre el cambio
    notifyListeners();
  }

  /// Elimina un producto del carrito por su índice
  /// [index]: Posición del producto en la lista
  void removeItem(int index) {
    if (index >= 0 && index < _cartItems.length) {
      _cartItems.removeAt(index);
      notifyListeners();
    }
  }

  /// Vacía completamente el carrito
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
