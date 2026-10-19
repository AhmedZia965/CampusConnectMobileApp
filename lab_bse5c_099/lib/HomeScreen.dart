
import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';
import 'Cart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController =
      TextEditingController();

  String searchQuery = '';
  String selectedCategory = 'All';

  // Shared cart list used by HomeScreen and CartScreen.
  final List<Map<String, String>> cartItems = [];

  final List<Map<String, String>> products = [
    {'name': 'Chicken Burger', 'price': 'Rs. 350', 'icon': '🍔', 'category': 'Food'},
    {'name': 'Fries', 'price': 'Rs. 180', 'icon': '🍟', 'category': 'Food'},
    {'name': 'Notebook', 'price': 'Rs. 120', 'icon': '📒', 'category': 'Stationery'},
    {'name': '7up', 'price': 'Rs. 100', 'icon': '🥤', 'category': 'Drinks'},
    {'name': 'Pepsi', 'price': 'Rs. 100', 'icon': '🥤', 'category': 'Drinks'},
    {'name': 'Coca Cola', 'price': 'Rs. 100', 'icon': '🥤', 'category': 'Drinks'},
    {'name': 'Mountain Dew', 'price': 'Rs. 100', 'icon': '🥤', 'category': 'Drinks'},
    {'name': 'Milo', 'price': 'Rs. 100', 'icon': '🥤', 'category': 'Drinks'},
    {'name': 'Sandwich', 'price': 'Rs. 220', 'icon': '🥪', 'category': 'Food'},
    {'name': 'Pen Set', 'price': 'Rs. 60', 'icon': '🖊️', 'category': 'Stationery'},
    {'name': 'Coffee', 'price': 'Rs. 150', 'icon': '☕', 'category': 'Drinks'},
    {'name': 'Backpack', 'price': 'Rs. 1200', 'icon': '🎒', 'category': 'Other'},
    {'name': 'Hair Brush', 'price': 'Rs. 400', 'icon': '💇', 'category': 'Other'},
    {'name': 'Pizza Slice', 'price': 'Rs. 200', 'icon': '🍕', 'category': 'Food'},
    {'name': 'Chocolate Cake Slice', 'price': 'Rs. 150', 'icon': '🧁', 'category': 'Food'},
    {'name': 'Water Bottle', 'price': 'Rs. 300', 'icon': '🧴', 'category': 'Other'},
    {'name': 'Highlighter Set', 'price': 'Rs. 150', 'icon': '🖍️', 'category': 'Stationery'},
    {'name': 'Stapler', 'price': 'Rs. 200', 'icon': '📎', 'category': 'Stationery'},
    {'name': 'Black Ball Pen', 'price': 'Rs. 25', 'icon': '🖊️', 'category': 'Stationery'},
    {'name': 'Blue Ball Pen', 'price': 'Rs. 25', 'icon': '🖊️', 'category': 'Stationery'},
    {'name': 'Title Page', 'price': 'Rs. 15', 'icon': '📄', 'category': 'Stationery'},
    {'name': '50 A4 Sheets', 'price': 'Rs. 200', 'icon': '📄', 'category': 'Stationery'},
    {'name': 'Lays', 'price': 'Rs. 80', 'icon': '🥔', 'category': 'Food'},
    {'name': 'Card Holder', 'price': 'Rs. 200', 'icon': '💳', 'category': 'Other'},
  ];

  final List<Map<String, dynamic>> categories = [
    {'name': 'Food', 'icon': Icons.restaurant},
    {'name': 'Stationery', 'icon': Icons.menu_book},
    {'name': 'Drinks', 'icon': Icons.local_cafe},
    {'name': 'Other', 'icon': Icons.shopping_bag},
  ];

  List<Map<String, String>> get filteredProducts {
    return products.where((product) {
      final matchesSearch = product['name']!
          .toLowerCase()
          .contains(searchQuery.toLowerCase());

      final matchesCategory = selectedCategory == 'All' ||
          product['category'] == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Add a separate copy of the selected product.
  void addToCart(Map<String, String> product) {
    setState(() {
      cartItems.add(Map<String, String>.from(product));
    });

    showMessage('${product['name']} added to cart');
  }

  // Open the cart and refresh the cart count when returning.
  void openCart() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(
          cartItems: cartItems,
        ),
      ),
    );

    if (mounted) {
      setState(() {});
    }
  }

  void openLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void openSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.school,
              color: Color(0xFF203F89),
              size: 30,
            ),
            SizedBox(width: 8),
            Flexible(
              child: Text(
                'CampusConnect',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color(0xFF203F89),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
        actions: [
          // Shopping cart with live item count.
          IconButton(
            onPressed: openCart,
            tooltip: 'Shopping Cart',
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(
                  Icons.shopping_cart,
                  color: Color(0xFF203F89),
                  size: 28,
                ),
                if (cartItems.isNotEmpty)
                  Positioned(
                    right: -7,
                    top: -7,
                    child: CircleAvatar(
                      radius: 9,
                      backgroundColor: Colors.red,
                      child: Text(
                        '${cartItems.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          TextButton(
            onPressed: openLogin,
            child: const Text(
              'Login',
              style: TextStyle(
                color: Color(0xFF203F89),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF203F89),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              onPressed: openSignUp,
              child: const Text('Sign Up'),
            ),
          ),

          PopupMenuButton<String>(
            tooltip: 'More options',
            icon: const Icon(
              Icons.menu,
              color: Color(0xFF203F89),
              size: 27,
            ),
            onSelected: (value) {
              if (value == 'home') {
                setState(() {
                  selectedCategory = 'All';
                  searchQuery = '';
                  searchController.clear();
                });
              } else if (value == 'orders') {
                showMessage('My Orders coming soon');
              } else if (value == 'favorites') {
                showMessage('Favorites coming soon');
              } else if (value == 'help') {
                showMessage('Help and Support coming soon');
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'home',
                child: Row(
                  children: [
                    Icon(Icons.home_outlined),
                    SizedBox(width: 10),
                    Text('Home'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'orders',
                child: Row(
                  children: [
                    Icon(Icons.receipt_long_outlined),
                    SizedBox(width: 10),
                    Text('My Orders'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'favorites',
                child: Row(
                  children: [
                    Icon(Icons.favorite_border),
                    SizedBox(width: 10),
                    Text('Favorites'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'help',
                child: Row(
                  children: [
                    Icon(Icons.help_outline),
                    SizedBox(width: 10),
                    Text('Help & Support'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 4),
        ],
      ),

      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                const SizedBox(height: 10),

                // Welcome banner.
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: const Color(0xFF203F89),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, Student! 👋',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Your campus essentials, all in one place.',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Explore food, drinks and stationery',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                // Search bar.
                TextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search food, stationery...',
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF203F89),
                    ),
                    suffixIcon: searchQuery.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              searchController.clear();
                              setState(() {
                                searchQuery = '';
                              });
                            },
                            icon: const Icon(Icons.clear),
                          )
                        : null,
                    filled: true,
                    fillColor: const Color(0xFFF8FAFF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFFDCE5F5),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFFDCE5F5),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFF203F89),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF203F89),
                  ),
                ),

                const SizedBox(height: 15),

                Row(
                  children: categories.map((category) {
                    final String name = category['name'] as String;
                    final IconData icon = category['icon'] as IconData;
                    final bool isSelected = selectedCategory == name;

                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory =
                                isSelected ? 'All' : name;
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 58,
                              width: 58,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF203F89)
                                    : const Color(0xFFE8F0FF),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Icon(
                                icon,
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF203F89),
                                size: 29,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isSelected
                                    ? const Color(0xFF203F89)
                                    : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 28),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Popular Items',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF203F89),
                      ),
                    ),
                    if (selectedCategory != 'All')
                      TextButton(
                        onPressed: () {
                          setState(() {
                            selectedCategory = 'All';
                          });
                        },
                        child: const Text('View All'),
                      ),
                  ],
                ),

                const SizedBox(height: 15),

                if (filteredProducts.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Column(
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 55,
                          color: Colors.blueGrey,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'No products found',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.78,
                    ),
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];

                      return productCard(
                        name: product['name']!,
                        price: product['price']!,
                        emoji: product['icon']!,
                        category: product['category']!,
                        onAdd: () => addToCart(product),
                      );
                    },
                  ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Product card.
  Widget productCard({
    required String name,
    required String price,
    required String emoji,
    required String category,
    required VoidCallback onAdd,
  }) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black12,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Color(0xFFF0F2F8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F0FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    emoji,
                    style: const TextStyle(fontSize: 43),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 9),
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF202A44),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              category,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 7),
            Row(
              children: [
                Expanded(
                  child: Text(
                    price,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF203F89),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                InkWell(
                  onTap: onAdd,
                  borderRadius: BorderRadius.circular(20),
                  child: const Padding(
                    padding: EdgeInsets.all(3),
                    child: Icon(
                      Icons.add_circle,
                      color: Color(0xFF203F89),
                      size: 27,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
