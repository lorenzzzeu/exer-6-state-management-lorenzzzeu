// MyCatalog.dart
import 'package:flutter/material.dart'; // Import Flutter material library
import '../model/Item.dart'; // Import Item model
import "package:provider/provider.dart"; // Import provider package for state management
import '../provider/shoppingcart_provider.dart'; // Import shopping cart provider

class MyCatalog extends StatefulWidget { // Define a stateful widget called MyCatalog
  const MyCatalog({Key? key}) : super(key: key); // Constructor for MyCatalog widget

  @override
  State<MyCatalog> createState() => _MyCatalogState(); // Create state for MyCatalog widget
}

class _MyCatalogState extends State<MyCatalog> { // Define the state class for MyCatalog
  List<Item> productsCatalog = [ // Initialize a list of items for the catalog
    Item("Shampoo", 10.00, 2), // Define item: Shampoo
    Item("Soap", 12, 3), // Define item: Soap
    Item("Toothpaste", 40, 3), // Define item: Toothpaste
  ];

  @override
  Widget build(BuildContext context) { // Build method for MyCatalog widget
    return Scaffold( // Scaffold widget for overall page structure
      appBar: AppBar(title: const Text("My Catalog")), // AppBar with title "My Catalog"
      body: ListView.builder( // ListView builder to display the catalog items
          itemBuilder: (BuildContext context, int index) { // Item builder function
            return ListTile( // ListTile for each item in the catalog
              leading: const Icon(Icons.star), // Leading icon for each item
              title: Text( // Title of the item
                "${productsCatalog[index].name} - ${productsCatalog[index].price}"), // Display item name and price
              trailing: TextButton( // Trailing button to add item to cart
                child: const Text("Add"), // Button text
                onPressed: () { // Button onPressed callback
                  context // Access the current context
                      .read<ShoppingCart>() // Read the shopping cart provider
                      .addItem(productsCatalog[index]); // Add the selected item to the cart
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar( // Show a snackbar indicating item addition
                    content: Text("${productsCatalog[index].name} added!"), // SnackBar content
                    duration: const Duration(seconds: 1, milliseconds: 100), // SnackBar duration
                  ));
                },
              ),
            );
          },
          itemCount: productsCatalog.length), // Total number of items in the catalog
      floatingActionButton: FloatingActionButton( // FloatingActionButton for navigating to the cart
        child: const Icon(Icons.shopping_cart), // Icon for the FloatingActionButton
        onPressed: () { // onPressed callback for the FloatingActionButton
          Navigator.pushNamed(context, "/cart"); // Navigate to the cart page when FloatingActionButton is pressed
        },
      ),
    );
  }
}
