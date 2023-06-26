import 'package:flutter/material.dart';
import 'package:shoppingapp/enums/product_categories.dart';
import 'package:shoppingapp/models/category.dart';

const categories = {
  ProductCategory.vegetables: Category(
    'Vegetables',
    Color.fromARGB(255, 0, 255, 128),
  ),
  ProductCategory.fruit: Category(
    'Fruit',
    Color.fromARGB(255, 145, 255, 0),
  ),
  ProductCategory.meat: Category(
    'Meat',
    Color.fromARGB(255, 255, 102, 0),
  ),
  ProductCategory.dairy: Category(
    'Dairy',
    Color.fromARGB(255, 0, 208, 255),
  ),
  ProductCategory.carbs: Category(
    'Carbs',
    Color.fromARGB(255, 0, 60, 255),
  ),
  ProductCategory.sweets: Category(
    'Sweets',
    Color.fromARGB(255, 255, 149, 0),
  ),
  ProductCategory.spices: Category(
    'Spices',
    Color.fromARGB(255, 255, 187, 0),
  ),
  ProductCategory.convenience: Category(
    'Convenience',
    Color.fromARGB(255, 191, 0, 255),
  ),
  ProductCategory.hygiene: Category(
    'Hygiene',
    Color.fromARGB(255, 149, 0, 255),
  ),
  ProductCategory.other: Category(
    'Other',
    Color.fromARGB(255, 0, 225, 255),
  ),
};
