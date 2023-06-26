import 'package:shoppingapp/data/categories_details.dart';
import 'package:shoppingapp/enums/product_categories.dart';
import 'package:shoppingapp/models/grocery_item.dart';

final groceryItem = [
  GroceryItem(
      id: 'a',
      name: 'Milk',
      quantity: 1,
      category: categories[ProductCategory.dairy]!),
  GroceryItem(
      id: 'b',
      name: 'Bananas',
      quantity: 5,
      category: categories[ProductCategory.fruit]!),
  GroceryItem(
      id: 'c',
      name: 'Beef Steak',
      quantity: 1,
      category: categories[ProductCategory.meat]!),
];
