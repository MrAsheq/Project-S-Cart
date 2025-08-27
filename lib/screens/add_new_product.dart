import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../widgets/snackbar_widget.dart';

class AddNewProduct extends StatefulWidget {
  const AddNewProduct({super.key});

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  //tuning formation
  bool _addProductInProgress = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _codeTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _priceTEController = TextEditingController();
  final TextEditingController _imageURLTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add New Product")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 8,
              children: [
                TextFormField(
                  controller: _nameTEController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: "Product Name"),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your value';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _codeTEController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: "Product Code"),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your value';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _quantityTEController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: "Product Quantity"),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your value';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _priceTEController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: "Unit Price"),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your value';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _imageURLTEController,
                  decoration: InputDecoration(labelText: "Image URL"),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your value';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                Visibility(
                  visible: _addProductInProgress == false,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: FilledButton(
                    onPressed: _onTapAddProduct,
                    child: Text("Add Product"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapAddProduct() async {
    // logic build
    if (_formKey.currentState!.validate() == false) {
      return;
    }

    // progresss
    _addProductInProgress = true;
    setState(() {});

    // URI - creation for Request
    Uri uri = Uri.parse("http://35.73.30.144:2008/api/v1/CreateProduct");

    // Prepare Data
    int totalPrice =
        int.parse(_quantityTEController.text) *
        int.parse(_priceTEController.text);

    Map<String, dynamic> requestBody = {
      "ProductName": _nameTEController.text.trim(),
      "ProductCode": int.parse(_codeTEController.text.trim()),
      "Img": _imageURLTEController.text.trim(),
      "Qty":int.parse( _quantityTEController.text.trim()),
      "UnitPrice": int.parse(_priceTEController.text.trim()),
      "TotalPrice": totalPrice,
    };
    // Request with DATA
    Response response = await post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final decodedJson = jsonDecode(response.body);
      if (decodedJson['status'] == 'success') {
        _clearTextFields();
        showSnackBarMessage(context, "Product Created Successfully");
      } else {
        String errorMessage = decodedJson['data'];
        showSnackBarMessage(context, errorMessage);
      }
    }
    _addProductInProgress = false;
    setState(() {});
  }

  void _clearTextFields() {
    _nameTEController.clear();
    _codeTEController.clear();
    _quantityTEController.clear();
    _priceTEController.clear();
    _imageURLTEController.clear();
  }

  @override
  void dispose() {
    _nameTEController.dispose();
    _codeTEController.dispose();
    _quantityTEController.dispose();
    _priceTEController.dispose();
    _imageURLTEController.dispose();
    super.dispose();
  }
}
