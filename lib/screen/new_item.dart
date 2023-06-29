import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/constants/url/url_constants.dart';
import 'package:shoppingapp/data/categories_details.dart';
import 'package:shoppingapp/enums/product_categories.dart';
import 'package:shoppingapp/models/grocery_item.dart';
import 'package:shoppingapp/providers/grocery_item_providers.dart';
import 'package:shoppingapp/rest_services/firebase_helper.dart';
import 'package:shoppingapp/utils/utils.dart';

class NewItem extends ConsumerStatefulWidget {
  const NewItem({super.key});
  @override
  ConsumerState<NewItem> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends ConsumerState<NewItem> {
  final _formKey = GlobalKey<FormState>();
  var nameTextField = '';
  var quantityTextField = 1;
  var selectedCategory = categories[ProductCategory.vegetables]!;
  var _isSending = false;
  void onAddItemTap() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isSending = true;
      });
      var groceryMapList = {
        'name': nameTextField,
        'quantity': quantityTextField,
        'category': selectedCategory.productName,
      };
      var result = await FireBaseHelper.postAsync<GroceryItem>(
        groceryMapList,
        UrlConstants.datafileName,
      );
      if (!context.mounted) {
        return;
      }
      if (result.isValid) {
        var groceryItem = GroceryItem(result.list['name'],
            name: nameTextField,
            quantity: quantityTextField,
            category: selectedCategory);

        ref.read(grocreyItemProvider.notifier).addGroceryItems(groceryItem);
        Utils.showMessage(context, result.message);
        Navigator.pop(context);
      } else {
        Utils.showMessage(context, result.message);
        setState(() {
          _isSending = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add anew item'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Name'),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.trim().length > 50) {
                      return 'Must be between 1 and 50 characters.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    nameTextField = value!;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          label: Text('Quantity'),
                          border: OutlineInputBorder(),
                        ),
                        initialValue: quantityTextField.toString(),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.tryParse(value) == null ||
                              int.tryParse(value)! <= 0) {
                            return 'Must be valid,positve number.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          quantityTextField = int.parse(value!);
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField(
                          value: selectedCategory,
                          items: [
                            ...categories.entries.map(
                              (category) => DropdownMenuItem(
                                value: category.value,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      color: category.value.color,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(category.value.productName),
                                  ],
                                ),
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value!;
                            });
                          }),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _isSending
                          ? null
                          : () {
                              _formKey.currentState!.reset();
                            },
                      child: const Text('Reset'),
                    ),
                    ElevatedButton(
                        onPressed: _isSending ? null : () => onAddItemTap(),
                        child: _isSending
                            ? const SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(),
                              )
                            : const Text('Add item'))
                  ],
                )
              ],
            )),
      ),
    );
  }
}
