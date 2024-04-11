// MyCart.dart
import 'package:flutter/material.dart'; // Import the Flutter material library for building UIs.
import '../model/Item.dart'; // Import the Item class for representing products.
import "package:provider/provider.dart"; // Import the provider package for state management.
import "../provider/shoppingcart_provider.dart"; // Import the shopping cart provider for managing the cart state.

class MyCart extends StatelessWidget { // Define a StatelessWidget for the cart page.
  const MyCart({super.key}); // Constructor for the MyCart class.

  @override
  Widget build(BuildContext context) { // Build method to construct the UI for the cart page.
    return Scaffold( // Scaffold widget to provide a basic layout structure.
      appBar: AppBar( // AppBar widget for the app bar at the top of the page.
        title: const Text("My Cart"), // Title of the app bar.
        // automaticallyImplyLeading: false, // Option to hide the back button.
      ),
      body: Column( // Column widget to arrange child widgets vertically.
        mainAxisAlignment: MainAxisAlignment.center, // Align children at the center vertically.
        children: [ // List of child widgets inside the column.
          getItems(context), // Call the getItems method to display items in the cart.
          computeCost(), // Call the computeCost method to display the total cost.
          const Divider( // Divider widget to add a horizontal line.
            height: 4, // Height of the divider.
            thickness: 0.5, // Thickness of the divider line.
            // color: Colors.black, // Optional: color of the divider line.
          ),
          Flexible( // Flexible widget to allow children to occupy remaining space.
            child: Center( // Center widget to align children at the center horizontally.
              child: Row( // Row widget to arrange child widgets horizontally.
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Align children evenly.
                  children: [ // List of child widgets inside the row.
                    // RESET BUTTON
                    ElevatedButton( // ElevatedButton widget for the reset button.
                      onPressed: () { // Callback function when the button is pressed.
                        context.read<ShoppingCart>().removeAll(); // Remove all items from the cart.
                      },
                      child: const Text("Reset"), // Text displayed on the button.
                    ),
                    // CHECKOUT BUTTON
                    ElevatedButton( // ElevatedButton widget for the checkout button.
                      onPressed: () { // Callback function when the button is pressed.
                        Navigator.pushNamed(context, "/checkout"); // Navigate to the checkout page.
                      },
                      child: const Text("Checkout"), // Text displayed on the button.
                    ),
                  ]),
            ),
          ),
          TextButton( // TextButton widget for navigating back to the product catalog.
            child: const Text("Go back to Product Catalog"), // Text displayed on the button.
            onPressed: () { // Callback function when the button is pressed.
              Navigator.pop(context); // Navigate back to the previous page (product catalog).
            },
          ),
        ],
      ),
    );
  }

  Widget getItems(BuildContext context) { // Method to build and display items in the cart.
    List<Item> products = context.watch<ShoppingCart>().cart; // Get the list of items from the cart.
    String productname = ""; // Variable to store the name of the product.
    return products.isEmpty // Check if the cart is empty.
        ? const Text('No Items yet!') // Display a message if the cart is empty.
        : Expanded( // Expanded widget to allow the list of items to occupy remaining space.
            child: Column( // Column widget to arrange child widgets vertically.
            children: [ // List of child widgets inside the column.
              Flexible( // Flexible widget to allow the list to occupy remaining space.
                child: ListView.builder( // ListView.builder widget to build a scrollable list.
                  itemCount: products.length, // Total number of items in the cart.
                  itemBuilder: ( // Callback function to build each item in the list.
                    BuildContext context,
                    int index,
                  ) {
                    return ListTile( // ListTile widget to display each item in a list format.
                      leading: const Icon(Icons.food_bank), // Icon displayed at the beginning of each item.
                      title: Text(products[index].name), // Name of the product.
                      trailing: IconButton( // IconButton widget for the delete button.
                        icon: const Icon(Icons.delete), // Icon displayed for the delete button.
                        onPressed: () { // Callback function when the delete button is pressed.
                          productname = products[index].name; // Get the name of the product to be removed.
                          context.read<ShoppingCart>().removeItem(productname); // Remove the product from the cart.
                          if (products.isNotEmpty) { // Check if the cart is not empty after removing the product.
                            ScaffoldMessenger.of(context).showSnackBar( // Show a snackbar with a message.
                              SnackBar(
                                content: Text("$productname removed!"), // Message indicating the product is removed.
                                duration: const Duration( // Duration for how long the snackbar is displayed.
                                    seconds: 1, milliseconds: 100),
                              ),
                            );
                          } else { // If the cart becomes empty after removing the product.
                            ScaffoldMessenger.of(context).showSnackBar( // Show a snackbar with a message.
                              const SnackBar(
                                content: Text("Cart Empty!"), // Message indicating the cart is empty.
                                duration: Duration( // Duration for how long the snackbar is displayed.
                                    seconds: 1, milliseconds: 100),
                              ),
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ));
  }

  Widget computeCost() { // Method to compute and display the total cost of items in the cart.
    return Consumer<ShoppingCart>(builder: (context, cart, child) { // Consumer widget to listen for changes in the cart.
      return Text("Total: ${cart.cartTotal}"); // Text widget to display the total cost.
    });
  }
}
