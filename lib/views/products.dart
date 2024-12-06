import 'package:flutter/material.dart';
import 'views/payment.dart';
class ProductPage extends StatefulWidget {
  ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final List<Map<String, String>> products = [
    {"image": "assets/images/product1.png", "name": "I phone 16", "price": "₹1000", "description": "Latest model, advanced features."},
    {"image": "assets/images/product2.png", "name": "Samsung TV", "price": "₹1500", "description": "4K UHD with smart features."},
    {"image": "assets/images/product3.png", "name": "Clock", "price": "₹2000", "description": "Modern design, reliable."},
    {"image": "assets/images/logo.png", "name": "Lamp", "price": "₹2500", "description": "Energy-efficient LED lamp."},
  ];

  List<Map<String, String>> filteredProducts = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredProducts = products;
    searchController.addListener(_filterProducts);
  }

  void _filterProducts() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredProducts = products.where((product) {
        return product['name']!.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_filterProducts);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Cart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Open the drawer when the menu icon is tapped
            },
          ),
          title: const Text("Shopping Cart"),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // This will show/hide the search bar
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                child: Text('Menu', style: TextStyle(fontSize: 24)),
              ),
              ListTile(
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Profile'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  labelText: 'Search Products',
                  border: OutlineInputBorder(),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return ProductContainer(
                      image: product['image']!,
                      name: product['name']!,
                      price: product['price']!,
                      description: product['description']!,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailPage(product: product),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              // Handle the Pay Now action
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaymentPage()), // Navigate to SignUpPage
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange, // Set button color to orange
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              'Pay Now',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductContainer extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final String description;
  final VoidCallback onTap;

  const ProductContainer({
    Key? key,
    required this.image,
    required this.name,
    required this.price,
    required this.description,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.all(8.0),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.star, color: Colors.yellow),
                          onPressed: () {
                            // Handle star rating
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.favorite_border, color: Colors.red),
                          onPressed: () {
                            // Handle heart icon press (e.g., add to favorites)
                          },
                        ),
                      ],
                    ),
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      price,
                      style: const TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
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

class ProductDetailPage extends StatelessWidget {
  final Map<String, String> product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(product['name']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(product['image']!),
              const SizedBox(height: 16),
              Text(
                product['name']!,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                product['description']!,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Text(
                product['price']!,
                style: const TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
