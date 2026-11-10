
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Map<String, String>> cartItems;

  const CheckoutScreen({
    super.key,
    required this.cartItems,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  static const Color primaryColor = Color(0xFF203F89);
  static const Color backgroundColor = Color(0xFFF8FAFC);

  final TextEditingController roomController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Calculate item price
  int getPrice(String price) {
    return int.tryParse(
          price.replaceAll(RegExp(r'[^0-9]'), ''),
        ) ??
        0;
  }

  // Group identical products
  Map<String, List<Map<String, String>>> get groupedItems {
    Map<String, List<Map<String, String>>> grouped = {};

    for (var item in widget.cartItems) {
      String name = item['name'] ?? '';

      if (!grouped.containsKey(name)) {
        grouped[name] = [];
      }

      grouped[name]!.add(item);
    }

    return grouped;
  }

  // Calculate total price
  int get totalPrice {
    int total = 0;

    for (var item in widget.cartItems) {
      total += getPrice(item['price'] ?? '0');
    }

    return total;
  }

  @override
  void dispose() {
    roomController.dispose();
    super.dispose();
  }

  void placeOrder() {
    if (widget.cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your cart is empty!'),
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Order placed successfully!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: primaryColor,
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Current Cart Items
                const Text(
                  'Current Cart Items',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),

                const SizedBox(height: 15),

                if (widget.cartItems.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(25),
                      child: Text(
                        'Your cart is empty',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                else
                  ...groupedItems.entries.map((entry) {
                    final item = entry.value.first;
                    final quantity = entry.value.length;
                    final price = getPrice(item['price'] ?? '0');
                    final itemTotal = price * quantity;

                    return Card(
                      color: Colors.white,
                      elevation: 1,
                      margin: const EdgeInsets.only(bottom: 12),

                      child: Padding(
                        padding: const EdgeInsets.all(15),

                        child: Row(
                          children: [
                            Text(
                              item['icon'] ?? '🛒',
                              style: const TextStyle(fontSize: 30),
                            ),

                            const SizedBox(width: 15),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['name'] ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),

                                  const SizedBox(height: 5),

                                  Text(
                                    'Rs. $price x $quantity',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Text(
                              'Rs. $itemTotal',
                              style: const TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),

                const SizedBox(height: 20),

                // Order Summary
                const Text(
                  'Order Summary',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),

                const SizedBox(height: 15),

                Card(
                  color: Colors.white,
                  elevation: 1,

                  child: Padding(
                    padding: const EdgeInsets.all(18),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Amount',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        Text(
                          'Rs. $totalPrice',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Room Number
                const Text(
                  'Delivery Information',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  'Room Number',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: roomController,
                  decoration: InputDecoration(
                    hintText: 'Enter your room number',
                    prefixIcon: const Icon(
                      Icons.meeting_room_outlined,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your room number';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 30),

                // Place Order Button
                SizedBox(
                  width: double.infinity,
                  height: 52,

                  child: FilledButton(
                    onPressed: placeOrder,

                    style: FilledButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    child: const Text(
                      'Place Order',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
