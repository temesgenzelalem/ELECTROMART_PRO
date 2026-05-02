import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents a product stored in Firestore.
class ProductModel {
  final String id;
  final String name;
  final String brand;
  final double price;
  final String imageUrl;
  final List<String> specs;
  final double rating;
  final int reviewCount;
  final int stock;
  final Timestamp createdAt;

  const ProductModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.imageUrl,
    required this.specs,
    required this.rating,
    required this.reviewCount,
    required this.stock,
    required this.createdAt,
  });

  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductModel(
      id: doc.id,
      name: data['name'] as String,
      brand: data['brand'] as String,
      price: (data['price'] as num).toDouble(),
      imageUrl: data['imageUrl'] as String,
      specs: List<String>.from(data['specs'] ?? []),
      rating: (data['rating'] as num).toDouble(),
      reviewCount: data['reviewCount'] as int? ?? 0,
      stock: data['stock'] as int? ?? 0,
      createdAt: data['createdAt'] as Timestamp? ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'name': name,
        'brand': brand,
        'price': price,
        'imageUrl': imageUrl,
        'specs': specs,
        'rating': rating,
        'reviewCount': reviewCount,
        'stock': stock,
        'createdAt': createdAt,
      };
}
