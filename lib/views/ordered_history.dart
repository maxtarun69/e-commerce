import 'package:flutter/material.dart';

class OrderHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Order #1234 - Date: 2024-11-30'),
            subtitle: const Text('Status: Delivered'),
            onTap: () {
              // View order details
            },
          ),
          ListTile(
            title: const Text('Order #5678 - Date: 2024-11-25'),
            subtitle: const Text('Status: Shipped'),
            onTap: () {
              // View order details
            },
          ),
          // Add more orders here
        ],
      ),
    );
  }
}
