import 'package:assessment2_app/providers/items_provider.dart';
import 'package:assessment2_app/providers/products_file.dart';
import 'package:assessment2_app/screens/products_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductsWidget extends StatelessWidget {
  ProductsFile product;

  UserProductsWidget(this.product);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            product.imageUrl!,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          '${product.brand}',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        trailing: Container(
          width: MediaQuery.of(context).size.width * 0.25,
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                        ProductsFormScreen.routeName,
                        arguments: product);
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: () {
                    Provider.of<ItemsProvider>(context, listen: false)
                        .deleteItems(product.id!);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
