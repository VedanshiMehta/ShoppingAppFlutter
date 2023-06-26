import 'package:flutter/material.dart';
import 'package:shoppingapp/models/grocery_item.dart';

class GroceryItems extends StatelessWidget {
  const GroceryItems({super.key, required this.groceryItem});
  final GroceryItem groceryItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            color: groceryItem.category.color,
          ),
          const SizedBox(width: 20),
          Text(groceryItem.name),
          const Spacer(),
          Text(groceryItem.quantity.toString()),
        ],
      ),
    );
  }
}
