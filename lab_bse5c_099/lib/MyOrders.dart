
import 'package:flutter/material.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  static const Color primaryColor = Color(0xFF203F89);
  static const Color backgroundColor = Color(0xFFF8FAFC);

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
          'My Orders',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Your Orders',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Keep track of your campus purchases.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blueGrey,
              ),
            ),

            const SizedBox(height: 22),

            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 70),
                child: Column(
                  children: [
                    Icon(
                      Icons.receipt_long_outlined,
                      size: 75,
                      color: Colors.blueGrey.shade300,
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'No Orders Yet',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Your orders will appear here.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
