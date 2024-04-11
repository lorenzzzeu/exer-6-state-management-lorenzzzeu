// Checkout.dart
import 'package:flutter/material.dart'; // Import Flutter Material library
import 'package:provider/provider.dart'; // Import Provider library for state management
import '../provider/shoppingcart_provider.dart'; // Import shopping cart provider

class Checkout extends StatelessWidget { // Define a StatelessWidget named Checkout
  const Checkout({Key? key}) : super(key: key); // Constructor for Checkout widget

  @override
  Widget build(BuildContext context) { // Build method for building the UI of the Checkout widget
    final cart = Provider.of<ShoppingCart>(context); // Access the ShoppingCart instance using Provider

    return Scaffold( // Scaffold widget for the main structure of the page
      appBar: AppBar( // AppBar at the top of the page
        title: const Text('Checkout'), // Title of the app bar
      ),
      body: Padding( // Padding around the body content
        padding: const EdgeInsets.all(16.0), // Padding of 16 pixels on all sides
        child: Column( // Column to arrange content vertically
          crossAxisAlignment: CrossAxisAlignment.start, // Align content to start (left) horizontally
          children: [ // List of children widgets
            const Text( // Text widget with 'Item Details' text
              'Item Details', // Text content
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Text style
            ),
            const SizedBox(height: 10), // Empty space with height of 10 pixels
            Expanded( // Expanded widget to allow ListView to take remaining space
              child: cart.cart.isEmpty // Conditional rendering based on cart content
                  ? Center( // Center widget to center child vertically and horizontally
                      child: Text( // Text widget to display message when cart is empty
                        'No items to checkout', // Text content
                        style: TextStyle(fontSize: 16), // Text style
                      ),
                    )
                  : ListView.builder( // ListView.builder to display list of items in cart
                      itemCount: cart.cart.length, // Total number of items in cart
                      itemBuilder: (context, index) { // ItemBuilder to build each item in the list
                        final item = cart.cart[index]; // Get item at current index
                        return ListTile( // ListTile to display each item
                          title: Text(item.name), // Title of the item
                          trailing: Text('\$${item.price.toStringAsFixed(2)}'), // Price of the item
                        );
                      },
                    ),
            ),
            if (cart.cart.isNotEmpty) ...[ // Conditional rendering for cart content
              const Divider(), // Divider widget to separate items from total cost
              Row( // Row widget to display total cost and "Total Cost to Pay" text
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space evenly between children horizontally
                children: [
                  const Text( // Text widget with "Total Cost to Pay:" text
                    'Total Cost to Pay:', // Text content
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Text style
                  ),
                  Text( // Text widget to display total cost
                    '\$${cart.cartTotal.toStringAsFixed(2)}', // Total cost
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Text style
                  ),
                ],
              ),
              const SizedBox(height: 20), // Empty space with height of 20 pixels
              Center( // Center widget to center child horizontally
                child: ElevatedButton( // ElevatedButton widget for "Pay Now" button
                  onPressed: () { // Callback function when button is pressed
                    cart.removeAll(); // Remove all items from cart
                    ScaffoldMessenger.of(context).showSnackBar( // Show snackbar with payment success message
                      const SnackBar(
                        content: Text('Payment Successful!'), // SnackBar content
                        duration: Duration(seconds: 2), // Duration to show snackbar
                      ),
                    );
                    Navigator.of(context).pop(); // Pop from the Checkout page
                    Navigator.of(context).pop(); // Pop from the Cart page and go back to the main page
                  },
                  child: const Text('Pay Now'), // Button text
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
