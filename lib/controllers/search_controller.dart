import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:roussha_store/models/product.dart';
import 'package:roussha_store/services/api.dart';

class SearchController extends GetxController {

  late List<Product> products = [];
  late TextEditingController textEditController;

  textUpdate(String value) async {
    products.clear();
    await ApiData.search(value).then((value) => {
      if(value.isNotEmpty){
        products.addAll(value)
      }
    });
    update();
  }

  clearList(){
    products.clear();
    update();
  }

  @override
  void onInit() {
    textEditController = TextEditingController();
    super.onInit();
  }
}