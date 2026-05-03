import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Simple model representing an admin user.
class AdminUser {
  final String email;
  AdminUser(this.email);
}

/// AuthService provides methods for admin and customer authentication.
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Hard‑coded admin credentials.
  static String _adminEmail = 'admin@gmail.com';
  static String _adminPassword = '12345678';

  // Public getters for admin credentials.
  String get adminEmail => _adminEmail;
  String get adminPassword => _adminPassword;

  /// Update admin credentials (email and password).
  /// This is used after the admin logs in and wishes to change their login details.
  Future<void> updateAdminCredentials({required String email, required String password}) async {
    _adminEmail = email;
    _adminPassword = password;
  }

  /// Stream of auth state changes.
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  /// Attempts admin login. Returns an [AdminUser] on success.
  Future<AdminUser?> loginAdmin({required String email, required String password}) async {
    if (email == _adminEmail && password == _adminPassword) {
      // Sign out any existing Firebase user to keep the state clean.
      await _auth.signOut();
      return AdminUser(_adminEmail);
    }
    return null;
  }

  /// Customer login using Firebase Auth.
  /// Requires email verification for customers.
  Future<User?> loginCustomer({required String email, required String password}) async {
    final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
    final user = cred.user;
    if (user != null && user.emailVerified) {
      return user;
    }
    // If email not verified, sign out immediately.
    await _auth.signOut();
    return null;
  }

  /// Customer sign‑up – creates a user and sends verification email.
  Future<User?> signUpCustomer({required String email, required String password}) async {
    final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    final user = cred.user;
    if (user != null) {
      await user.sendEmailVerification();
      // Save user data to Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'email': email,
        'name': '',
        'createdAt': Timestamp.now(),
      });
    }
    return user;
  }

  /// Sign out the current user (admin or customer).
  Future<void> signOut() async => await _auth.signOut();
}
