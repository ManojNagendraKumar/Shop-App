import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_file.dart';

class FavoritesScreenWidget extends StatelessWidget {
  static const routeName = '/itemDetails';

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsFile>(context, listen: true);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(routeName, arguments: {
          'id': products.id,
          'isFavorite': products.isFavorite,
        });
      },
      onDoubleTap: () {
        products.showFavorites(products.id!);
      },
      child: Column(
        children: [
          Stack(alignment: Alignment.bottomRight, children: [
            ClipRRect(
              child: Image.network(
                products.imageUrl!,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.28,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            Positioned(
              height: 40,
              right: 2,
              bottom: 1,
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.08,
                margin: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: products.isFavorite!
                      ? const Icon(Icons.favorite_rounded,
                          size: 17, color: Colors.red)
                      : const Icon(
                          Icons.favorite_border_rounded,
                          size: 20,
                          color: Colors.black54,
                        ),
                  onPressed: () {
                    products.showFavorites(products.id!);
                  },
                ),
              ),
            )
          ]),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              products.brand!,
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15.5,
                  color: Colors.grey.shade800),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.009,
          ),
          Container(
              alignment: Alignment.centerLeft,
              child: Text(
                products.description!,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
              alignment: Alignment.centerLeft,
              child: Text(
                '\$${products.price!}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Offer price : \$${(products.price! * 0.8).toStringAsFixed(0)}',
              style: TextStyle(
                  color: Colors.teal.shade500,
                  fontWeight: FontWeight.w900,
                  fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}
