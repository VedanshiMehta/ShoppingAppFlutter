import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/constants/main/main_constants.dart';
import 'package:shoppingapp/constants/url/url_constants.dart';
import 'package:shoppingapp/data/categories_details.dart';
import 'package:shoppingapp/models/grocery_item.dart';
import 'package:shoppingapp/providers/grocery_item_providers.dart';
//import 'package:shoppingapp/providers/grocery_item_providers.dart';
import 'package:shoppingapp/rest_services/firebase_helper.dart';
import 'package:shoppingapp/utils/utils.dart';
import 'package:shoppingapp/widgets/empty_screen.dart';
import 'package:shoppingapp/widgets/grocery_list.dart';

class GroceriesScreen extends ConsumerStatefulWidget {
  const GroceriesScreen({super.key});

  @override
  ConsumerState<GroceriesScreen> createState() => _GroceriesScreenState();
}

class _GroceriesScreenState extends ConsumerState<GroceriesScreen> {
  List<GroceryItem> groceryList = [];
  var _isLoading = true;
  @override
  void initState() {
    super.initState();
    getGroceryItems();
  }

  void getGroceryItems() async {
    final List<GroceryItem> loadItem = [];
    final result = await FireBaseHelper.getAsync(UrlConstants.datafileName);
    if (!context.mounted) {
      return;
    }
    if (!result.isValid) {
      Utils.showMessage(context, result.message);
      setState(() {
        _isLoading = false;
      });
    } else {
      for (final items in result.list.entries) {
        final catergory = categories.entries
            .firstWhere((catItem) =>
                catItem.value.productName == items.value['category'])
            .value;

        loadItem.add(
          GroceryItem(
            items.key,
            name: items.value['name'],
            quantity: items.value['quantity'],
            category: catergory,
          ),
        );
      }
      setState(() {
        groceryList = loadItem;
        _isLoading = false;
      });
    }
  }

  void onSwapTap(GroceryItem item) async {
    var result =
        await FireBaseHelper.deleteAsync('shoppingapp/${item.id}.json');
    if (!context.mounted) {
      return;
    }
    if (result.isValid) {
      setState(
        () {
          groceryList.remove(item);
        },
      );
      Utils.showMessage(context, result.message);
    } else {
      Utils.showMessage(context, result.message);
    }
  }

  void onAddTap() async {
    await Navigator.pushNamed(context, MainConstants.newItem);
    setState(() {
      groceryList.add(ref.watch(grocreyItemProvider));
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget onScreenWidget = const EmptyScreen(
      text: 'Uh...nothing there',
    );
    if (_isLoading) {
      onScreenWidget = const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (groceryList.isNotEmpty) {
      onScreenWidget = GroceryList(
        groceryList: groceryList,
        onSwap: (groceryItem) => onSwapTap(groceryItem),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        centerTitle: false,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => onAddTap(),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: onScreenWidget,
    );
  }
}

//using future builder
// class _GroceriesScreenState extends ConsumerState<GroceriesScreen> {
//   List<GroceryItem> groceryList = [];
//   late Future<List<GroceryItem>> items;
//   //var _isLoading = true;
//   @override
//   void initState() {
//     super.initState();
//     items = getGroceryItems();
//     //getGroceryItems();
//   }

//   Future<List<GroceryItem>> getGroceryItems() async {
//     final List<GroceryItem> loadItem = [];
//     final result = await FireBaseHelper.getAsync(UrlConstants.datafileName);
//     // if (!context.mounted) {
//     //   return [];
//     // }
//     if (!result.isValid) {
//       throw Exception(result.message);
//       //Utils.showMessage(context, result.message);
//       // setState(() {
//       //   _isLoading = false;
//       // }
//       // );
//     } //else {
//     for (final items in result.list.entries) {
//       final catergory = categories.entries
//           .firstWhere(
//               (catItem) => catItem.value.productName == items.value['category'])
//           .value;

//       loadItem.add(
//         GroceryItem(
//           items.key,
//           name: items.value['name'],
//           quantity: items.value['quantity'],
//           category: catergory,
//         ),
//       );
//     }
//     return loadItem;
//     // setState(() {
//     //   groceryList = loadItem;
//     //   _isLoading = false;
//     // });
//     //}
//   }

//   void onSwapTap(GroceryItem item) async {
//     var result =
//         await FireBaseHelper.deleteAsync('shoppingapp/${item.id}.json');
//     if (!context.mounted) {
//       return;
//     }
//     if (result.isValid) {
//       setState(
//         () {
//           groceryList.remove(item);
//         },
//       );
//       Utils.showMessage(context, result.message);
//     } else {
//       Utils.showMessage(context, result.message);
//     }
//   }

//   void onAddTap() async {
//     await Navigator.pushNamed(context, MainConstants.newItem);
//     setState(() {
//       groceryList.add(ref.watch(grocreyItemProvider));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     //Widget onScreenWidget = const EmptyScreen();
//     // if (_isLoading) {
//     //   onScreenWidget = const Center(
//     //     child: CircularProgressIndicator(),
//     //   );
//     // }
//     // if (groceryList.isNotEmpty) {
//     //   onScreenWidget = GroceryList(
//     //     groceryList: groceryList,
//     //     onSwap: (groceryItem) => onSwapTap(groceryItem),
//     //   );
//     // }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Your Groceries'),
//         centerTitle: false,
//         elevation: 0,
//         actions: [
//           IconButton(
//             onPressed: () => onAddTap(),
//             icon: const Icon(Icons.add),
//           ),
//         ],
//       ),
//       body: FutureBuilder(
//         future: items,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if (snapshot.hasError) {
//             return EmptyScreen(
//               text: snapshot.error.toString(),
//             );
//           }
//           if (snapshot.data!.isEmpty) {
//             return const EmptyScreen(
//               text: 'Uh..Nothing to show here',
//             );
//           }
//           return GroceryList(
//             groceryList: snapshot.data!,
//             onSwap: (groceryItem) => onSwapTap(groceryItem),
//           );
//         },
//       ),
//     );
//   }
// }
