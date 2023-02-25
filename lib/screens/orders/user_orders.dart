import 'package:lottie/lottie.dart';
import 'package:roussha_store/controllers/order_details_controller.dart';
import 'package:get/get.dart';
import 'package:roussha_store/screens/orders/user_order_details.dart';
import '../../app_properties.dart';
import 'package:flutter/material.dart';

class MyOrders extends StatelessWidget {

  final OrderDetailsController controller = Get.put(OrderDetailsController());

  @override
  Widget build(BuildContext context) {

    Widget status(String s){

      if(s == 'ordered'){
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.check_circle,
              size: 14,
              color: Colors.blue[700],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('Ordered',style: TextStyle(color: Colors.blue[700])),
            ),
          ],
        );
      }
      if(s == 'delivered'){
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.done,
              size: 14,
              color: darkGrey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('Ordered',style: TextStyle(color: darkGrey)),
            ),
          ],
        );
      }
      if(s == 'canceled'){
        return Row(
          children: <Widget>[
            Icon(
              Icons.cancel,
              size: 14,
              color: Color(0xffF94D4D),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0),
              child: Text('Canceled',
                  style: TextStyle(
                      color: Color(0xffF94D4D))),
            )
          ],
        );
      }

      return SizedBox();
    }

    return Material(
      color: Colors.grey[100],
      child: SafeArea(
        child: Container(
            margin: const EdgeInsets.only(top: kToolbarHeight),
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'My Orders',
                    style: TextStyle(
                      color: darkGrey,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CloseButton()
                ],
              ),
              Flexible(
                child: Obx((){
                  if(controller.INTERNET_CONNECTION.isTrue){
                    if(controller.ORDERS_LOADING.value){
                      return Center(
                          child: CircularProgressIndicator()
                      );
                    }else{
                      if(controller.my_orders.length > 0){
                        return ListView.builder(
                          itemCount: controller.my_orders.length,
                          itemBuilder: (_, index) => Container(
                            padding: const EdgeInsets.all(16.0),
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(5.0))),
                            child: InkWell(
                              onTap: (){
                                controller.selected_order_index(index);
                                Get.to(() => OrderDetails());
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Destination: ',
                                          ),
                                          TextSpan(
                                              text: '${controller.my_orders[index]["firstname"]} ${controller.my_orders[index]["lastname"]}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              )
                                          ),
                                        ]),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Total amount: ',
                                          ),
                                          TextSpan(
                                              text: controller.my_orders[index]['total'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              )
                                          ),
                                          TextSpan(
                                              text: ' CHF',
                                              style: TextStyle(
                                                fontSize: 8,
                                              )
                                          ),
                                        ]),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Discount: ',
                                          ),
                                          TextSpan(
                                              text: controller.my_orders[index]['discount'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              )
                                          ),
                                          TextSpan(
                                              text: ' CHF',
                                              style: TextStyle(
                                                fontSize: 8,
                                              )
                                          ),
                                        ]),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Tax: ',
                                          ),
                                          TextSpan(
                                              text: controller.my_orders[index]['tax'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              )
                                          ),
                                          TextSpan(
                                              text: ' CHF',
                                              style: TextStyle(
                                                fontSize: 8,
                                              )
                                          ),
                                        ]),
                                  ),
                                  status(controller.my_orders[index]['status'])
                                ],
                              ),
                            ),
                          ),
                        );
                      }else {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset('assets/empty_box.json', width: 200, height: 200),
                              Text('No Orders! Go to shopping page\nmake your own order')
                            ],
                          ),
                        );
                      }
                    }
                  }else{
                    return Center(child: Lottie.asset('assets/offline.json',height: 100, width: 100));
                  }
                }),
              )
            ])),
      ),
    );
  }
}
