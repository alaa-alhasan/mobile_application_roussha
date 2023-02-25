import 'package:roussha_store/models/product.dart';
import 'package:flutter/material.dart';

class Cart{

  String rowId;
  Product product;
  int qty;
  Color? color;
  String? size;

  Cart({
      required this.rowId,
      required this.product,
      required this.qty,
      this.color,
      this.size
  });
}