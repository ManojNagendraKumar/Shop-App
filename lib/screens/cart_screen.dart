import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../providers/cart_provider.dart';
import 'package:provider/provider.dart';
import '../providers/orders_provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cartscreen';

  Future<void> _flutterToast(String message) async {
    await Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        fontSize: 16);
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final cartItems = cart.cartItems;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Bag',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: cart.cartItems.isEmpty
          ? const Center(
              child: Text(
                'Your bag is empty..!',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            )
          : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 10, left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 172, 210, 241),
                    Colors.white,
                  ]),
                ),
                child: const Text(
                  'Offer Price applies on 1000\$ or above',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (ctn, index) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 10,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: ClipRRect(
                                      child: Image.network(
                                        cartItems.values
                                            .toList()[index]
                                            .imageUrl!,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.125,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      height: 130,
                                      alignment: Alignment.topLeft,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cartItems.values
                                                .toList()[index]
                                                .brand!,
                                            style: TextStyle(
                                                color: Colors.grey.shade700,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.003,
                                          ),
                                          SizedBox(
                                            child: Text(
                                              cartItems.values
                                                  .toList()[index]
                                                  .description!,
                                              overflow: TextOverflow.fade,
                                              softWrap: false,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.015,
                                          ),
                                          Text(
                                            '\$${cartItems.values.toList()[index].price!}',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.015,
                                          ),
                                          Text(
                                            'Offer price : \$${(cartItems.values.toList()[index].price! * 0.8).toStringAsFixed(0)}',
                                            style: TextStyle(
                                                color: Colors.teal.shade500,
                                                fontWeight: FontWeight.w900,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const Divider(
                                height: 1,
                                thickness: 2,
                              ),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Quantity: ${cartItems.values.toList()[index].quantity}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            cart.removeItems(
                                                cartItems.keys.toList()[index]);
                                          },
                                          child: const Text(
                                            'Remove',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 120, 218),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          )),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey.shade400,
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '\$${cart.totalAmount.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                        const Text(
                          'View details',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 120, 218),
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.055,
                      width: MediaQuery.of(context).size.width * 0.45,
                      margin: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.black),
                          onPressed: () {
                            _flutterToast(
                              'Order Placed',
                            );
                            Provider.of<Orders>(context, listen: false)
                                .addOrders(cartItems.values.toList(),
                                    cart.totalAmount);
                            cart.emptyCartItems();
                          },
                          child: const Text(
                            'Confirm Order',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          )),
                    )
                  ],
                ),
              )
            ]),
    );
  }
}
