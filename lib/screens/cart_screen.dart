import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Your Cart', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF030712),
                  Color(0xFF0B132B),
                  Color(0xFF0F1E36),
                ],
                stops: [0.0, 0.45, 1.0],
              ),
            ),
          ),
          SafeArea(
            child: cart.items.isEmpty
                ? const Center(
              child: Text(
                'Your cart is empty.',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            )
                : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.06),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.14),
                                  width: 1.2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      item.product.imageUrl,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(
                                        width: 60,
                                        height: 60,
                                        color: Colors.white10,
                                        child: const Icon(Icons.image, color: Colors.white38),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.product.name,
                                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '\$${item.product.price.toStringAsFixed(2)} x ${item.quantity}',
                                          style: const TextStyle(color: Color(0xFF67E8F9), fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove_circle_outline, color: Colors.white70),
                                        onPressed: () => cart.decrementQuantity(item.product.id),
                                      ),
                                      Text(
                                        '${item.quantity}',
                                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add_circle_outline, color: Color(0xFF38BDF8)),
                                        onPressed: () => cart.incrementQuantity(item.product.id),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF070C18).withOpacity(0.85),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.14))),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Total:', style: TextStyle(fontSize: 18, color: Colors.white70)),
                              Text(
                                '\$${cart.totalAmount.toStringAsFixed(2)}',
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF67E8F9)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1E3A8A),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const CheckoutScreen()),
                                );
                              },
                              child: const Text('Proceed to Checkout', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}}