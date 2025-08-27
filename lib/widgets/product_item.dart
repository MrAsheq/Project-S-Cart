import 'package:flutter/material.dart';
import '../screens/update_product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(),
      title: Text("Product Name"),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("CODE: ........."),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Quantity: ......Piece"),
              Text("Unit Price: .....BDT"),
            ],
          ),
        ],
      ),
      trailing: PopupMenuButton<ProductOptions>(
        itemBuilder: (context) {
          return [
            PopupMenuItem(value: ProductOptions.update, child: Text("Update")),
            PopupMenuItem(value: ProductOptions.delete, child: Text("Delete")),
          ];
        },
        onSelected: (ProductOptions selectedOption) {
          if (selectedOption == ProductOptions.delete) {
            print("Deleted");
          } else if (selectedOption == ProductOptions.update) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UpdateProduct()),
            );
          }
        },
      ),
    );
  }
}

enum ProductOptions { update, delete }
