import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'firebase_options.dart';

class FirebaseTestScreen extends StatefulWidget {
  const FirebaseTestScreen({super.key});

  @override
  State<FirebaseTestScreen> createState() => _FirebaseTestScreenState();
}

class _FirebaseTestScreenState extends State<FirebaseTestScreen> {
  String firebaseStatus = 'Checking...';
  String authStatus = 'Checking...';
  String firestoreStatus = 'Checking...';
  String storageStatus = 'Checking...';

  @override
  void initState() {
    super.initState();
    _checkFirebaseStatus();
  }

  Future<void> _checkFirebaseStatus() async {
    try {
      // 1. Check Firebase Initialization
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      setState(() => firebaseStatus = '✅ Initialized Successfully');

      // 2. Check Auth
      final auth = FirebaseAuth.instance;
      auth.authStateChanges().listen((user) {
        setState(() => authStatus = user != null ? '✅ User logged in: ${user.email}' : '✅ Auth ready (No user)');
      });

      // 3. Check Firestore
      final firestore = FirebaseFirestore.instance;
      // Create a test document
      await firestore.collection('test').doc('check').set({
        'timestamp': DateTime.now(),
        'test': 'firebase_connection_test'
      }).then((_) async {
        // Read it back
        final doc = await firestore.collection('test').doc('check').get();
        if (doc.exists && doc.data()?['test'] == 'firebase_connection_test') {
          setState(() => firestoreStatus = '✅ Firestore Working');
          // Clean up
          await firestore.collection('test').doc('check').delete();
        }
      });

      // 4. Check Storage
      final storage = FirebaseStorage.instance;
      final ref = storage.ref().child('test/check.txt');
      await ref.putString('test').then((_) async {
        await ref.delete();
        setState(() => storageStatus = '✅ Storage Working');
      });

    } catch (e) {
      setState(() {
        firebaseStatus = '❌ Error: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firebase Status Check')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildStatusCard('Firebase Core', firebaseStatus),
            const SizedBox(height: 16),
            _buildStatusCard('Authentication', authStatus),
            const SizedBox(height: 16),
            _buildStatusCard('Firestore', firestoreStatus),
            const SizedBox(height: 16),
            _buildStatusCard('Storage', storageStatus),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(String title, String status) {
    final bool isWorking = status.startsWith('✅');
    return Card(
      child: ListTile(
        leading: Icon(
          isWorking ? Icons.check_circle : Icons.error,
          color: isWorking ? Colors.green : Colors.red,
        ),
        title: Text(title),
        subtitle: Text(status),
      ),
    );
  }
}