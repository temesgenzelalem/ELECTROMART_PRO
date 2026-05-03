import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/auth_service.dart';
import 'services/firestore_service.dart';
import 'models/product_model.dart';
import 'models/order_model.dart';
import 'models/user_model.dart';

// ── Services ────────────────────────────────────────────────────────────────
final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final firestoreServiceProvider =
    Provider<FirestoreService>((ref) => FirestoreService());

// ── Auth state ──────────────────────────────────────────────────────────────
/// Firebase user stream (null if signed out).
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges();
});

/// Admin user state (null if not logged in as admin).
final adminUserProvider = StateProvider<AdminUser?>((ref) => null);

/// True if the current user is the hardcoded admin.
final isAdminProvider = Provider<bool>((ref) {
  return ref.watch(adminUserProvider) != null;
});

// ── Product stream ───────────────────────────────────────────────────────────
final productsStreamProvider = StreamProvider<List<ProductModel>>((ref) {
  return ref.watch(firestoreServiceProvider).getProducts();
});

// ── Orders stream (admin) ──────────────────────────────────────────────────
final ordersStreamProvider = StreamProvider<List<OrderModel>>((ref) {
  return ref.watch(firestoreServiceProvider).getOrders();
});

  // Stream of registered customers.
final usersStreamProvider = StreamProvider<List<UserModel>>((ref) {
  return ref.watch(firestoreServiceProvider).getUsers();
});

// ── Cart Provider ───────────────────────────────────────────────────────────
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
    final existingIndex = state.indexWhere((cartItem) => cartItem.id == item.id);
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

final cartProvider =
    StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

// ── Wishlist Provider ───────────────────────────────────────────────────────
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

// ── Search Query Provider ───────────────────────────────────────────────
final searchQueryProvider = StateProvider<String>((ref) => '');
