import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing the dialog
      builder: (BuildContext context) {
        return const Dialog(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text('Loading...', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        );
      },
    );
  }

  void hideLoadingDialog(BuildContext context) {
    Navigator.pop(context); // Close the dialog
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dialog Loading Indicator')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showLoadingDialog(context);
            // Simulate a time-consuming task
            Future.delayed(const Duration(seconds: 3), () {
              hideLoadingDialog(context);
            });
          },
          child: const Text('Show Loading'),
        ),
      ),
    );
  }
}
