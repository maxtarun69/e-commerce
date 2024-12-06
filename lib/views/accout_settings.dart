import 'package:flutter/material.dart';

class AccountSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Settings'),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: const Text('Edit Profile'),
            onTap: () {
              // Navigate to profile editing page
            },
          ),
          ListTile(
            title: const Text('Change Password'),
            onTap: () {
              // Navigate to change password page
            },
          ),
          ListTile(
            title: const Text('Payment Methods'),
            onTap: () {
              // Navigate to payment methods page
            },
          ),
          ListTile(
            title: const Text('Shipping Address'),
            onTap: () {
              // Navigate to shipping address page
            },
          ),
        ],
      ),
    );
  }
}
