import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  bool _signupSuccess = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirm = _confirmController.text;

    if (password != confirm) {
      setState(() {
        _errorMessage = 'Passwords do not match';
        _isLoading = false;
      });
      return;
    }
    if (password.length < 8) {
      setState(() {
        _errorMessage = 'Password must be at least 8 characters';
        _isLoading = false;
      });
      return;
    }

    try {
      await ref
          .read(authServiceProvider)
          .signUpCustomer(email: email, password: password);
      setState(() {
        _signupSuccess = true;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Sign up failed: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF031427),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha:0.6),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withValues(alpha:0.1)),
            ),
            child: _signupSuccess
                ? _buildSuccess()
                : _buildSignUpForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccess() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 64),
        const SizedBox(height: 16),
        Text(
          'Verification email sent!',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(
          'Please check your email and verify before logging in.',
          style: TextStyle(color: Colors.grey[400]),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => context.go('/login'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'BACK TO LOGIN',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.person_add, color: Colors.blue[400], size: 48),
        const SizedBox(height: 16),
        Text(
          'Create Customer Account',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 32),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(color: Colors.grey[400]),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade700),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.circular(12),
            ),
            fillColor: Colors.black.withValues(alpha:0.3),
            filled: true,
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _passwordController,
          obscureText: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'Password (min 8 chars)',
            labelStyle: TextStyle(color: Colors.grey[400]),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade700),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.circular(12),
            ),
            fillColor: Colors.black.withValues(alpha:0.3),
            filled: true,
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _confirmController,
          obscureText: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            labelStyle: TextStyle(color: Colors.grey[400]),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade700),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.circular(12),
            ),
            fillColor: Colors.black.withValues(alpha:0.3),
            filled: true,
          ),
        ),
        if (_errorMessage != null) ...[
          const SizedBox(height: 12),
          Text(
            _errorMessage!,
            style: const TextStyle(color: Colors.red),
          ),
        ],
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _signUp,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: _isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text(
                    'SIGN UP',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () => context.go('/login'),
          child: Text(
            'Already have an account? Log in',
            style: TextStyle(color: Colors.blue[300]),
          ),
        ),
      ],
    );
  }
}
