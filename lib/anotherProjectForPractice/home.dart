import 'package:flutter/material.dart';
import 'package:project_with_rest_api/anotherProjectForPractice/add_new_fruit.dart';
import 'fruit_item_widget.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Project - Rest API",
          style: TextStyle(
            color: Colors.purple,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return FruitItemWidget();
        },
        separatorBuilder: (context, index) {
          return Divider(indent: 70);
        },
        itemCount: 5,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNewFruit()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
