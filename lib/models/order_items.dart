import 'package:roussha_store/models/product.dart';

class OrderItems {

  String price;
  int quantity;
  Product product;
  String option;

  OrderItems({required this.price, required this.quantity, required this.product, required this.option});
}