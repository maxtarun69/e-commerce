import 'package:firstproject/views/home_page.dart';
import 'package:flutter/material.dart';
import 'views/login.dart';
import 'views/products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/dark.jpg'), // Your background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Cross icon at the top right corner
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () {
                // Navigate to the ProductPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const Back_ground()),
                );
              },
            ),
          ),
          // Main content in the center
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png', // Logo in the center
                  height: 100, // Set height of the logo image
                  width: 100,  // Set width of the logo image
                ),
                const SizedBox(height: 20), // Space between logo and text
                const Text(
                  'Welcome to EgleMart',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40), // Space before the login button
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the Login page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, // Button color
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15), // Button padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Rounded corners
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Space between login button and horizontal line
                // Horizontal line
                const Divider(
                  color: Colors.white,
                  thickness: 1,
                  indent: 50,
                  endIndent: 50,
                ),
                const SizedBox(height: 20), // Space between horizontal line and "Continue with Login" text
                const Text(
                  'Continue with Login',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Positioned icons for Google and Facebook at the bottom
          Positioned(
            bottom: 30,
            left: 50,
            right: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Google icon button
                IconButton(
                  icon: const Icon(
                    Icons.account_circle, // Placeholder icon, use the correct one for Google
                    size: 50,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // Handle Google sign-in action
                  },
                ),
                // Facebook icon button
                IconButton(
                  icon: const Icon(
                    Icons.facebook, // Placeholder icon, use the correct one for Facebook
                    size: 50,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // Handle Facebook sign-in action
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
