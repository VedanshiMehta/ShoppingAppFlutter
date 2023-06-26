import 'package:flutter/material.dart';
import 'package:shoppingapp/data/grocery_details.dart';
import 'package:shoppingapp/screen/groceries_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //title:'Flutter Groceries',
        theme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 147, 229, 250),
            brightness: Brightness.dark,
            surface: const Color.fromARGB(255, 42, 51, 59),
          ),
        ),
        home: GroceriesScreen(
          groceryList: groceryItem,
        ));
  }
}
