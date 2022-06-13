import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/orders_widget.dart';
import 'package:provider/provider.dart';
import '../providers/orders_provider.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    final orderItems = orders.orderItems;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Orders',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: orderItems.isEmpty
          ? const Center(
              child: Text(
                'No Orders placed!!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            )
          : _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                )
              : ListView.builder(
                  itemCount: orders.orderItems.length,
                  itemBuilder: (context, index) {
                    return OrdersWidget(orderItems[index]);
                  },
                ),
      drawer: AppDrawer(),
    );
  }
}
