import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents an order placed by a customer.
class OrderModel {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final double total;
  final String status; // e.g., 'pending', 'processing', 'shipped', 'delivered'
  final String paymentStatus; // 'pending', 'processing', 'success', 'failed'
  final String transactionId; // Generated transaction ID
  final Timestamp createdAt;
  final Timestamp? paymentCompletedAt; // Timestamp for payment completion

  const OrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.total,
    required this.status,
    required this.paymentStatus,
    required this.transactionId,
    required this.createdAt,
    this.paymentCompletedAt,
  });

  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OrderModel(
      id: doc.id,
      userId: data['userId'] as String,
      items: (data['items'] as List<dynamic>)
          .map((e) => OrderItem.fromMap(e as Map<String, dynamic>))
          .toList(),
      total: (data['total'] as num).toDouble(),
      status: data['status'] as String,
      paymentStatus: data['paymentStatus'] as String,
      transactionId: data['transactionId'] as String,
      createdAt: data['createdAt'] as Timestamp,
      paymentCompletedAt: data['paymentCompletedAt'] as Timestamp?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'items': items.map((e) => e.toMap()).toList(),
      'total': total,
      'status': status,
      'paymentStatus': paymentStatus,
      'transactionId': transactionId,
      'createdAt': createdAt,
      'paymentCompletedAt': paymentCompletedAt,
    };
  }
}

/// A single item within an order.
class OrderItem {
  final String productId;
  final String name;
  final String imageUrl;
  final double price;
  final int quantity;

  const OrderItem({
    required this.productId,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  factory OrderItem.fromMap(Map<String, dynamic> map) => OrderItem(
        productId: map['productId'] as String,
        name: map['name'] as String,
        imageUrl: map['imageUrl'] as String,
        price: (map['price'] as num).toDouble(),
        quantity: map['quantity'] as int,
      );

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity,
    };
  }
}