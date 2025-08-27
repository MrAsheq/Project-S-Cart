class Urls {
  static const String _baseUrl = "http://35.73.30.144:2008/api/v1";
  static const String getProductUrl = "$_baseUrl/ReadProduct";
  static String deleteProductUrl(String id) => "$_baseUrl/DeleteProduct/$id";
  static String updateProductUrl(String id) => "$_baseUrl/UpdateProduct/$id";
  // static String deleteProductUrl(String id){
  //   return "$_baseUrl/DeleteProduct/$id";
  // } same as =>

}