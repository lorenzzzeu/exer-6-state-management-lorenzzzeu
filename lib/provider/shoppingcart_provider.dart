// shoppingcart_provider.dart

// Importing the necessary packages
import 'package:flutter/material.dart';
import '../model/Item.dart';

// Defining a class named ShoppingCart which extends ChangeNotifier to enable listening for changes
class ShoppingCart with ChangeNotifier {
  
  // Declaring private variables to store the shopping list and the total cost of the items in the cart
  final List<Item> _shoppingList = [];
  double cartTotal = 0;

  // Getter method to retrieve the shopping list
  List<Item> get cart => _shoppingList;

  // Method to add an item to the shopping list and update the total cost
  void addItem(Item item) {
    _shoppingList.add(item);
    cartTotal = cartTotal + item.price;
    // Notifying any listeners that the data has changed
    notifyListeners();
  }

  // Method to remove all items from the shopping list and reset the total cost
  void removeAll() {
    _shoppingList.clear();
    cartTotal = 0;
    // Notifying any listeners that the data has changed
    notifyListeners();
  }

  // Method to remove a specific item from the shopping list and update the total cost
  void removeItem(String name) {
    for (int i = 0; i < _shoppingList.length; i++) {
      if (_shoppingList[i].name == name) {
        cartTotal = cartTotal - _shoppingList[i].price;
        _shoppingList.remove(_shoppingList[i]);
        break;
      }
    }
    // Notifying any listeners that the data has changed
    notifyListeners();
  }

  // Method to simulate the payment process by clearing the shopping list and resetting the total cost
  void pay() {
    _shoppingList.clear();
    cartTotal = 0;
    // Notifying any listeners that the data has changed
    notifyListeners();
  }
}
