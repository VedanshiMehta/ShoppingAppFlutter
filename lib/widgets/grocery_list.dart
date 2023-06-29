import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/models/grocery_item.dart';

class GroceryList extends ConsumerWidget {
  const GroceryList(
      {super.key, required this.groceryList, required this.onSwap});
  final List<GroceryItem> groceryList;
  final void Function(GroceryItem groceryItem) onSwap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: groceryList.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(groceryList[index].id),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.6),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        onDismissed: (direction) => {
          onSwap(groceryList[index]),
        },
        child: ListTile(
          title: Text(groceryList[index].name),
          leading: Container(
            width: 24,
            height: 24,
            color: groceryList[index].category.color,
          ),
          trailing: Text(
            groceryList[index].quantity.toString(),
          ),
        ),
      ),
    );
  }
}
