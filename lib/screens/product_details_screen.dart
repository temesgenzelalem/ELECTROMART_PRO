import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers.dart';
import '../models/product_model.dart';

class ProductDetailsScreen extends ConsumerWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsStreamProvider);
    final productId = GoRouterState.of(context).pathParameters['id'];

    if (productId == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF031427),
        body: Center(
          child: Text('Product not found', style: TextStyle(color: Colors.white)),
        ),
      );
    }

    return productsAsync.when(
      data: (products) {
        final product = products.where((p) => p.id == productId).firstOrNull;
        if (product == null) {
          return Scaffold(
            backgroundColor: const Color(0xFF031427),
            appBar: AppBar(backgroundColor: Colors.black.withValues(alpha:0.6)),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.broken_image, size: 64, color: Colors.grey[700]),
                  const SizedBox(height: 16),
                  Text(
                    'Product not found',
                    style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 18),
                  ),
                ],
              ),
            ),
          );
        }
        return _buildDetails(context, ref, product);
      },
      loading: () => const Scaffold(
        backgroundColor: Color(0xFF031427),
        body: Center(child: CircularProgressIndicator(color: Colors.blue)),
      ),
      error: (error, _) => Scaffold(
        backgroundColor: const Color(0xFF031427),
        body: Center(
          child: Text('Error: $error', style: const TextStyle(color: Colors.red)),
        ),
      ),
    );
  }

  Widget _buildDetails(BuildContext context, WidgetRef ref, ProductModel product) {
    return Scaffold(
      backgroundColor: const Color(0xFF031427),
      appBar: AppBar(
        backgroundColor: Colors.black.withValues(alpha:0.6),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'ElectroMart Pro',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.mic, color: Colors.blue),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.blue),
            onPressed: () => context.go('/cart'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[800],
              ),
              child: product.imageUrl.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: product.imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        errorWidget: (_, __, ___) => const Icon(Icons.broken_image),
                      ),
                    )
                  : Center(
                      child: Icon(Icons.image, size: 64, color: Colors.grey[600]),
                    ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CD7F6).withValues(alpha:0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    product.brand.toUpperCase(),
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF4CD7F6),
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellow, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${product.rating} (${product.reviewCount} Reviews)',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              product.name,
              style: GoogleFonts.inter(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            if (product.specs.isNotEmpty)
              Text(
                product.specs.join(' | '),
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Colors.grey[400],
                ),
              ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1B2B3F),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withValues(alpha:0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: product.stock > 0 ? Colors.green : Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        product.stock > 0
                            ? 'In Stock: ${product.stock}'
                            : 'Out of Stock',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: product.stock > 0 ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Specifications',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Product specifications will be loaded from Firestore.',  // In real app, load from product.specs
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.grey[400],
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: product.stock > 0
                ? () {
                    ref.read(cartProvider.notifier).addItem(
                          CartItem(
                            id: product.id,
                            name: product.name,
                            imageUrl: product.imageUrl,
                            price: product.price,
                            quantity: 1,
                          ),
                        );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Added to cart!')),
                    );
                  }
                : null,
            icon: const Icon(Icons.add_shopping_cart),
            label: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                product.stock > 0
                    ? 'ADD TO CART - \$${product.price.toStringAsFixed(2)}'
                    : 'OUT OF STOCK',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black.withValues(alpha:0.8),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: 1,
        onTap: (index) => _handleNavigation(context, index),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              label: Text(ref.watch(cartProvider).length.toString()),
              child: const Icon(Icons.shopping_cart),
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/products');
        break;
      case 2:
        break;
      case 3:
        context.go('/cart');
        break;
      case 4:
        context.go('/profile');
        break;
    }
  }
}
