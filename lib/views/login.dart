import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON parsing
import 'homepage.dart'; // Import the WelcomePage here
import 'register.dart'; // Import the SignUpPage here
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _isPasswordValid = true; // Track if the password is valid

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false; // Flag to track the loading state

  // Your localhost URL (update this with your actual local PHP server URL)
  final String loginUrl = "http://192.168.1.9/api/login.php"; // Fixed URL

  @override
  void initState() {
    super.initState();
    _loadLoginData(); // Load saved credentials on page load
  }

  // Load saved login data from SharedPreferences
  Future<void> _loadLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _rememberMe = prefs.getBool('rememberMe') ?? false;
      if (_rememberMe) {
        _usernameController.text = prefs.getString('username') ?? '';
        _passwordController.text = prefs.getString('password') ?? '';
      }
    });
  }

  // Method to save login data to SharedPreferences
  Future<void> _saveLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('rememberMe', _rememberMe);
    if (_rememberMe) {
      prefs.setString('username', _usernameController.text.trim());
      prefs.setString('password', _passwordController.text.trim());
    } else {
      prefs.remove('username');
      prefs.remove('password');
    }
  }

  // Perform login
  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      String enteredUsername = _usernameController.text.trim();
      String enteredPassword = _passwordController.text.trim();

      // Start the loading process
      setState(() {
        isLoading = true; // Show the loading indicator
      });

      // Send the HTTP POST request to the PHP backend
      try {
        final response = await http.post(
          Uri.parse(loginUrl),
          body: {
            'username': enteredUsername,
            'password': enteredPassword,
          },
        );

        // Check the server's response
        print('Response body: ${response.body}'); // Debug: print response body

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          if (responseData['status'] == 'success') {
            // Save the login data if login is successful
            _saveLoginData();

            // Navigate to homepage on successful login
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MyApp()), // Replace with your homepage widget
            );
          } else {
            // Handle incorrect username/password
            setState(() {
              _isPasswordValid = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(responseData['message'] ?? 'An error occurred')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Server error, please try again later')),
          );
        }
      } catch (e) {
        // Catch any error
        setState(() {
          isLoading = false;
        });
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Network error, please try again later ${e}')),
        );
      }

      // After the login process (successful or failed), hide the loading indicator
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/dark.jpg', // Ensure you have a background image in the assets folder
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Welcome Text
                  const Text(
                    'Welcome !',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white, // White color for the welcome text
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // "Login to Eagle Mart" Text centered
                  const Text(
                    'Login to Eagle Mart',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, // White color for the login text
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Username Field with Icon and Border Color Change on Focus
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: const TextStyle(color: Colors.white), // White text
                      hintText: 'Enter your username',
                      hintStyle: const TextStyle(color: Colors.white), // White hint text
                      prefixIcon: Icon(
                        Icons.person,
                        color: _usernameController.text.isEmpty
                            ? Colors.white
                            : Colors.orange, // Change icon color based on text
                      ),
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange, width: 2.0), // Orange border on focus
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: _usernameController.text.isEmpty ? Colors.grey : Colors.orange, width: 2.0), // Orange border if text exists
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Password Field with Icon and Border Color Change on Focus
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.white), // White text
                      hintText: 'Enter your password',
                      hintStyle: const TextStyle(color: Colors.white), // White hint text
                      prefixIcon: Icon(
                        Icons.lock,
                        color: _passwordController.text.isEmpty
                            ? Colors.white
                            : Colors.orange, // Change icon color based on text
                      ),
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange, width: 2.0), // Orange border on focus
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: _passwordController.text.isEmpty ? Colors.grey : Colors.orange, width: 2.0), // Orange border if text exists
                      ),
                      suffixIcon: TextButton(
                        onPressed: _isPasswordValid
                            ? () {
                          // Handle Forgot Password action
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Forgot Password clicked')),
                          );
                        }
                            : null, // Disable if password is invalid
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: _isPasswordValid ? Colors.white : Colors.red, // Red if password is invalid
                          ),
                        ),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  // Remember Me Checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (bool? value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                        activeColor: Colors.orange,
                      ),
                      const Text(
                        'Remember Me',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Show the loading indicator if isLoading is true
                  isLoading
                      ? const CircularProgressIndicator() // Show loading spinner while logging in
                      : ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange, // Orange background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // 5px radius
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // OR Text (Dark Blue, FontSize 20)
                  const Text(
                    'OR',
                    style: TextStyle(
                      color: Colors.white, // Dark Blue color
                      fontSize: 20, // Font size 20
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Centered Create New Account Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Center the button
                    children: [
                      // Create New Account Button
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to the SignUpPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignUpPage()), // Navigate to SignUpPage
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange, // Orange background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0), // 10px radius
                          ),
                        ),
                        child: const Text(
                          'Create New Account',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],

              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 35,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
