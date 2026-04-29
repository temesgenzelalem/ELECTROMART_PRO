import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF031427),
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.6),
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
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
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
                    colors: [Colors.black.withOpacity(0.6), Colors.transparent],
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
                      onPressed: () {
                        // Add sample product to cart
                        ref.read(cartProvider.notifier).addItem(CartItem(
                              id: 'sample-1',
                              name: 'Precision X1 Series',
                              imageUrl:
                                  'https://lh3.googleusercontent.com/aida-public/AB6AXuB5xjiG9H8JO7flNmiDEaR_zsyRJ9SfQVCUyWKS0o9TKs6XEcLibersio-v-nfOE025Wvvl9F3eG0fpfj-FJsTPKJ_f-al7z2rnvVJ8qEjf8nXdloIYxPPeACMxDEwc6swPkZfdtu2JjTBLIUDeOmbEI8rBqQbnjP-zLEDqEUKsi-Uod09vOjbVbV4JiAdUj0rmyDOjaPxUnO-OW6r8ulfYS9aL5mjgq0MDXXLyapOZLDuRiTXC2O_cWvlDELDv974G_r7ukNN5otc',
                              price: 2999.00,
                              quantity: 1,
                            ));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added to cart!')),
                        );
                      },
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
            // Categories Grid
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'System Verticals',
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildCategoryItem(Icons.smartphone, 'Smartphones'),
                      _buildCategoryItem(Icons.laptop, 'Laptops'),
                      _buildCategoryItem(Icons.headphones, 'Audio'),
                      _buildCategoryItem(Icons.watch, 'Wearables'),
                      _buildCategoryItem(Icons.monitor, 'Displays'),
                      _buildCategoryItem(Icons.developer_board, 'Components'),
                    ],
                  ),
                ],
              ),
            ),
            // Flash Sale
            Container(
              color: Colors.black.withOpacity(0.1),
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
                            'Flash Assets',
                            style: GoogleFonts.inter(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Row(
                            children: [
                              Icon(Icons.schedule,
                                  color: const Color(0xFF4CD7F6), size: 16),
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
                        onPressed: () {},
                        child: Text(
                          'View All Clearances',
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
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildFlashSaleItem(
                          'ProStream H3 Wireless',
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuC8mX9d-rzJ_uHuhofKCQofVpFLAthkSqIxcBZi0vYTmZdESHIfNvE84jQCpl-1_meG_q1w3Oydb-oWJSrbiq2ctOhsPT_awSfw2Iy6-uqE2GFB4m3Jo6JdwNshsMjzaeUz6AOCQfvucej_aHUOTrRVgFXR_eh83O36hO_S5i3q24sTAeSGnk6ZM-4Pz9B9Dd-aOP0i78JuWWzII7ouNpIBkwQDS9GN54RZshZeOvpf_4SBWN2FGBA6FsitXFC2jruwDoBbcPTiWPQ',
                          299.00,
                          399.00,
                          25,
                          () {
                            ref.read(cartProvider.notifier).addItem(CartItem(
                                  id: 'flash-prostream',
                                  name: 'ProStream H3 Wireless',
                                  imageUrl:
                                      'https://lh3.googleusercontent.com/aida-public/AB6AXuC8mX9d-rzJ_uHuhofKCQofVpFLAthkSqIxcBZi0vYTmZdESHIfNvE84jQCpl-1_meG_q1w3Oydb-oWJSrbiq2ctOhsPT_awSfw2Iy6-uqE2GFB4m3Jo6JdwNshsMjzaeUz6AOCQfvucej_aHUOTrRVgFXR_eh83O36hO_S5i3q24sTAeSGnk6ZM-4Pz9B9Dd-aOP0i78JuWWzII7ouNpIBkwQDS9GN54RZshZeOvpf_4SBWN2FGBA6FsitXFC2jruwDoBbcPTiWPQ',
                                  price: 299.00,
                                  quantity: 1,
                                ));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Added to cart!')),
                            );
                          },
                        ),
                        _buildFlashSaleItem(
                          'Creative Pro Pad 12"',
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuA5deOCi3ZTcwxAAfTCfO2EsfBgA3qg1kVMJtOrkSJl-mYWFAeeODji7b-hurvz2dqCFMmpYcRdjFCW28n_nyPTVrrHlEtGr952xTsrlYnulx7ZjSJQ9kW0YW5CuYimoFvC6Pu5hXtm12YQrp_L38WZWQjjH5sPrRWGAvnQyfMYnTxHA8Z2dOhB8JkIN_eDS0fApqZfLrzAAPtcMAa9gCaNiwo2QVoy5z3lfo30II06KouSwEViD7E92Uv_P63mem0vhrXRtqVdFzk',
                          849.00,
                          999.00,
                          15,
                          () {
                            ref.read(cartProvider.notifier).addItem(CartItem(
                                  id: 'flash-creative-pad',
                                  name: 'Creative Pro Pad 12"',
                                  imageUrl:
                                      'https://lh3.googleusercontent.com/aida-public/AB6AXuA5deOCi3ZTcwxAAfTCfO2EsfBgA3qg1kVMJtOrkSJl-mYWFAeeODji7b-hurvz2dqCFMmpYcRdjFCW28n_nyPTVrrHlEtGr952xTsrlYnulx7ZjSJQ9kW0YW5CuYimoFvC6Pu5hXtm12YQrp_L38WZWQjjH5sPrRWGAvnQyfMYnTxHA8Z2dOhB8JkIN_eDS0fApqZfLrzAAPtcMAa9gCaNiwo2QVoy5z3lfo30II06KouSwEViD7E92Uv_P63mem0vhrXRtqVdFzk',
                                  price: 849.00,
                                  quantity: 1,
                                ));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Added to cart!')),
                            );
                          },
                        ),
                        _buildFlashSaleItem(
                          'Tactile Mech Keyboard',
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuBLizl7JRhOYmfStj-MHDlI44l4oDm0ClfMOrZAtX7LLXM94ak8A8D-i9k6l0OzBXaFoZ6AW8tbL6gRfmbMOMfzl9CjqBeb1oPCQ1vGumjQyvaVJVv0WRvt90_Qb8I7Ocqz1UR8ln-N-4yQbimaZgtOatVfIlrs2GZuAKHYe8F5Eyk3ehKYG-EcSkpzvWt_B2AgQ2K-PJ8qhX9o26M2hZeIy4SxUo-_1sk0VjL8GLR0VFxTCl4V1ZF0O4WwjuJwWyaWBIpCHmcQEis',
                          119.00,
                          199.00,
                          40,
                          () {
                            ref.read(cartProvider.notifier).addItem(CartItem(
                                  id: 'flash-keyboard',
                                  name: 'Tactile Mech Keyboard',
                                  imageUrl:
                                      'https://lh3.googleusercontent.com/aida-public/AB6AXuBLizl7JRhOYmfStj-MHDlI44l4oDm0ClfMOrZAtX7LLXM94ak8A8D-i9k6l0OzBXaFoZ6AW8tbL6gRfmbMOMfzl9CjqBeb1oPCQ1vGumjQyvaVJVv0WRvt90_Qb8I7Ocqz1UR8ln-N-4yQbimaZgtOatVfIlrs2GZuAKHYe8F5Eyk3ehKYG-EcSkpzvWt_B2AgQ2K-PJ8qhX9o26M2hZeIy4SxUo-_1sk0VjL8GLR0VFxTCl4V1ZF0O4WwjuJwWyaWBIpCHmcQEis',
                                  price: 119.00,
                                  quantity: 1,
                                ));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Added to cart!')),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Featured Products
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Curated Precision',
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // For simplicity, just show one main featured
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.black.withOpacity(0.6),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Alpha Station Z1',
                          style: GoogleFonts.inter(
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.star,
                                color: const Color(0xFF4CD7F6), size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '4.9 (240 Reviews)',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: const Color(0xFF4CD7F6),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'The ultimate workstation for data scientists and AI developers.',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: Colors.grey[400],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          '\$4,299.00',
                          style: GoogleFonts.inter(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            ref.read(cartProvider.notifier).addItem(CartItem(
                                  id: 'alpha-z1',
                                  name: 'Alpha Station Z1',
                                  imageUrl:
                                      'https://lh3.googleusercontent.com/aida-public/AB6AXuB5xjiG9H8JO7flNmiDEaR_zsyRJ9SfQVCUyWKS0o9TKs6XEcLibersio-v-nfOE025Wvvl9F3eG0fpfj-FJsTPKJ_f-al7z2rnvVJ8qEjf8nXdloIYxPPeACMxDEwc6swPkZfdtu2JjTBLIUDeOmbEI8rBqQbnjP-zLEDqEUKsi-Uod09vOjbVbV4JiAdUj0rmyDOjaPxUnO-OW6r8ulfYS9aL5mjgq0MDXXLyapOZLDuRiTXC2O_cWvlDELDv974G_r7ukNN5otc',
                                  price: 4299.00,
                                  quantity: 1,
                                ));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Added to cart!')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Order Professional Kit',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black.withOpacity(0.8),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
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

  Widget _buildCategoryItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Icon(icon, color: const Color(0xFF4CD7F6), size: 36),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }

  Widget _buildFlashSaleItem(String name, String imageUrl, double price,
      double originalPrice, int discount, VoidCallback onAddToCart) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '-$discount%',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF4CD7F6),
                    ),
                  ),
                  Text(
                    '\$${originalPrice.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
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
                  onPressed: onAddToCart,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
