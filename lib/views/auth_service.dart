// TODO Implement this library.
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  String? _userName;
  String? get userName => _userName;

  // Example login function (replace with your backend logic)
  Future<void> login(String email, String password) async {
    // Here you should call your backend API to authenticate the user
    // For now, we're assuming the login is successful
    if (email == "user@example.com" && password == "password123") {
      _userName = "John Doe"; // Set the username when login is successful
      notifyListeners();
    } else {
      throw Exception('Invalid credentials');
    }
  }

  void logout() {
    _userName = null; // Clear the username on logout
    notifyListeners();
  }
}
