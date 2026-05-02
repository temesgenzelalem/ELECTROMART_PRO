import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'providers.dart';
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/product_details_screen.dart';
import 'screens/product_listing_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/admin_dashboard.dart';
import 'screens/add_edit_product_screen.dart';
import 'firebase_test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'ElectroMart Pro',
      theme: ThemeData(
        primaryColor: const Color(0xFFBEC6E0),
        scaffoldBackgroundColor: const Color(0xFF031427),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
          surface: const Color(0xFF031427),
        ),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  final isAdmin = ref.watch(isAdminProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isLoggedIn = authState.value != null || isAdmin;
      final isOnLogin = state.matchedLocation == '/login';
      final isOnSignup = state.matchedLocation == '/signup';

      // Not logged in → go to login.
      if (!isLoggedIn && !isOnLogin && !isOnSignup) {
        return '/login';
      }
      // Logged in admin going to login/signup → redirect to admin dashboard.
      if (isLoggedIn && (isOnLogin || isOnSignup) && isAdmin) {
        return '/admin-dashboard';
      }
      // Logged in customer going to login/signup → redirect to home.
      if (isLoggedIn && (isOnLogin || isOnSignup) && !isAdmin) {
        return '/';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/cart',
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        path: '/product-details',
        builder: (context, state) => const ProductDetailsScreen(),
      ),
      GoRoute(
        path: '/products',
        builder: (context, state) => const ProductListingScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/admin-dashboard',
        builder: (context, state) => const AdminDashboard(),
      ),
      GoRoute(
        path: '/add-product',
        builder: (context, state) => const AddEditProductScreen(),
      ),
      GoRoute(
        path: '/edit-product/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return AddEditProductScreen(productId: id);
        },
      ),
      GoRoute(
        path: '/firebase-test',
        builder: (context, state) => const FirebaseTestScreen(),
      ),
    ],
  );
});
