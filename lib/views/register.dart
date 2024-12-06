import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false; // Variable to track loading state

  Future<void> registerUser(String username, String email, String password) async {
    setState(() {
      isLoading = true; // Set loading state to true when starting the request
    });

    final Uri url = Uri.parse('http://192.168.1.9//api//register.php'); // Localhost for Android Emulator

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    setState(() {
      isLoading = false; // Set loading state to false when request is completed
    });

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account created successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseBody['message'])),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to create account')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/dark.jpg', // Your background image
              fit: BoxFit.cover,
            ),
          ),
          // Centered text and form
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Welcome Text
                const Text(
                  'Welcome !',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Create A New Account ',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30), // Adds space before the form

                // Form to enter details
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey, // Form key for validation
                    child: Column(
                      children: [
                        // Username TextField with icon and validation
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: const TextStyle(color: Colors.white), // White text
                            prefixIcon: const Icon(Icons.person, color: Colors.white), // White icon
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange, width: 2.0), // Orange border on focus
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _usernameController.text.isEmpty ? Colors.grey : Colors.orange, width: 2.0),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white), // White text
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Email TextField with icon and validation
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: const TextStyle(color: Colors.white), // White text
                            prefixIcon: const Icon(Icons.email, color: Colors.white), // White icon
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange, width: 2.0), // Orange border on focus
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _emailController.text.isEmpty ? Colors.grey : Colors.orange, width: 2.0),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white), // White text
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Password TextField with icon and validation
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true, // For password input
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(color: Colors.white), // White text
                            prefixIcon: const Icon(Icons.lock, color: Colors.white), // White icon
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange, width: 2.0), // Orange border on focus
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _passwordController.text.isEmpty ? Colors.grey : Colors.orange, width: 2.0),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white), // White text
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 32),

                        // Signup button with orange background and 5px radius
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              // Call the registerUser function
                              registerUser(
                                _usernameController.text,
                                _emailController.text,
                                _passwordController.text,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange, // Orange background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0), // 5px radius
                            ),
                          ),
                          child: const Text(
                            'Register Now',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Back Button
          Positioned(
            left: 10,
            top: 35,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),

          // Circular progress indicator when loading
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: Colors.orange, // Customize color
              ),
            ),
        ],
      ),
    );
  }
}
