import 'package:assessment2_app/providers/items_provider.dart';
import 'package:assessment2_app/providers/products_file.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsFormScreen extends StatefulWidget {
  static const routeName = '/addProductsInForm';

  @override
  State<ProductsFormScreen> createState() => _ProductsFormScreenState();
}

class _ProductsFormScreenState extends State<ProductsFormScreen> {
  FocusNode? _brandFocusNode;
  FocusNode? _descriptionFocusNode;
  FocusNode? _priceFocusNode;
  FocusNode? _imageFocusNode;
  var didChange = true;
  TextEditingController? imageUrl = TextEditingController();
  ProductsFile? individualProduct;
  Map<String, dynamic> product = {
    'id': null,
    'brand': '',
    'description': '',
    'price': '',
    'imageUrl': ''
  };
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    if (didChange) {
      individualProduct =
          ModalRoute.of(context)!.settings.arguments as ProductsFile?;

      if (individualProduct == null) {
        imageUrl!.text = '';
      } else {
        product['id'] = individualProduct!.id;
        imageUrl!.text = individualProduct!.imageUrl!;
      }
    }
    didChange = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    _brandFocusNode = FocusNode();
    _descriptionFocusNode = FocusNode();
    _priceFocusNode = FocusNode();
    _imageFocusNode = FocusNode();
  }

  Future<void> _saveForm() async {
    final check = imageUrl!.text;
    _formKey.currentState!.save();
    try {
      if (product['id'] != null) {
        await Provider.of<ItemsProvider>(context, listen: false)
            .updateItems(product);
      } else {
        await Provider.of<ItemsProvider>(context, listen: false)
            .addItems(product);
      }
    } catch (error) {
      await showDialog<void>(
          context: context,
          builder: (ctn) => AlertDialog(
                title: const Text('Alert Message'),
                content: const Text('Something went wrong'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Okay'))
                ],
              ));
    } finally {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _brandFocusNode!.dispose();
    _descriptionFocusNode!.dispose();
    _priceFocusNode!.dispose();
    _imageFocusNode!.dispose();
    super.dispose();
  }

  void _requestFocus(FocusNode? focusNode) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Add Products',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
              onPressed: () {
                _saveForm();
              },
              icon: const Icon(Icons.save_rounded))
        ],
      ),
      body: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(10),
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    TextFormField(
                      initialValue: individualProduct == null
                          ? product['brand']
                          : individualProduct!.brand,
                      focusNode: _brandFocusNode,
                      onSaved: (value) {
                        product['brand'] = value!;
                      },
                      onTap: () => _requestFocus(_brandFocusNode!),
                      cursorColor: Colors.black,
                      cursorHeight: 20,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(width: 1, color: Colors.grey)),
                        labelText: 'Brand',
                        labelStyle: TextStyle(
                            color: _brandFocusNode!.hasFocus
                                ? Colors.black
                                : Colors.grey),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                width: 2, color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    TextFormField(
                      initialValue: individualProduct == null
                          ? product['description']
                          : individualProduct!.description,
                      maxLines: 2,
                      focusNode: _descriptionFocusNode,
                      onSaved: (value) {
                        product['description'] = value!;
                      },
                      onTap: () => _requestFocus(_descriptionFocusNode!),
                      cursorColor: Colors.black,
                      cursorHeight: 25,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(width: 1, color: Colors.grey)),
                        labelText: 'Description',
                        labelStyle: TextStyle(
                            color: _descriptionFocusNode!.hasFocus
                                ? Colors.black
                                : Colors.grey),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                width: 2, color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    TextFormField(
                        initialValue: individualProduct == null
                            ? product['price']
                            : individualProduct!.price.toString(),
                        focusNode: _priceFocusNode,
                        onTap: () => _requestFocus(_priceFocusNode!),
                        onSaved: (value) {
                          product['price'] = value!;
                        },
                        cursorColor: Colors.black,
                        cursorHeight: 25,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey)),
                          labelText: 'Price',
                          labelStyle: TextStyle(
                              color: _priceFocusNode!.hasFocus
                                  ? Colors.black
                                  : Colors.grey),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.black)),
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextFormField(
                              focusNode: _imageFocusNode,
                              onTap: () => _requestFocus(_imageFocusNode!),
                              onSaved: (value) {
                                product['imageUrl'] = value!;
                              },
                              controller: imageUrl,
                              cursorColor: Colors.black,
                              cursorHeight: 25,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.grey)),
                                labelText: 'ImageUrl',
                                labelStyle: TextStyle(
                                    color: _imageFocusNode!.hasFocus
                                        ? Colors.black
                                        : Colors.grey),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 2, color: Colors.black)),
                              )),
                        ),
                        const Spacer(),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.15,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          child: imageUrl!.text.isEmpty
                              ? const Text(
                                  'Enter the image url',
                                  style: TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.center,
                                )
                              : Image.network(
                                  imageUrl!.text,
                                  fit: BoxFit.contain,
                                ),
                        )
                      ],
                    ),
                    const SizedBox(height: 50),
                    Container(
                      alignment: Alignment.center,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.black),
                          child: const Text(
                            'Save',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            _saveForm();
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ))),
    );
  }
}
