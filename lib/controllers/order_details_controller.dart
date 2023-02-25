
import 'package:get/get.dart';
import 'package:roussha_store/functions/check_internet.dart';
import 'package:roussha_store/functions/store_auth_info.dart';
import 'package:roussha_store/models/order_items.dart';
import 'package:roussha_store/services/api.dart';

class OrderDetailsController extends GetxController {

  RxBool INTERNET_CONNECTION = false.obs;

  late List<dynamic> my_orders = <dynamic>[].obs;
  RxBool ORDERS_LOADING = false.obs;

  RxInt selected_order_index = 0.obs;

  late List<OrderItems> order_items = <OrderItems>[].obs;
  RxBool ORDERS_ITEMS_LOADING = false.obs;

  late dynamic orderShipping;
  RxBool ORDERS_SHIPPING_LOADING = false.obs;

  late dynamic orderTransaction;
  RxBool ORDERS_TRANSACTION_LOADING = false.obs;

  RxBool HIDE_SHOW_BILLING_DETAILS = false.obs;
  RxBool HIDE_SHOW_SHIPPING_DETAILS = false.obs;
  RxBool HIDE_SHOW_TRANSACTION_DETAILS = false.obs;

  fetchMyOrders() async {
    my_orders.clear();
    ORDERS_LOADING(true);
    String? token = await getToken();
    await ApiData.myOrders(token!).then((value) => {
      if(value.isNotEmpty){
        my_orders.addAll(value)
      }
    });
    ORDERS_LOADING(false);
  }

  fetchOrderItems(int order_id) async{
    order_items.clear();
    ORDERS_ITEMS_LOADING(true);
    String? token = await getToken();
    await ApiData.orderItems(token!, order_id).then((value) => {
      if(value.isNotEmpty){
        order_items.addAll(value),
        ORDERS_ITEMS_LOADING(false)
      }
    });
    ORDERS_ITEMS_LOADING(false);
  }

  fetchOrderShipping(int order_id) async{
    orderShipping = null;
    ORDERS_SHIPPING_LOADING(true);
    String? token = await getToken();
    await ApiData.orderShipping(token!, order_id).then((value) => {
      if(value.isNotEmpty){
        orderShipping = value,
        ORDERS_SHIPPING_LOADING(false)
      }
    });
    ORDERS_SHIPPING_LOADING(false);
  }

  fetchOrderTransaction(int order_id) async{
    orderTransaction = null;
    ORDERS_TRANSACTION_LOADING(true);
    String? token = await getToken();
    await ApiData.orderTransaction(token!, order_id).then((value) => {
      if(value.isNotEmpty){
        orderTransaction = value,
        ORDERS_TRANSACTION_LOADING(false)
      }
    });
    ORDERS_TRANSACTION_LOADING(false);
  }

  @override
  void onInit() async {

    await CheckInternet().then((value) => {
      INTERNET_CONNECTION(value)
    });

    fetchMyOrders();

    super.onInit();
  }

}