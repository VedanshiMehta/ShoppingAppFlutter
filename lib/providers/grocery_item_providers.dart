import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/data/categories_details.dart';
import 'package:shoppingapp/enums/product_categories.dart';
import 'package:shoppingapp/models/grocery_item.dart';

class GroceryNotifier extends StateNotifier<GroceryItem> {
  GroceryNotifier()
      : super(GroceryItem('',
            name: '',
            quantity: 0,
            category: categories[ProductCategory.vegetables]!));
  void addGroceryItems(GroceryItem groceryItem) {
    state = groceryItem;
  }
}

final grocreyItemProvider = StateNotifierProvider<GroceryNotifier, GroceryItem>(
  (ref) => GroceryNotifier(),
);
