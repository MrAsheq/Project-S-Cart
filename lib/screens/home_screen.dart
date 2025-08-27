import 'package:flutter/material.dart';
import '../widgets/product_item.dart';
import 'add_new_product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Project- UNKNOW")),
      body: ListView.separated(
        itemCount: 2,
        itemBuilder: (context, index) {
          return ProductItem();
        },
        separatorBuilder: (context, index) {
          return Divider(indent: 70);
        },
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