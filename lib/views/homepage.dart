import 'package:flutter/material.dart';
import 'package:firstproject/views/products.dart'; // Ensure this page exists
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'accout_settings.dart';
import 'cart.dart';
import 'categories.dart';
import 'logout.dart';
import 'ordered_history.dart'; // To handle JSON responses

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  String? userName;

  @override
  void initState() {
    super.initState();
    _loadUserName(); // Load the username from SharedPreferences when the page loads
  }

  // Method to load username from SharedPreferences
  Future<void> _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('username') ?? 'Guest'; // Default to 'Guest' if not found
    });
  }

  final List<Widget> _pages = [
    const Center(child: Text('Product Page')),
    const Center(child: Text('Favorites Page')),
    const Center(child: Text('Settings Page')),
    const Center(child: Text('Notifications Page')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: Colors.deepPurple,
          elevation: 0,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [],
          ),
          actions: [
            // Display the username if fetched
            if (userName != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Hello, $userName',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            // Cart Icon
            IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductPage()),
                ); // Add cart functionality here
              },
            ),
          ],
        ),
      ),
      // Drawer for the menu on the left with white background
      drawer: Drawer(
        backgroundColor: Colors.white, // Set background color to white
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple, // Header color
              ),
              child: Text(
                'E-Commerce Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text('Shop Categories'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoriesPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Your Cart'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Order History'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderHistoryPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Account Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountSettingsPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Notifications'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                logout(context); // This will handle the logout process
              },
            ),
          ],
        ),
      ),
      // Body Section
      body: SingleChildScrollView( // Add SingleChildScrollView here
        child: Stack(
          children: [
            // Banner Section
            Container(
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/benner.jpg'), // Add your banner image
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Search Bar Section on top of the banner
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20), // Rounded corners for the search bar
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for products...',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),

            // Main content under the banner and search bar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 200), // Provide space for the search bar and banner

                // Product Slider Section
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Featured Products',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Container for the product slider with margin and padding
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    height: 250, // Set the height of the product slider
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        ProductContainer(
                          child: ProductCard(
                            imageUrl: 'assets/images/product1.png',
                            name: 'Product 1',
                            price: '\$25.99',
                          ),
                        ),
                        ProductContainer(
                          child: ProductCard(
                            imageUrl: 'assets/images/product2.png',
                            name: 'Product 2',
                            price: '\$39.99',
                          ),
                        ),
                        ProductContainer(
                          child: ProductCard(
                            imageUrl: 'assets/images/product3.png',
                            name: 'Product 3',
                            price: '\$59.99',
                          ),
                        ),
                        // Add more products as needed
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Update the selected page
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

// Wrapper container for each product
class ProductContainer extends StatelessWidget {
  final Widget child;

  const ProductContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: child, // Product card goes inside the container
      ),
    );
  }
}

// ProductCard Widget to display individual product details
class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String price;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imageUrl),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(height: 8),
        Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(price, style: const TextStyle(fontSize: 14, color: Colors.green)),
      ],
    );
  }
}

void logout(BuildContext context) {
  // Implement your logout logic here
}
