import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
 // Import MyApp if it's in a different file

Future<void> logout(BuildContext context) async {
  // Replace this URL with your localhost or deployed API URL
  const String url = 'http://192.168.1.9//api//logout.php';

  // Send a GET request (or POST if required) to the logout endpoint
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // The API response is successful, handle it here
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == 'success') {
      // Clear the user's authentication token from shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');  // Adjust the key based on your app's token

      // Display logout success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logged out successfully')),
      );

      // Close the drawer
      Navigator.pop(context);

      // Redirect to MyApp (main page)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyApp()), // Navigate to MyApp screen
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed: ${responseBody['message']}')),
      );
    }
  } else {
    // If the request failed, show an error message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to log out. Try again later.')),
    );
  }
}
