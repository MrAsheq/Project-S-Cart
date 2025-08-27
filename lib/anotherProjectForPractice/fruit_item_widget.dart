
import 'package:flutter/material.dart';
import 'package:project_with_rest_api/widgets/product_item.dart';

class FruitItemWidget extends StatelessWidget {
  const FruitItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(),
      title: Text("Fruit Name"),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Code: 0001"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Quantity: 12"), Text("Unit Price: 135")],
          ),
        ],
      ),
      trailing: PopupMenuButton<FruitOptions>(
        itemBuilder: (context) {
          return [
            PopupMenuItem(value: FruitOptions.update, child: Text("Update")),
            PopupMenuItem(value: FruitOptions.delete,child: Text("Delete")),
          ];
        },
        onSelected: (FruitOptions selectedOption){
          if(selectedOption == FruitOptions.update){
            print("Updated Successfully");
          }else if(selectedOption == FruitOptions.delete){
            print("Deleted Successfully");
          }
        },
      ),
    );
  }
}
enum FruitOptions{update, delete}