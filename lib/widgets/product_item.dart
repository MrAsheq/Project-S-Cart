import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project_with_rest_api/models/product_model.dart';
import '../screens/update_product.dart';
import '../utility/urls.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({
    super.key,
    required this.product,
    required this.refreshProductList,
  });

  // final ProductItem({super.key, required this.product});

  final ProductModel product;
  final VoidCallback refreshProductList;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool _deleteInProgress = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        width: 40,
        widget.product.image,
        errorBuilder: (_, __, ___) {
          return Icon(Icons.error_outline, size: 40);
        },
      ),
      title: Text(widget.product.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("CODE: ${widget.product.code}"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Quantity: ${widget.product.quantity}"),
              Text("Unit Price: ${widget.product.unitPrice}"),
            ],
          ),
        ],
      ),
      trailing: Visibility(
        visible: _deleteInProgress == false,
        replacement: CircularProgressIndicator(),
        child: PopupMenuButton<ProductOptions>(
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: ProductOptions.update,
                child: Text("Update"),
              ),
              PopupMenuItem(
                value: ProductOptions.delete,
                child: Text("Delete"),
              ),
            ];
          },
          onSelected: (ProductOptions selectedOption) {
            if (selectedOption == ProductOptions.delete) {
              _deleteProduct();
            } else if (selectedOption == ProductOptions.update) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpdateProduct(
                  product: widget.product,
                  refreshProductList: widget.refreshProductList ,
                )),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _deleteProduct() async {
    _deleteInProgress = true;
    setState(() {});
    Uri uri = Uri.parse(Urls.deleteProductUrl(widget.product.id));
    Response response = await get(uri); //for future response
    debugPrint(response.statusCode.toString());

    // debugPrint > only on developer mode,
    // while release mode not going to work
    debugPrint(response.body);

    if (response.statusCode == 200) {
      widget.refreshProductList();
    }
    _deleteInProgress = false;
    setState(() {});
  }
}

enum ProductOptions { update, delete }
