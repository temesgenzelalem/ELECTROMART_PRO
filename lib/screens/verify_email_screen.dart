import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:go_router/go_router.dart';

class VerifyEmailScreen extends ConsumerStatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  ConsumerState<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends ConsumerState<VerifyEmailScreen> {
  late Timer _timer;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _checkVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // User signed out
      _timer.cancel();
      if (mounted) context.go('/login');
      return;
    }
    // Reload user to get fresh emailVerified status from server
    await user.reload();
    final refreshedUser = FirebaseAuth.instance.currentUser;
    if (refreshedUser != null && refreshedUser.emailVerified) {
      // Email is verified - redirect to login page
      _timer.cancel();
      // Sign out so user must login with credentials
      await FirebaseAuth.instance.signOut();
      if (mounted) context.go('/login');
    } else {
      // Not verified yet - check again in 3 seconds
      _timer = Timer(const Duration(seconds: 3), _checkVerification);
    }
  }

  @override
  void initState() {
    super.initState();
    _checkVerification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF031427),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.verified_user, color: Colors.green, size: 64),
                  const SizedBox(height: 32),
                  const Text(
                    'Please Verify Your Email',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'We sent a verification email to your inbox.',
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () async {
                      // Resend verification email
                      final user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        await user.sendEmailVerification();
                      }
                    },
                    child: const Text(
                      'Resend Verification Email',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}