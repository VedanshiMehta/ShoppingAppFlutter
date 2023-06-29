import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/constants/main/main_constants.dart';
import 'package:shoppingapp/screen/groceries_screen.dart';
import 'package:shoppingapp/screen/new_item.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 147, 229, 250),
  brightness: Brightness.dark,
  surface: const Color.fromARGB(255, 42, 51, 59),
);
void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        colorScheme: kColorScheme,
        cardTheme: const CardTheme().copyWith(
            color: kColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const GroceriesScreen(),
        MainConstants.newItem: (context) => const NewItem(),
      },
      //home: GroceriesScreen(
      // groceryList: groceryItem,
      // ));
    );
  }
}
