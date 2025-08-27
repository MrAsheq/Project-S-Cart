/// REST API formate
// {
// "_id": "68af0478dd287e3f18a266f1",
// "ProductName": "Blanket",
// "ProductCode": 1456789001,
// "Img": "aladin.com",
// "Qty": 45,
// "UnitPrice": 652,
// "TotalPrice": 29340
// }

class ProductModel{
  late String id; // late is risky
  late String name;
  late int code;
  late String image;
  late int quantity;
  late int unitPrice;
  late int totalPrice;

  /// model class
  // type casting
  // data parsing
  ProductModel.fromJson(Map<String, dynamic> productJson){
    id = productJson['_id'];
    name = productJson['ProductName'];
    code = productJson['ProductCode'];
    image = productJson['Img'];
    quantity = productJson['Qty'];
    unitPrice = productJson['UnitPrice'];
    totalPrice = productJson['TotalPrice'];

  }

}
