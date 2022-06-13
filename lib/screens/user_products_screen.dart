import 'package:flutter/material.dart';
import '../providers/items_provider.dart';
import '../screens/Products_form_screen.dart';
import '../widgets/user_products_widget.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/manageProducts';

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ItemsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Manage Products',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(ProductsFormScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
          itemCount: products.items.length,
          itemBuilder: (context, index) {
            return UserProductsWidget(products.items[index]);
          }),
    );
  }
}
