import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/product_model.dart';
import '../models/order_model.dart';
import '../models/user_model.dart';
import '../providers.dart';

/// Service for interacting with Firestore and Storage.
class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Collection references.
  // Expose collection refs for direct access when needed.
  CollectionReference get productsRef => _firestore.collection('products');
  CollectionReference get ordersRef => _firestore.collection('orders');
  CollectionReference get usersRef => _firestore.collection('users'); // New collection for customers
  Reference get storageRef => _storage.ref();
  /// Upload product image to Firebase Storage and return download URL.
  Future<String> uploadProductImage(File imageFile, String fileName) async {
    final ref = _storage.ref().child('products').child(fileName);
    await ref.putFile(imageFile);
    return await ref.getDownloadURL();
  }

  /// Add a new product. [imageFile] optional; if provided, uploads it.
  Future<void> addProduct({
    required String name,
    required String brand,
    required double price,
    required List<String> specs,
    required int stock,
    File? imageFile,
  }) async {
    String imageUrl = '';
    if (imageFile != null) {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_${name.replaceAll(' ', '_')}.jpg';
      imageUrl = await uploadProductImage(imageFile, fileName);
    }
    final product = ProductModel(
      id: '',
      name: name,
      brand: brand,
      price: price,
      imageUrl: imageUrl,
      specs: specs,
      rating: 5.0,
      reviewCount: 0,
      stock: stock,
      createdAt: Timestamp.now(),
    );
    await productsRef.add(product.toFirestore());
  }

  /// Update an existing product.
  Future<void> updateProduct(String productId, Map<String, dynamic> data) async {
    await productsRef.doc(productId).update(data);
  }

  /// Delete product and its image (if exists).
  Future<void> deleteProduct(String productId) async {
    // Delete the product document. Image deletion is omitted for simplicity.
    await productsRef.doc(productId).delete();
  }

  /// Stream of products ordered by creation date.
  Stream<List<ProductModel>> getProducts() {
    return productsRef.orderBy('createdAt', descending: true).snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => ProductModel.fromFirestore(doc)).toList(),
        );
  }

  /// Place a new order.
  Future<void> placeOrder(OrderModel order) async {
    await ordersRef.add(order.toFirestore());
  }

  /// Stream of all orders (for admin).
  Stream<List<OrderModel>> getOrders() {
    return ordersRef.orderBy('createdAt', descending: true).snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => OrderModel.fromFirestore(doc)).toList(),
        );
  }

  /// Stream of registered customers.
  Stream<List<UserModel>> getUsers() {
    return usersRef.snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => UserModel.fromFirestore(doc)).toList(),
    );
  }

  /// Delete a customer document.
  Future<void> deleteUser(String userId) async {
    await usersRef.doc(userId).delete();
  }

  /// Cart operations
  DocumentReference _cartDoc(String userId) => _firestore.collection('carts').doc(userId);

  Future<void> saveCart(String userId, List<Map<String, dynamic>> items) async {
    await _cartDoc(userId).set({
      'items': items,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<List<CartItem>> loadCart(String userId) async {
    final doc = await _cartDoc(userId).get();
    if (!doc.exists) return [];
    final data = doc.data() as Map<String, dynamic>;
    final items = data['items'] as List<dynamic>? ?? [];
    return items.map((e) => CartItem(
      id: e['id'] as String,
      name: e['name'] as String,
      imageUrl: e['imageUrl'] as String,
      price: (e['price'] as num).toDouble(),
      quantity: e['quantity'] as int,
    )).toList();
  }

  Future<void> clearCart(String userId) async {
    await _cartDoc(userId).delete();
  }

  /// Update order status.
  Future<void> updateOrderStatus(String orderId, String status) async {
    await ordersRef.doc(orderId).update({'status': status});
  }
}

