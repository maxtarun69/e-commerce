import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop Categories'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Category 1'),
            onTap: () {
              // Navigate to a specific category or product list
            },
          ),
          ListTile(
            title: const Text('Category 2'),
            onTap: () {
              // Navigate to another category
            },
          ),
          ListTile(
            title: const Text('Category 3'),
            onTap: () {
              // Navigate to another category
            },
          ),
        ],
      ),
    );
  }
}
