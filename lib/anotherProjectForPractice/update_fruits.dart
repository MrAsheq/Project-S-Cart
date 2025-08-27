import 'package:flutter/material.dart';

class AddNewFruit extends StatefulWidget {
  const AddNewFruit({super.key});

  @override
  State<AddNewFruit> createState() => _AddNewFruitState();
}

class _AddNewFruitState extends State<AddNewFruit> {
  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _codeTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _priceTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Fruit Information")),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: _nameTEController,
                decoration: InputDecoration(
                  hintText: "Fruit's Name",
                  labelText: "Fruit",
                  fillColor: Colors.red,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  iconColor: Colors.purpleAccent,
                  icon: Icon(Icons.apple),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: _codeTEController,
                decoration: InputDecoration(
                  hintText: "Fruit Code",
                  labelText: "Code",
                  fillColor: Colors.red,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  iconColor: Colors.purpleAccent,
                  icon: Icon(Icons.qr_code_2),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                controller: _quantityTEController,
                decoration: InputDecoration(
                  hintText: "How many available?",
                  labelText: "Quantity",
                  fillColor: Colors.red,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  iconColor: Colors.purpleAccent,
                  icon: Icon(Icons.align_vertical_bottom_outlined),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                controller: _priceTEController,
                decoration: InputDecoration(
                  hintText: "Unit Price",
                  labelText: "Price",
                  fillColor: Colors.red,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  iconColor: Colors.purpleAccent,
                  icon: Icon(Icons.price_change_outlined),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _imageTEController,
                decoration: InputDecoration(
                  hintText: "Fruit Image URL",
                  labelText: "Image URL",
                  fillColor: Colors.red,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  iconColor: Colors.purpleAccent,
                  icon: Icon(Icons.linked_camera),
                ),
              ),
              SizedBox(height: 30,),
              FilledButton(onPressed: (){}, child: Text("UPDATE"))
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose(){
    super.dispose();
    _imageTEController.dispose();
    _priceTEController.dispose();
    _quantityTEController.dispose();
    _codeTEController.dispose();
    _nameTEController.dispose();
  }
}
