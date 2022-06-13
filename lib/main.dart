import 'package:assessment2_app/screens/orders_screen.dart';
import 'package:assessment2_app/screens/products_form_screen.dart';
import 'package:assessment2_app/screens/splash_screen.dart';
import 'package:assessment2_app/screens/user_products_screen.dart';
import 'package:flutter/material.dart';
import './providers/cart_provider.dart';
import './providers/orders_provider.dart';
import './screens/favorites_screen.dart';
import './providers/items_provider.dart';
import './providers/products_file.dart';
import 'screens/product_details_screen.dart';
import './screens/home_screen.dart';
import 'package:provider/provider.dart';
import './widgets/home_widget.dart';
import './screens/cart_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctn) => Orders()),
          ChangeNotifierProvider(create: (ctn) => ItemsProvider()),
          ChangeNotifierProvider(create: (ctn) => ProductsFile()),
          ChangeNotifierProvider(create: (ctn) => Cart()),
        ],
        child: MaterialApp(
          title: 'Shop App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: Colors.blueGrey, accentColor: Colors.black),
          home: const SplashScreen(),
          routes: {
            HomeScreenWidget.routeName: (ctn) => ProductDetailsScreen(),
            HomeScreen.routeName: (ctn) => FavoritesScreen(),
            CartScreen.routeName: (ctn) => CartScreen(),
            OrdersScreen.routeName: (ctn) => OrdersScreen(),
            UserProductsScreen.routeName: (ctn) => UserProductsScreen(),
            ProductsFormScreen.routeName: (ctn) => ProductsFormScreen(),
          },
        ));
  }
}
