
import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

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
          'Help & Support',
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
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.support_agent,
                    color: Colors.white,
                    size: 40,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'How can we help you?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Find answers to common questions or contact our support team.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            const SizedBox(height: 12),

            faqTile(
              question: 'How can I create an account?',
              answer:
                  'Go to the Sign Up page, enter your details and create your CampusConnect account.',
            ),

            faqTile(
              question: 'How can I place an order?',
              answer:
                  'Browse the available products, add your items to the cart and proceed with your order.',
            ),

            faqTile(
              question: 'How can I check my orders?',
              answer:
                  'Open the menu and select My Orders to view your order information.',
            ),

            faqTile(
              question: 'Can I cancel my order?',
              answer:
                  'For order cancellation, contact the campus support team.',
            ),

            faqTile(
              question: 'What if I forget my password?',
              answer:
                  'Contact the support team for assistance with your account.',
            ),

            const SizedBox(height: 25),

            const Text(
              'Contact Support',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            const SizedBox(height: 12),

            Card(
              color: Colors.white,
              elevation: 1,
              child: ListTile(
                leading: const Icon(
                  Icons.email_outlined,
                  color: primaryColor,
                  size: 28,
                ),
                title: const Text(
                  'Email Support',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text('support@campusconnect.com'),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Email support coming soon.'),
                    ),
                  );
                },
              ),
            ),

            Card(
              color: Colors.white,
              elevation: 1,
              child: ListTile(
                leading: const Icon(
                  Icons.phone_outlined,
                  color: primaryColor,
                  size: 28,
                ),
                title: const Text(
                  'Phone Support',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text('Contact campus support'),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Phone support coming soon.'),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Report a Problem',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFE2E8F0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Having trouble with the app?',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Describe your problem...',
                      filled: true,
                      fillColor: Color(0xFFF8FAFC),
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Problem reporting coming soon.',
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 13,
                        ),
                      ),
                      child: const Text('Submit Report'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Center(
              child: Text(
                'CampusConnect v1.0.0',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 12,
                ),
              ),
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget faqTile({
    required String question,
    required String answer,
  }) {
    return Card(
      color: Colors.white,
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 9),
      child: ExpansionTile(
        iconColor: primaryColor,
        collapsedIconColor: primaryColor,
        title: Text(
          question,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                answer,
                style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
