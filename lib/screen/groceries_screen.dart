import 'package:flutter/material.dart';
import 'package:shoppingapp/models/grocery_item.dart';
import 'package:shoppingapp/widgets/grocery_items.dart';

class GroceriesScreen extends StatelessWidget {
  const GroceriesScreen({super.key, required this.groceryList});
  final List<GroceryItem> groceryList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: groceryList.length,
        itemBuilder: ((context, index) =>
            GroceryItems(groceryItem: groceryList[index])),
      ),
    );
  }
}
