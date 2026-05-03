import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../providers.dart';
import '../services/stripe_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/order_model.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final user = ref.watch(authStateProvider).value;

    return Scaffold(
      backgroundColor: const Color(0xFF031427),
      appBar: AppBar(
        backgroundColor: Colors.black.withValues(alpha: 0.6),
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
            icon: const Icon(Icons.mic, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
      body: Row(
        children: [
          // Cart Items
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your Cart',
                        style: GoogleFonts.inter(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF26364A),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${cartItems.length} ITEMS',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF4CD7F6),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: cartItems.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.shopping_cart_outlined,
                                    size: 64, color: Colors.grey[700]),
                                const SizedBox(height: 16),
                                Text(
                                  'Your cart is empty',
                                  style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.separated(
                            itemCount: cartItems.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 16),
                            itemBuilder: (context, index) {
                              final item = cartItems[index];
                              return _buildCartItem(item, cartNotifier, ref);
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
          // Summary Sidebar
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Summary',
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildSummaryRow('Subtotal',
                        '\$${cartNotifier.totalPrice.toStringAsFixed(2)}'),
                    _buildSummaryRow('Tax (10%)',
                        '\$${(cartNotifier.totalPrice * 0.10).toStringAsFixed(2)}'),
                    _buildSummaryRow('Shipping', 'FREE', isFree: true),
                    const SizedBox(height: 24),
                    const Divider(color: Color(0x1AFFFFFF)),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'TOTAL',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[400],
                          ),
                        ),
                        Text(
                          '\$${(cartNotifier.totalPrice * 1.10).toStringAsFixed(2)}',
                          style: GoogleFonts.inter(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFADC6FF),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: cartItems.isEmpty || user == null
                            ? null
                            : () => _checkout(context, ref, user.uid),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.lock),
                            const SizedBox(width: 12),
                            Text(
                              'PROCEED TO CHECKOUT',
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        'Secured with 256-bit AES Encryption',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: Colors.grey[400],
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black.withValues(alpha: 0.8),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: 3,
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

  Future<void> _checkout(
      BuildContext context, WidgetRef ref, String userId) async {
    final cartNotifier = ref.read(cartProvider.notifier);
    final items = ref.read(cartProvider);
    final total = cartNotifier.totalPrice * 1.10;

    try {
      // Initialize Stripe (should be called once at app start; we call it here for safety)
      await StripeService.init();

      // Show Stripe payment sheet
      final success = await StripeService.makePayment(total, 'usd');

      if (!success) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Payment was cancelled or failed')),
          );
        }
        return;
      }

      final order = OrderModel(
        id: '',
        userId: userId,
        items: items
            .map((item) => OrderItem(
                  productId: item.id,
                  name: item.name,
                  imageUrl: item.imageUrl,
                  price: item.price,
                  quantity: item.quantity,
                ))
            .toList(),
        total: total,
        status: 'paid',
        paymentStatus: 'completed',
        transactionId: 'pi_${DateTime.now().millisecondsSinceEpoch}',
        createdAt: Timestamp.now(),
        paymentCompletedAt: Timestamp.now(),
      );

      await ref.read(firestoreServiceProvider).placeOrder(order);
      cartNotifier.clearCart();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Payment successful! Order placed.')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Checkout failed: $e')),
        );
      }
    }
  }

  Widget _buildCartItem(
      CartItem item, CartNotifier cartNotifier, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Container(
            width: 128,
            height: 128,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[800],
              image: item.imageUrl.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(item.imageUrl),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: item.imageUrl.isEmpty
                ? const Icon(Icons.image, color: Colors.grey)
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'SKU: ${item.id}',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.grey[400],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove, color: Colors.grey),
                          onPressed: () => cartNotifier
                              .updateQuantity(item.id, item.quantity - 1),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            item.quantity.toString(),
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, color: Colors.grey),
                          onPressed: () => cartNotifier
                              .updateQuantity(item.id, item.quantity + 1),
                        ),
                      ],
                    ),
                    Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFADC6FF),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => cartNotifier.removeItem(item.id),
                  icon: const Icon(Icons.delete_sweep, color: Colors.red),
                  label: Text(
                    'REMOVE',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    side: const BorderSide(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isFree = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.grey[400],
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: isFree ? const Color(0xFF4CD7F6) : Colors.white,
            ),
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
        break;
      case 4:
        context.go('/profile');
        break;
    }
  }
}
