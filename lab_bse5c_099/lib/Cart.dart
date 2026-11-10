
import 'package:flutter/material.dart';
import 'Checkout.dart';

class CartScreen extends StatefulWidget {
  final List<Map<String, String>> cartItems;

  const CartScreen({
    super.key,
    required this.cartItems,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Convert a price such as "Rs. 1,200" into 1200.
  int getPrice(String? price) {
    if (price == null) {
      return 0;
    }

    final cleanedPrice = price.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );

    return int.tryParse(cleanedPrice) ?? 0;
  }

  // Show each product once, even if it was added multiple times.
  List<Map<String, String>> get uniqueItems {
    final Map<String, Map<String, String>> items = {};

    for (final item in widget.cartItems) {
      final name = item['name'] ?? '';

      if (name.isNotEmpty) {
        items[name] = item;
      }
    }

    return items.values.toList();
  }

  // Count how many times a product exists in the actual cart list.
  int getQuantity(String name) {
    return widget.cartItems.where(
      (item) => item['name'] == name,
    ).length;
  }

  // Calculate the total from the actual cart items.
  int get totalPrice {
    int total = 0;

    for (final item in widget.cartItems) {
      total += getPrice(item['price']);
    }

    return total;
  }

  // Remove one copy of a product.
  void decreaseQuantity(Map<String, String> product) {
    final index = widget.cartItems.indexWhere(
      (item) => item['name'] == product['name'],
    );

    if (index != -1) {
      setState(() {
        widget.cartItems.removeAt(index);
      });
    }
  }

  // Remove every copy of a product.
  void removeProduct(String name) {
    setState(() {
      widget.cartItems.removeWhere(
        (item) => item['name'] == name,
      );
    });
  }

  // Add another copy of the product.
  void increaseQuantity(Map<String, String> product) {
    setState(() {
      widget.cartItems.add(
        Map<String, String>.from(product),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text(
          'Shopping Cart',
          style: TextStyle(
            color: Color(0xFF203F89),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF203F89),
        elevation: 0,
      ),

      body: widget.cartItems.isEmpty
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.remove_shopping_cart_outlined,
                    size: 65,
                    color: Colors.blueGrey,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: uniqueItems.length,
                    itemBuilder: (context, index) {
                      final product = uniqueItems[index];
                      final name = product['name'] ?? 'Product';
                      final quantity = getQuantity(name);
                      final price = getPrice(product['price']);

                      return Card(
                        color: Colors.white,
                        elevation: 2,
                        margin: const EdgeInsets.only(bottom: 12),

                        child: Padding(
                          padding: const EdgeInsets.all(12),

                          child: Row(
                            children: [
                              Container(
                                width: 55,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8F0FF),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    product['icon'] ?? '🛍️',
                                    style: const TextStyle(
                                      fontSize: 28,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 12),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),

                                    const SizedBox(height: 4),

                                    Text(
                                      'Rs. $price each',
                                      style: const TextStyle(
                                        color: Color(0xFF203F89),
                                      ),
                                    ),

                                    const SizedBox(height: 8),

                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            decreaseQuantity(product);
                                          },
                                          icon: const Icon(
                                            Icons.remove_circle_outline,
                                          ),
                                          color: const Color(0xFF203F89),
                                          constraints:
                                              const BoxConstraints(),
                                          padding: const EdgeInsets.all(4),
                                        ),

                                        Padding(
                                          padding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 8,
                                          ),
                                          child: Text(
                                            '$quantity',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),

                                        IconButton(
                                          onPressed: () {
                                            increaseQuantity(product);
                                          },
                                          icon: const Icon(
                                            Icons.add_circle_outline,
                                          ),
                                          color: const Color(0xFF203F89),
                                          constraints:
                                              const BoxConstraints(),
                                          padding: const EdgeInsets.all(4),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(width: 8),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Rs. ${price * quantity}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF203F89),
                                    ),
                                  ),

                                  IconButton(
                                    onPressed: () {
                                      removeProduct(name);
                                    },
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                    ),
                                    tooltip: 'Remove item',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),

                  child: SafeArea(
                    top: false,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(
                              'Rs. $totalPrice',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF203F89),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: const Color(0xFF203F89),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),

                            // Navigate to Checkout
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CheckoutScreen(
                                    cartItems: widget.cartItems,
                                  ),
                                ),
                              );
                            },

                            child: const Text('Proceed to Checkout'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
