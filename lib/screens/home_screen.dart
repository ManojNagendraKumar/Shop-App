import 'package:assessment2_app/providers/cart_provider.dart';
import 'package:assessment2_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import '../widgets/home_widget.dart';
import '../providers/items_provider.dart';
import 'package:provider/provider.dart';
import './cart_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/wishlist';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isLoading = false;
  var _isInit = true;
  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<ItemsProvider>(context).fetchAndSetItems();
    }
    setState(() {
      _isLoading = false;
    });
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final productItems = Provider.of<ItemsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AJIO',
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(HomeScreen.routeName);
              },
              icon: const Icon(
                Icons.favorite,
                color: Colors.black54,
                size: 29,
              )),
          Stack(children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: const Icon(
                Icons.shopping_bag_rounded,
                color: Colors.black54,
                size: 29,
              ),
            ),
            Positioned(
              right: 7,
              top: 6,
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.04,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.red.shade400),
                child: Text(
                  '${cart.cartItems.length}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )
          ]),
          SizedBox(width: MediaQuery.of(context).size.width * 0.02),
        ],
        backgroundColor: Colors.white,
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 2.1,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 5),
              itemCount: productItems.items.length,
              itemBuilder: (ctn, index) {
                return ChangeNotifierProvider.value(
                    value: productItems.items[index],
                    child: HomeScreenWidget());
              },
            ),
    );
  }
}
