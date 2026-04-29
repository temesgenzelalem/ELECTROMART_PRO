import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../providers.dart';

class ProductDetailsScreen extends ConsumerWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF031427),
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.6),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
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
            onPressed: () {},
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
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuDTUGCAeAm6ulVRNaCNcVkqZ94TLJ5QIWROkxzftxXQA0dd4UGdYWxAeLohLSFPnh2MYzy5195ovipQgVwKxGhqhzVmpY6cOMltCb-uIDQKhbME0jNUBSRhhHA-JwnhzfhnDbdq9vg1Gl_i730r3q-rypLmaEqX2DfqEqv4C1nH9qA9neJm5l2MkMKLxB8LeJeAp5SFqKxg3nhVkZqqRNLeLUWiRXA1B8L1Uz-chAnDZlRYR15WJXnlgaxjCP0XDjwJ2rTlAufmipc',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildThumbnail(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuBuSjyyuyQgoSpgMpTFCy3Di4X1XT7xDr4AJt9MvZWEjFEtnEqFUkrGp7DtJLHjwrq5cq14JJdgSDvkvnGc6a2w9-OST-3a0tDivJwazQyEvqT2-anHNX6q3HJTRH9ZvAFmkzeEnThAUpNYvTlZ58Jym7rqJ5Png1Say-ntX5uGTcHt8UPuLArPG99olprolrtwXQs-l7o4jaU2xmTC4cXKORUVF4GlmY7ZSAvsvACjFQqzYL5dxsGWDWRIi-hMjZjadCcvKPg7vKk',
                  ),
                  _buildThumbnail(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuBlw601D4bTstHCCMYsEBz6PS2ry5AwSmJ10K5UGW3agIZLBhW-t3SsVT48xYH8mNsebFKxrCO4vTjlTgjCcrcBM_tA2lrim6QoU9huiP1VyL26CDVgwok-1lcXOPykBwa4xdL7y8c-8eeMwpO6rfXpu3gtXrwKV8K0VB8XFvaZDv-1u76HtJyn3dfuBAFS5SDdW8j-jKffq6YbZcl1ZJ5ijCNoA21FBxVdgKaoHSht7YgIn4QYsOQ4fYgQS9ST9qbmbhbjfKJ6zpA',
                  ),
                  _buildThumbnail(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuAlvnbN_r_tBVyWxlqoQKog9YCn-Uh4etRRV6ijb1PUXWa-6LgMDLHmBI5NMc0wKLcwVJCSvFOTDZiaD2onitPWj3RMx3ulI6E5IMdLIdqU0A1HtNu7-JjMm9wHEhnnAXEtK19_o_e4WeoP1TcmQt7c37hozgRkwpLOrzo40t92ctSCyOoUXxRCrbJsHF-jaRBQBWeb80X8f-bIuuyN464Q1DSYhfrH6Iz920725xkSiXR3Q57Oy9N81xG0ibiyPvU36cGOyquB4cA',
                  ),
                  _buildThumbnail(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuCFsXiij9eQ3nc12XZZDNOuPFBSGdjcxkilDaukKPl6BySNmMvxorqKHvA7HEj31OBIRAunpEG9ipX6tc5dM-FFhv1ZXz-xGl8gq2-nJQHcSqbJYXJ7c1BE200x-uYqRQc69950hrqy5XGqRju9mKdU51sLoVHHKnva2XW5BJYo1W9TAueh9yDx6JeWUMLhbQh2BgvZNeTrZ73YewonC5dz31bW1kZjrdZNTy7I57TZPuwHcRQJyM67bTvhFy6dMqqMaGEeTqFo',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CD7F6).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'NVIDIA EDITION',
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
                      '4.9 (1,280 Reviews)',
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
              'Quantum X17 Pro Elite',
              style: GoogleFonts.inter(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'RTX 4090 | i9-13980HX | 64GB DDR5 | 2TB Gen4 SSD',
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
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '\$3,499.99',
                        style: GoogleFonts.inter(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '\$3,899.99',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '-10%',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'ONLY 3 LEFT IN STOCK!',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.notifications_active,
                          color: Color(0xFF4CD7F6)),
                      const SizedBox(width: 12),
                      Text(
                        'Notify me of price drops',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Switch(
                    value: false,
                    onChanged: (value) {},
                    activeThumbColor: const Color(0xFF0566D9),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SELECT COLOR',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[400],
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildColorOption(Colors.black, true),
                    const SizedBox(width: 12),
                    _buildColorOption(Colors.grey.shade400, false),
                    const SizedBox(width: 12),
                    _buildColorOption(const Color(0xFF001b21), false),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'STORAGE CONFIGURATION',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[400],
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildStorageOption('1TB Gen4', true),
                    _buildStorageOption('2TB Gen4', false),
                    _buildStorageOption('4TB RAID 0', false),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Technical Specifications',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Engineered for peak performance, the Quantum X17 Pro Elite features a liquid metal cooling system and a 17.3-inch 4K Mini-LED display with a 240Hz refresh rate. Powered by the latest Intel i9-13980HX processor and NVIDIA RTX 4090 GPU with 16GB GDDR6X memory.',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.grey[400],
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text(
                          'See Full Spec Sheet',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: const Color(0xFF4CD7F6),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xFF4CD7F6),
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Verified Field Reports',
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            _buildReviewCard(
              'MK',
              'Marcus K.',
              'Enterprise Developer',
              5,
              '"The build quality is insane. It handles 8K video rendering while running several VM instances without thermal throttling. A true beast."',
              'https://lh3.googleusercontent.com/aida-public/AB6AXuB5VYQhlnwQK03gLDmRohDnLXmvCP38rhuuDCayu5075c4jLVfD3xGr2ahrJuRvXudf7xux89PzaqjlXRtSvvPE-JCgrQI-WCY29WccXhBpUA252QJNsvQXBTur-gOk--P8XhTrU26WCzC5sGqnwd8kVLcU_2yBoDsoE0VJS7xS9qTp4k0C8SVCMx1FRb7LLZvvKti7P2XhTITgnbKAZBVWazHHYvYI2o4qCrj00MT-LWFGN21v88RCL4FIHBzDrZOwI064tn7JRSE',
              true,
            ),
            const SizedBox(height: 16),
            _buildReviewCard(
              'SR',
              'Sarah R.',
              'Creative Director',
              5,
              '"The display color accuracy is the best I\'ve seen in a mobile workstation. 100% DCI-P3 coverage is real. Worth every penny for creative pros."',
              null,
              true,
            ),
            const SizedBox(height: 16),
            _buildReviewCard(
              'JD',
              'Jason D.',
              'Hardcore Gamer',
              4.5,
              '"Cyberpunk 2077 at Psycho settings with Ray Reconstruction runs like butter. The fan noise is there, but expected for this kind of power."',
              'https://lh3.googleusercontent.com/aida-public/AB6AXuCd0MKbisvrT4AR2Ss_3OaGq-ZfkdoekgG2K-RmYmhiOqLkT8j1xXJDH57bQ2ydAHmM7k6jP69aE2WfmwF-Eru2U7xSkqCiNIotlpg2uS7acLRp5E6mj_Jxkg3ukxpTpoJvftQ9I1Co5rni5cUVWhozrHvpp1uUpOYAJ8fJLn5m15yvwCA2qeeVV46hUPewkMPLDRucDXVoweSNB6E0vVt5DMp2ZXl1XdbYkauWtH7SZuZDSYfG5J0FH1Wv6GMmgPtDT95Vs5MMj-w',
              false,
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              ref.read(cartProvider.notifier).addItem(CartItem(
                    id: 'quantum-x17-elite',
                    name: 'Quantum X17 Pro Elite',
                    imageUrl:
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuDTUGCAeAm6ulVRNaCNcVkqZ94TLJ5QIWROkxzftxXQA0dd4UGdYWxAeLohLSFPnh2MYzy5195ovipQgVwKxGhqhzVmpY6cOMltCb-uIDQKhbME0jNUBSRhhHA-JwnhzfhnDbdq9vg1Gl_i730r3q-rypLmaEqX2DfqEqv4C1nH9qA9neJm5l2MkMKLxB8LeJeAp5SFqKxg3nhVkZqqRNLeLUWiRXA1B8L1Uz-chAnDZlRYR15WJXnlgaxjCP0XDjwJ2rTlAufmipc',
                    price: 3499.99,
                    quantity: 1,
                  ));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Added to cart!')),
              );
            },
            icon: const Icon(Icons.add_shopping_cart),
            label: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'ADD TO CART - \$3,499.99',
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
        backgroundColor: Colors.black.withOpacity(0.8),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: 1, // Explore selected
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/');
              break;
            case 1:
              context.go('/products');
              break;
            case 2:
              // Wishlist - not implemented yet
              break;
            case 3:
              context.go('/cart');
              break;
            case 4:
              context.go('/profile');
              break;
          }
        },
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

  Widget _buildThumbnail(String imageUrl) {
    return Container(
      width: 80,
      height: 80,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildColorOption(Color color, bool selected) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color:
              selected ? const Color(0xFF4CD7F6) : Colors.grey.withOpacity(0.3),
          width: selected ? 2 : 1,
        ),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: const Color(0xFF4CD7F6).withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 2,
                )
              ]
            : null,
      ),
    );
  }

  Widget _buildStorageOption(String label, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color:
            selected ? const Color(0xFF0566D9) : Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color:
              selected ? const Color(0xFF4CD7F6) : Colors.grey.withOpacity(0.3),
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          color: selected ? Colors.white : Colors.grey[400],
        ),
      ),
    );
  }

  Widget _buildReviewCard(
    String initials,
    String name,
    String title,
    double rating,
    String review,
    String? imageUrl,
    bool verified,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFF0566D9),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    initials,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        if (verified) ...[
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.verified,
                            color: Color(0xFF4CD7F6),
                            size: 16,
                          ),
                        ],
                      ],
                    ),
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(5, (index) {
              if (index < rating.floor()) {
                return const Icon(Icons.star, color: Colors.yellow, size: 16);
              } else if (index == rating.floor() && rating % 1 != 0) {
                return const Icon(Icons.star_half,
                    color: Colors.yellow, size: 16);
              } else {
                return const Icon(Icons.star_border,
                    color: Colors.grey, size: 16);
              }
            }),
          ),
          const SizedBox(height: 12),
          Text(
            review,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.grey[400],
              fontStyle: FontStyle.italic,
            ),
          ),
          if (imageUrl != null) ...[
            const SizedBox(height: 16),
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
