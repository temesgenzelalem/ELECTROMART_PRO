import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers.dart';
import '../models/product_model.dart';

class ProductListingScreen extends ConsumerWidget {
  const ProductListingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsStreamProvider);
    final cartItems = ref.watch(cartProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF031427),
      appBar: AppBar(
        backgroundColor: Colors.black.withValues(alpha:0.6),
        title: Row(
          children: [
            Icon(Icons.bolt, color: Colors.blue[400]),
            const SizedBox(width: 8),
            Text(
              'ElectroMart Pro',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.grey),
            onPressed: () {},
          ),
          const CircleAvatar(
            backgroundColor: Color(0xFF0566D9),
            child: Icon(Icons.person, color: Colors.white, size: 16),
          ),
        ],
      ),
      body: productsAsync.when(
        data: (products) => _buildContent(context, ref, products, cartItems),
        loading: () => const Center(
          child: CircularProgressIndicator(color: Colors.blue),
        ),
        error: (error, _) => Center(
          child: Text(
            'Error: $error',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
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
              label: Text(cartItems.length.toString()),
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

  Widget _buildContent(BuildContext context, WidgetRef ref,
      List<ProductModel> products, List<dynamic> cartItems) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'All Products',
            style: GoogleFonts.inter(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${products.length} high-performance units available',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: products.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.grey[700]),
                        const SizedBox(height: 16),
                        Text(
                          'No products found',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return _buildProductCard(context, ref, product);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, WidgetRef ref, ProductModel product) {
    return GestureDetector(
      onTap: () => context.go('/product-details?id=${product.id}'),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0B1C30),
          border: Border.all(color: Colors.white.withValues(alpha:0.1)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(16)),
                      image: product.imageUrl.isNotEmpty
                          ? DecorationImage(
                              image: CachedNetworkImageProvider(product.imageUrl),
                              fit: BoxFit.cover,
                            )
                          : null,
                      color: product.imageUrl.isEmpty ? Colors.grey[800] : null,
                    ),
                    child: product.imageUrl.isEmpty
                        ? Center(
                            child: Icon(Icons.image, color: Colors.grey[600], size: 40),
                          )
                        : null,
                  ),
                  const Positioned(
                    top: 8,
                    right: 8,
                    child: _FavoriteButton(),
                  ),
                  if (product.stock > 0)
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'In Stock: ${product.stock}',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.brand.toUpperCase(),
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[400],
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.name,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(0)}',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
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
                        },
                        icon: const Icon(Icons.add_shopping_cart,
                            color: Colors.blue, size: 20),
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
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

class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha:0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Icon(Icons.favorite_border, color: Colors.white, size: 16),
    );
  }
}
