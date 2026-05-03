import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents a registered customer in Firestore.
class UserModel {
  final String id;
  final String email;
  final String name;
  final Timestamp createdAt;

  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.createdAt,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      email: data['email'] as String? ?? '',
      name: data['name'] as String? ?? '',
      createdAt: data['createdAt'] as Timestamp? ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'email': email,
        'name': name,
        'createdAt': createdAt,
      };
}
