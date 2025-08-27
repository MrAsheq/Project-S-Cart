import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project_with_rest_api/models/product_model.dart';
import 'package:project_with_rest_api/utility/urls.dart';
import '../widgets/product_item.dart';
import 'add_new_product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //from product page
  final List<ProductModel> _productList = [];
  bool _getProductInProgress = false;

  @override
  void initState() {
    super.initState();
    _getProductList();
  }

  Future<void> _getProductList() async {
    _productList.clear();
    _getProductInProgress = true;
    setState(() {});
    Uri uri = Uri.parse(Urls.getProductUrl);
    Response response = await get(uri); //for future response
    debugPrint(response.statusCode.toString());

    // debugPrint > only on developer mode,
    // while release mode not going to work
    debugPrint(response.body);

    if (response.statusCode == 200) {
      final decodedJson = jsonDecode(response.body);
      for (Map<String, dynamic> productJson in decodedJson['data']) {
        ProductModel productModel = ProductModel.fromJson(productJson);
        _productList.add(productModel);
      }
    }
    _getProductInProgress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project S-Cart"),
        actions: [
          IconButton(
            onPressed: () {
              _getProductList();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Visibility(
        visible: _getProductInProgress == false,
        replacement: Center(child: CircularProgressIndicator()),
        child: ListView.separated(
          itemCount: _productList.length,
          itemBuilder: (context, index) {
            return ProductItem(
              product: _productList[index],
              refreshProductList: () {
                _getProductList();
              },
            );
          },
          separatorBuilder: (context, index) {
            return Divider(indent: 70);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNewProduct()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
