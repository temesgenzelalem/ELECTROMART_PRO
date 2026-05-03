import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers.dart';
import '../models/product_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsStreamProvider);
    final cartItems = ref.watch(cartProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF031427),
      appBar: AppBar(
        backgroundColor: Colors.black.withValues(alpha:0.6),
        elevation: 0,
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
            icon: const Icon(Icons.notifications, color: Colors.grey),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.grey),
            onPressed: () => context.go('/products'),
          ),
          Badge(
            label: Text(cartItems.length.toString()),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.grey),
              onPressed: () => context.go('/cart'),
            ),
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
            'Error loading products: $error',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black.withValues(alpha:0.8),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
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
    return SingleChildScrollView(
      child: Column(
        children: [
          // Banner Section
          Container(
            height: 200,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              image: const DecorationImage(
                image: NetworkImage(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuB5xjiG9H8JO7flNmiDEaR_zsyRJ9SfQVCUyWKS0o9TKs6XEcLibersio-v-nfOE025Wvvl9F3eG0fpfj-FJsTPKJ_f-al7z2rnvVJ8qEjf8nXdloIYxPPeACMxDEwc6swPkZfdtu2JjTBLIUDeOmbEI8rBqQbnjP-zLEDqEUKsi-Uod09vOjbVbV4JiAdUj0rmyDOjaPxUnO-OW6r8ulfYS9aL5mjgq0MDXXLyapOZLDuRiTXC2O_cWvlDELDv974G_r7ukNN5otc'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withValues(alpha:0.6), Colors.transparent],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0566D9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'NEW ARRIVAL',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'The Precision X1 Series.',
                    style: GoogleFonts.inter(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Uncompromising performance for engineering workflows. Pre-order now for priority shipping.',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => context.go('/products'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Explore Specifications',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Flash Sale
          _buildFlashSale(context, ref, products),
          // Products Grid
          _buildProductsGrid(context, ref, products),
        ],
      ),
    );
  }

  Widget _buildFlashSale(BuildContext context, WidgetRef ref,
      List<ProductModel> products) {
    final flashProducts = products.take(3).toList();
    if (flashProducts.isEmpty) return const SizedBox.shrink();

    return Container(
      color: Colors.black.withValues(alpha:0.1),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Flash Sale',
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Row(
                    children: [
                      const Icon(Icons.schedule,
                          color: Color(0xFF4CD7F6), size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '02:45:12',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF4CD7F6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              TextButton(
                onPressed: () => context.go('/products'),
                child: Text(
                  'View All',
                  style: GoogleFonts.inter(
                    color: const Color(0xFFADC6FF),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: flashProducts.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final product = flashProducts[index];
                return _buildFlashSaleItem(context, ref, product);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlashSaleItem(
      BuildContext context, WidgetRef ref, ProductModel product) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha:0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha:0.1)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: product.imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: product.imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => const Center(
                          child: CircularProgressIndicator(strokeWidth: 2)),
                      errorWidget: (_, __, ___) => Container(
                        color: Colors.grey[800],
                        child: const Icon(Icons.broken_image, color: Colors.grey),
                      ),
                    )
                  : Container(
                      color: Colors.grey[800],
                      child: const Icon(Icons.image, color: Colors.grey),
                    ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            product.name,
            style: GoogleFonts.inter(
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
                '\$${product.price.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF4CD7F6),
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF0566D9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: const Icon(Icons.add_shopping_cart,
                      color: Colors.white, size: 20),
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductsGrid(
      BuildContext context, WidgetRef ref, List<ProductModel> products) {
    if (products.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Icon(Icons.shopping_bag_outlined, size: 64, color: Colors.grey[700]),
            const SizedBox(height: 16),
            Text(
              'No products yet',
              style: GoogleFonts.inter(fontSize: 18, color: Colors.grey[400]),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'All Products',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
        ],
      ),
    );
  }

  Widget _buildProductCard(
      BuildContext context, WidgetRef ref, ProductModel product) {
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
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha:0.8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.favorite_border,
                          color: Colors.white, size: 16),
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
