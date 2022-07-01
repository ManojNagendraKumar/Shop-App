import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/orders_provider.dart';

class OrdersWidget extends StatefulWidget {
  OrderItems orders;

  OrdersWidget(this.orders);

  @override
  State<OrdersWidget> createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  var isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.11,
              margin: const EdgeInsets.all(7),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 5,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ordered',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.008,
                          ),
                          Text(
                            DateFormat('dd/MM/yyyy hh:mm')
                                .format(widget.orders.dateTime!),
                            style: TextStyle(color: Colors.grey.shade600),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Text(
                        '\$${widget.orders.totalAmount!.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        icon: isExpanded
                            ? const Icon(Icons.expand_less)
                            : const Icon(Icons.expand_more))
                  ],
                ),
              ),
            ),
            if (isExpanded)
              Container(
                  padding: const EdgeInsets.all(10),
                  height: min(
                      widget.orders.products!.length *
                              MediaQuery.of(context).size.height *
                              0.05 +
                          MediaQuery.of(context).size.height * 0.2,
                      MediaQuery.of(context).size.height * 0.3),
                  child: ListView(
                    children: widget.orders.products!
                        .map((prod) => Container(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(prod.imageUrl!),
                                    ),
                                  ),
                                  Text(
                                    prod.brand!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  Text('\$${prod.price}',
                                      style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15))
                                ],
                              ),
                            ))
                        .toList(),
                  ))
          ],
        ),
      ),
    );
  }
}
