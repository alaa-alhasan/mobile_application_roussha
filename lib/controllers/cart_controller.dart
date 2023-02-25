import 'package:get/get.dart';
import 'package:roussha_store/functions/check_internet.dart';
import 'package:roussha_store/functions/store_auth_info.dart';
import 'package:roussha_store/models/cart.dart';
import 'package:roussha_store/models/product.dart';
import 'package:roussha_store/services/api.dart';
import 'package:flutter/material.dart';

class CartController extends GetxController {

  RxBool INTERNET_CONNECTION = false.obs;

  late List<Cart> my_cart = <Cart>[].obs;
  RxInt count = 0.obs;
  RxBool CART_LOADING = false.obs;

  RxBool REMOVE_ITEM_CART_LOADING = false.obs;

  late List<String> cart_summary = <String>[].obs;
  RxBool SUMMARY_CART_LOADING = false.obs;


  RxInt saleState = 0.obs;


  fetchMyCart() async {
    my_cart.clear();
    count(0);
    CART_LOADING(true);
    String? token = await getToken();
    await ApiData.myCart(token!).then((value) => {
      if(value.isNotEmpty){
        combinCart(value)
      }
    });
    cartSummary();
    CART_LOADING(false);
  }

  combinCart(var value) async {
    for(var v in value){

      String rowId = v['rowId'];
      Product product = await productById(v['id']);
      int qty = v['qty'];
      Color? color;
      String? size;

      if(v['options'].length > 0 ){
        if(v['options']['Size'] != null){
          size = v['options']['Size'];
        }
        if(v['options']['Color'] != null){
          switch(v['options']['Color']) {

            case "red": { color = Colors.red; } break;
            case "green": { color = Colors.green; } break;
            case "blue": { color = Colors.blue; } break;
            case "black": { color = Colors.black; } break;
            case "brown": { color = Colors.brown; } break;
            case "pink": { color = Colors.pink; } break;
            case "gold": { color = Colors.amber; } break;
            case "purple": { color = Colors.purple; } break;
            case "white": { color = Colors.white; } break;
            case "orange": { color = Colors.orange; } break;

            default: {
            }
            break;
          }
        }
      }

      count += qty;

      my_cart.add(Cart(rowId: rowId, product: product,qty: qty, color: color, size: size));
    }
  }

  Future<Product> productById(int id) async {
    late Product p;
    await ApiData.productById(id).then((value) => {
      p = value
    });
    return p;
  }

  removeItemCart(String rowId) async {

    REMOVE_ITEM_CART_LOADING(true);

    String? token = await getToken();
    await ApiData.removeItemCart(token!, rowId).then((value) => {
      if(value == 1){
        REMOVE_ITEM_CART_LOADING(false),
        fetchMyCart(),
        cartSummary()
      }
    });

    REMOVE_ITEM_CART_LOADING(false);
  }


  clearCart() async {

    REMOVE_ITEM_CART_LOADING(true);

    String? token = await getToken();

    await ApiData.clearCart(token!).then((value) => {
      if(value == 1){
        REMOVE_ITEM_CART_LOADING(false),
        fetchMyCart()
      }
    });

    REMOVE_ITEM_CART_LOADING(false);

  }

  cartSummary() async {
    SUMMARY_CART_LOADING(true);
    cart_summary.clear();
    String? token = await getToken();

    await ApiData.cartSummary(token!).then((value) => {
      if(value.isNotEmpty){
        cart_summary.addAll(value),
        SUMMARY_CART_LOADING(false)
      }
    });
    SUMMARY_CART_LOADING(false);
  }

  increaseItemCartQuantity(String rowId) async {
    REMOVE_ITEM_CART_LOADING(true);

    String? token = await getToken();
    await ApiData.increaseItemCartQuantity(token!, rowId).then((value) => {
      if(value == 1){
        REMOVE_ITEM_CART_LOADING(false),
        fetchMyCart(),
        cartSummary()
      }
    });

    REMOVE_ITEM_CART_LOADING(false);
  }

  decreaseItemCartQuantity(String rowId) async {
    REMOVE_ITEM_CART_LOADING(true);

    String? token = await getToken();
    await ApiData.decreaseItemCartQuantity(token!, rowId).then((value) => {
      if(value == 1){
        REMOVE_ITEM_CART_LOADING(false),
        fetchMyCart(),
        cartSummary()
      }
    });

    REMOVE_ITEM_CART_LOADING(false);
  }


  initController() async {
    fetchMyCart();
  }

  @override
  void onInit() async {

    await CheckInternet().then((value) => {
      INTERNET_CONNECTION(value)
    });


    await ApiData.onSale().then((value) => {
      saleState(value)
    });

    super.onInit();
  }

}