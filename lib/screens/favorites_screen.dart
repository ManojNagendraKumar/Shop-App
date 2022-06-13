import 'package:flutter/material.dart';
import '../providers/items_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/favorites_widget.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ItemsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Wishlist',
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: products.showOnlyFavorite.isEmpty
          ? const Center(
              child: Text(
                'Empty List ..!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(13),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 2.1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 5),
              itemCount: products.showOnlyFavorite.length,
              itemBuilder: (ctn, index) {
                return ChangeNotifierProvider.value(
                    value: products.showOnlyFavorite[index],
                    child: FavoritesScreenWidget());
              },
            ),
    );
  }
}
