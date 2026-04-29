import 'package:flutter_riverpod/flutter_riverpod.dart';

// Cart Provider
class CartItem {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  CartItem copyWith({
    String? id,
    String? name,
    String? imageUrl,
    double? price,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addItem(CartItem item) {
    final existingIndex =
        state.indexWhere((cartItem) => cartItem.id == item.id);
    if (existingIndex >= 0) {
      final existingItem = state[existingIndex];
      state = [
        ...state.sublist(0, existingIndex),
        existingItem.copyWith(quantity: existingItem.quantity + item.quantity),
        ...state.sublist(existingIndex + 1),
      ];
    } else {
      state = [...state, item];
    }
  }

  void removeItem(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  void updateQuantity(String id, int quantity) {
    if (quantity <= 0) {
      removeItem(id);
      return;
    }
    final index = state.indexWhere((item) => item.id == id);
    if (index >= 0) {
      final item = state[index];
      state = [
        ...state.sublist(0, index),
        item.copyWith(quantity: quantity),
        ...state.sublist(index + 1),
      ];
    }
  }

  void clearCart() {
    state = [];
  }

  double get totalPrice {
    return state.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  int get itemCount {
    return state.fold(0, (sum, item) => sum + item.quantity);
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

// Wishlist Provider
class WishlistNotifier extends StateNotifier<Set<String>> {
  WishlistNotifier() : super({});

  void toggleItem(String productId) {
    if (state.contains(productId)) {
      state = {...state}..remove(productId);
    } else {
      state = {...state}..add(productId);
    }
  }

  bool isInWishlist(String productId) {
    return state.contains(productId);
  }
}

final wishlistProvider =
    StateNotifierProvider<WishlistNotifier, Set<String>>((ref) {
  return WishlistNotifier();
});

// User Provider
class User {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
  });
}

final userProvider = StateProvider<User?>((ref) => null);

// Products Provider
class Product {
  final String id;
  final String name;
  final String brand;
  final double price;
  final String imageUrl;
  final List<String> specs;
  final double rating;
  final int reviewCount;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.imageUrl,
    required this.specs,
    required this.rating,
    required this.reviewCount,
  });
}

final productsProvider = StateProvider<List<Product>>((ref) => [
      Product(
        id: '1',
        name: 'NeuralEdge Workstation Pro X1',
        brand: 'QuantumLogic',
        price: 3299.00,
        imageUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuCVWTeZ03XoXpgUYvPpz9EVzT8WNVqOIhQ5TIzMaFsrg2qg1W1ct6Qg-hnnzCUSlsKNhbuI69PgxlOE9J6FzPTCyKPSQP6W_gSZGll7-4T6VMWhMH5aSbZE7CJXeU1mvqYTkyIZscSP0eP6dvheKH9-hcpnXf2y-rP462ZY3Mht0NBXTPiUjawWPFU5tBfcJCk0KxeXZHaWq2K7T0LZKNLUjs6k7Ux4wAqxV82d8kcrJRC_TPUWIyXSUyFuEAJRtpEYlWp5FrmBipE',
        specs: ['64GB RAM', 'RTX 4090'],
        rating: 4.9,
        reviewCount: 1280,
      ),
      Product(
        id: '2',
        name: 'Quantum X17 Pro Elite',
        brand: 'QuantumLogic',
        price: 3499.99,
        imageUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuDTUGCAeAm6ulVRNaCNcVkqZ94TLJ5QIWROkxzftxXQA0dd4UGdYWxAeLohLSFPnh2MYzy5195ovipQgVwKxGhqhzVmpY6cOMltCb-uIDQKhbME0jNUBSRhhHA-JwnhzfhnDbdq9vg1Gl_i730r3q-rypLmaEqX2DfqEqv4C1nH9qA9neJm5l2MkMKLxB8LeJeAp5SFqKxg3nhVkZqqRNLeLUWiRXA1B8L1Uz-chAnDZlRYR15WJXnlgaxjCP0XDjwJ2rTlAufmipc',
        specs: ['RTX 4090', 'i9-13980HX', '64GB DDR5'],
        rating: 4.9,
        reviewCount: 1280,
      ),
    ]);
