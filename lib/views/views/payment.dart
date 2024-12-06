import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController upiController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardExpiryController = TextEditingController();
  final TextEditingController cardCVVController = TextEditingController();

  // Variables to track if the text fields have values
  bool isUpiFilled = false;
  bool isCardFilled = false;

  // Method to check whether the fields are filled and change state accordingly
  void updateFieldStatus() {
    setState(() {
      isUpiFilled = upiController.text.isNotEmpty;
      isCardFilled = cardNumberController.text.isNotEmpty &&
          cardExpiryController.text.isNotEmpty &&
          cardCVVController.text.isNotEmpty;
    });
  }

  // Function to process UPI payment (Placeholder logic)
  void processUPIPayment(String upiID) {
    print('Processing UPI payment for $upiID');
    // After UPI payment logic, navigate to Thank You page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ThankYouPage()),
    );
  }

  // Function to process Card payment (Placeholder logic)
  void processCardPayment(String cardNumber, String expiry, String cvv) {
    print('Processing card payment for $cardNumber');
    // After Card payment logic, navigate to Thank You page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ThankYouPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Gateway'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo Section (Placeholder, replace with your actual image asset)
            Center(
              child: Image.asset('assets/images/upi.png', height: 100), // Replace with your logo asset
            ),
            SizedBox(height: 20),

            // Payment Method Icons Section
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[200],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/images/pay.png', height: 40), // PayPal logo
                  Image.asset('assets/images/UPI-payment.jpg', height: 40),   // Visa logo
                ],
              ),
            ),
            const SizedBox(height: 20),

            // UPI Section
            const Text('UPI Payment', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: upiController,
              decoration: const InputDecoration(
                labelText: 'Enter UPI ID',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
              onChanged: (value) {
                updateFieldStatus();
              },
            ),
            const SizedBox(height: 16),

            // Card Section
            const Text('Card Payment', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: cardNumberController,
              decoration: const InputDecoration(
                labelText: 'Enter Card Number',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                updateFieldStatus();
              },
            ),
            const SizedBox(height: 8),
            TextField(
              controller: cardExpiryController,
              decoration: const InputDecoration(
                labelText: 'MM/YY Expiry',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
              keyboardType: TextInputType.datetime,
              onChanged: (value) {
                updateFieldStatus();
              },
            ),
            const SizedBox(height: 8),
            TextField(
              controller: cardCVVController,
              decoration: const InputDecoration(
                labelText: 'Enter CVV',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                updateFieldStatus();
              },
            ),
            const SizedBox(height: 20),

            // Full-Width Pay Now Button with Orange color
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // Button color
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  String upi = upiController.text;
                  String cardNumber = cardNumberController.text;
                  String expiry = cardExpiryController.text;
                  String cvv = cardCVVController.text;

                  if (upi.isNotEmpty) {
                    // Process UPI payment
                    processUPIPayment(upi);
                  } else if (cardNumber.isNotEmpty &&
                      expiry.isNotEmpty &&
                      cvv.isNotEmpty) {
                    // Process Card payment
                    processCardPayment(cardNumber, expiry, cvv);
                  } else {
                    // Show error
                    print("Please enter valid details.");
                  }
                },
                child: const Text('Pay Now', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Thank You Page after payment
class ThankYouPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thank You for Shopping'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, size: 100, color: Colors.green),
              SizedBox(height: 20),
              Text(
                'Thank you for your purchase!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Your payment has been successfully processed.',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
