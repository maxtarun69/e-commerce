import 'package:flutter/material.dart';
import 'package:firstproject/views/products.dart';

import 'login.dart'; // Ensure this page exists

class Back_ground extends StatelessWidget {
  const  Back_ground({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(), // Change MainPage to HomePage
    );
  }
}

class HomePage extends StatefulWidget { // Changed class name to HomePage
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState(); // Changed state class name to _HomePageState
}

class _HomePageState extends State<HomePage> { // Changed state class name to _HomePageState
  int _selectedIndex = 0;

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
            // Sign In Icon
            IconButton(
              icon: const Icon(Icons.login, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()), // Navigate to SignUpPage
                );
                print("Sign-In Icon Pressed");
              },
            ),
            // Cart Icon
            IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductPage()),
                );
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
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                // Navigate to Home
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.shop),
              title: const Text('Shop'),
              onTap: () {
                // Navigate to Shop page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favorites'),
              onTap: () {
                // Navigate to Favorites page
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Navigate to Settings page
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Notifications'),
              onTap: () {
                // Navigate to Notifications page
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Handle logout functionality here
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
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
        Text(
          name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          price,
          style: const TextStyle(fontSize: 14, color: Colors.green),
        ),
      ],
    );
  }
}
