// main.dart
import 'package:flutter/material.dart'; // Import the material package which contains Flutter's material design widgets.
import '../screen/MyCart.dart'; // Import the MyCart screen widget.
import '../screen/MyCatalog.dart'; // Import the MyCatalog screen widget.
import '../screen/Checkout.dart'; // Import the Checkout screen widget.
import 'package:provider/provider.dart'; // Import the provider package for state management.
import '../provider/shoppingcart_provider.dart'; // Import the shopping cart provider class.

void main() {
  runApp( // Run the application.
    MultiProvider( // Use MultiProvider to provide multiple providers to the widget tree.
      providers: [ // List of providers.
        ChangeNotifierProvider(create: (context) => ShoppingCart()), // Provide a ShoppingCart instance using ChangeNotifierProvider.
      ],
      child: const MyApp(), // The root widget of the application wrapped with providers.
    ),
  );
}

class MyApp extends StatelessWidget { // Define a stateless widget MyApp.
  const MyApp({Key? key}) : super(key: key); // Constructor for MyApp.

  @override
  Widget build(BuildContext context) { // Build method for MyApp widget.
    return MaterialApp( // Return a MaterialApp widget.
      title: 'Exercise 6', // Set the title of the application.
      theme: ThemeData( // Set the theme data for the application.
        primarySwatch: Colors.blue, // Set the primary color swatch to blue.
      ),
      initialRoute: '/', // Set the initial route of the application to '/'.
      routes: { // Define named routes for the application.
        '/': (context) => const MyCatalog(), // Define the '/' route to show MyCatalog screen.
        '/cart': (context) => const MyCart(), // Define the '/cart' route to show MyCart screen.
        '/checkout': (context) => const Checkout(), // Define the '/checkout' route to show Checkout screen.
      },
    );
  }
}