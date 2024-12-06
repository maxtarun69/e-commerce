import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Order #1234 has been shipped'),
            subtitle: const Text('2024-11-30'),
            onTap: () {
              // View more details of the notification
            },
          ),
          ListTile(
            title: const Text('Your wishlist item is back in stock'),
            subtitle: const Text('2024-11-29'),
            onTap: () {
              // View more details of the notification
            },
          ),
          // Add more notifications here
        ],
      ),
    );
  }
}
