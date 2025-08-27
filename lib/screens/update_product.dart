import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project_with_rest_api/utility/urls.dart';
import 'package:project_with_rest_api/widgets/snackbar_widget.dart';

import '../models/product_model.dart';

class UpdateProduct extends StatefulWidget {
  const UpdateProduct({super.key, required this.product, required this.refreshProductList});

  final ProductModel product;
  final VoidCallback refreshProductList;

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {

  bool _updateProductInProgress = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _codeTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _priceTEController = TextEditingController();
  final TextEditingController _imageURLTEController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameTEController.text=widget.product.name;
    _codeTEController.text=widget.product.code.toString();
    _quantityTEController.text=widget.product.quantity.toString();
    _priceTEController.text=widget.product.unitPrice.toString();
    _imageURLTEController.text=widget.product.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product Update")),
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
                  validator: (String? value){
                    if(value?.trim().isEmpty ?? true){
                      return "Updated Product Name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _codeTEController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: "Product Code"),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return "Updated Product Code";
                      }
                      return null;
                    }
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _quantityTEController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: "Product Quantity"),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return "Updated Quantity";
                      }
                      return null;
                    }
                ),
                TextFormField(
                  controller: _priceTEController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: "Unit Price"),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return "Updated Unit Price";
                      }
                      return null;
                    }
                ),
                TextFormField(
                  controller: _imageURLTEController,
                  decoration: InputDecoration(labelText: "Image URL"),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return "Updated Image URL";
                      }
                      return null;
                    }
                ),
                SizedBox(height: 30),
                FilledButton(onPressed: _updateProduct, child: Text("Update")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateProduct()async{
    if(_formKey.currentState!.validate()== false){
      return; //call API to update
    }
    _updateProductInProgress = true;
    setState(() {});

    Uri uri = Uri.parse(Urls.updateProductUrl(widget.product.id));
    int totalPrice = int.parse(_quantityTEController.text) * int.parse(_priceTEController.text);
    Map<String, dynamic> requestBody = {
      "ProductName": _nameTEController.text.trim(),
      "ProductCode": int.parse(_codeTEController.text.trim()),
      "Img": _imageURLTEController.text.trim(),
      "Qty":int.parse( _quantityTEController.text.trim()),
      "UnitPrice": int.parse(_priceTEController.text.trim()),
      "TotalPrice": totalPrice,
    };
    Response response = await post(
      uri,
      headers: {"Content-Type": 'application/json'},
      body: jsonEncode(requestBody)
    );

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200){
      final decodedJson = jsonDecode(response.body);
      if(decodedJson['status'] == 'success'){
        _clearTextFields();
        showSnackBarMessage(context, "Product Updated Successfully");
      }else{
        String errorMessage = decodedJson['data'];
        showSnackBarMessage(context, errorMessage);
      }
    }
    _updateProductInProgress = false;
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
