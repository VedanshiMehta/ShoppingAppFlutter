import 'package:shoppingapp/models/category.dart';

class GroceryItem {
  GroceryItem(
    this.id, {
    required this.name,
    required this.quantity,
    required this.category,
  });

  final String id;
  final String name;
  final int quantity;
  final Category category;
}
