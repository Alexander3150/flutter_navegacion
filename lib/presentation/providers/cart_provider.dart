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
  /// - 'image': String (ruta de la imagen)
  /// - 'addedAt': DateTime (fecha/hora de agregado)
  final List<Map<String, dynamic>> _cartItems = [];

  // ========== GETTERS ==========

  /// Obtiene el índice de la pestaña actual (solo lectura)
  int get currentTabIndex => _currentTabIndex;

  /// Obtiene una copia de la lista de productos del carrito (solo lectura)
  List<Map<String, dynamic>> get cartItems => List.from(_cartItems);

  /// Obtiene el total de items en el carrito (suma de cantidades)
  int get totalItems =>
      _cartItems.fold(0, (sum, item) => sum + (item['quantity'] as int));

  /// Obtiene el último producto añadido
  Map<String, dynamic>? get lastAdded =>
      _cartItems.isNotEmpty ? _cartItems.last : null;

  // ========== MÉTODOS PÚBLICOS ==========

  /// Cambia la pestaña seleccionada y notifica a los listeners
  /// [index]: 0 para Productos, 1 para Carrito
  void changeTab(int index) {
    if (_currentTabIndex != index) {
      _currentTabIndex = index;
      notifyListeners();
    }
  }

  /// Agrega un producto al carrito o incrementa su cantidad si ya existe
  /// [productName]: Nombre del producto a agregar
  /// [imagePath]: Ruta de la imagen del producto
  void addItem(String productName, {String? imagePath}) {
    final existingIndex = _cartItems.indexWhere(
      (item) => item['name'] == productName,
    );

    if (existingIndex >= 0) {
      _cartItems[existingIndex]['quantity']++;
    } else {
      _cartItems.add({
        'name': productName,
        'quantity': 1,
        'image': imagePath,
        'addedAt': DateTime.now(),
      });
    }
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

  /// Elimina el último producto añadido al carrito
  void removeLastAdded() {
    if (_cartItems.isNotEmpty) {
      _cartItems.removeLast();
      notifyListeners();
    }
  }

  /// Vacía completamente el carrito
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  /// Actualiza la cantidad de un producto específico
  /// [index]: Posición del producto en la lista
  /// [newQuantity]: Nueva cantidad (debe ser al menos 1)
  void updateQuantity(int index, int newQuantity) {
    if (index >= 0 && index < _cartItems.length && newQuantity >= 1) {
      _cartItems[index]['quantity'] = newQuantity;
      notifyListeners();
    }
  }

  /// Verifica si un producto ya existe en el carrito
  bool containsProduct(String productName) {
    return _cartItems.any((item) => item['name'] == productName);
  }
}
