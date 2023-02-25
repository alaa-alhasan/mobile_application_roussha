import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roussha_store/controllers/order_details_controller.dart';

import '../../app_properties.dart';

class OrderDetails extends StatelessWidget {

  final OrderDetailsController controller = Get.find();

  @override
  Widget build(BuildContext context) {

    controller.fetchOrderItems(controller.my_orders[controller.selected_order_index.value]["id"]);
    controller.fetchOrderTransaction(controller.my_orders[controller.selected_order_index.value]["id"]);
    if(controller.my_orders[controller.selected_order_index.value]["is_shipping_different"] == 1){
      controller.fetchOrderShipping(controller.my_orders[controller.selected_order_index.value]["id"]);
    }

    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: deepGrey),
          title: Text(
            'Order Details',
            style: const TextStyle(
                color: deepGrey, fontWeight: FontWeight.w500, fontSize: 18.0),
          ),
        ),
        body: LayoutBuilder(
            builder: (_, constraints) => SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx((){
                        if(controller.ORDERS_ITEMS_LOADING.value == true){
                          return Center(child: CircularProgressIndicator());
                        }else{
                          return Container(
                            height: controller.order_items.length == 1? 90 : controller.order_items.length == 2? 190 : 280,
                            child: Scrollbar(
                              child: ListView.builder(
                                itemCount: controller.order_items.length,
                                itemBuilder: (_, index) => Card(
                                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  child: ListTile(
                                      contentPadding: EdgeInsets.all(10),
                                      title: Text('${controller.order_items[index].product.name}(${controller.order_items[index].quantity})', style: TextStyle(fontWeight: FontWeight.bold),),
                                      subtitle: Text('${controller.order_items[index].option} \nprice: ${double.parse(controller.order_items[index].price)}  ,  subtotal: ${double.parse(controller.order_items[index].price) * controller.order_items[index].quantity}'),
                                      trailing: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(100),
                                          child: CachedNetworkImage(
                                              imageUrl: "${imagepath}products/${controller.order_items[index].product.image}",
                                              placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                                              fit: BoxFit.cover
                                          ),
                                        ),
                                      )
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      }),

                      Container(
                        margin: const EdgeInsets.all(16.0),
                        padding: const EdgeInsets.fromLTRB(
                            16.0, 0, 16.0, 16.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: shadow,
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              title: const Text('Subtotal'),
                              trailing: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: deepGrey,
                                    ),
                                    children: [
                                      TextSpan(
                                          text: '${double.parse(controller.my_orders[controller.selected_order_index.value]["subtotal"])}',
                                          style: TextStyle(
                                            fontSize: 16,
                                          )
                                      ),
                                      TextSpan(
                                          text: ' CHF',
                                          style: TextStyle(
                                            fontSize: 10,
                                          )
                                      ),
                                    ]),
                              ),
                            ),
                            ListTile(
                              title: const Text('Tax'),
                              trailing: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: deepGrey,
                                    ),
                                    children: [
                                      TextSpan(
                                          text: '${double.parse(controller.my_orders[controller.selected_order_index.value]["tax"])}',
                                          style: TextStyle(
                                            fontSize: 16,
                                          )
                                      ),
                                      TextSpan(
                                          text: ' CHF',
                                          style: TextStyle(
                                            fontSize: 10,
                                          )
                                      ),
                                    ]),
                              ),
                            ),
                            Divider(),
                            ListTile(
                              title: const Text(
                                'Total',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: deepGrey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                          text: '${double.parse(controller.my_orders[controller.selected_order_index.value]["total"])}',
                                          style: TextStyle(
                                            fontSize: 20,
                                          )
                                      ),
                                      TextSpan(
                                          text: ' CHF',
                                          style: TextStyle(
                                            fontSize: 15,
                                          )
                                      ),
                                    ]),
                              ),
                            )
                          ],
                        ),
                      ),

                      Card(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.all(10),
                              title: Text('Billing Details'),
                              subtitle: Text('Information of the ordering user'),
                              trailing: Icon(Icons.info),
                              onTap: (){
                                controller.HIDE_SHOW_BILLING_DETAILS.isFalse? controller.HIDE_SHOW_BILLING_DETAILS(true) : controller.HIDE_SHOW_BILLING_DETAILS(false);
                              },
                            ),
                            Obx((){
                              return controller.HIDE_SHOW_BILLING_DETAILS.isTrue?
                              Column(
                                children: [
                                  Container(
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.arrow_right),
                                        Text('Name: ', style: TextStyle(fontSize: 14),),
                                        Text('${controller.my_orders[controller.selected_order_index.value]["firstname"]} ${controller.my_orders[controller.selected_order_index.value]["lastname"]}', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.arrow_right),
                                        Text('Email: ', style: TextStyle(fontSize: 14),),
                                        Text('${controller.my_orders[controller.selected_order_index.value]["email"]}', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.arrow_right),
                                        Text('Phone: ', style: TextStyle(fontSize: 14),),
                                        Text('${controller.my_orders[controller.selected_order_index.value]["mobile"]}', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.arrow_right),
                                        Text('Line 1: ', style: TextStyle(fontSize: 14),),
                                        Text('${controller.my_orders[controller.selected_order_index.value]["line1"]}', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.arrow_right),
                                        Text('Line 2: ', style: TextStyle(fontSize: 14),),
                                        Text('${controller.my_orders[controller.selected_order_index.value]["line2"]}', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.arrow_right),
                                        Text('City: ', style: TextStyle(fontSize: 14),),
                                        Text('${controller.my_orders[controller.selected_order_index.value]["city"]}', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.arrow_right),
                                        Text('Province: ', style: TextStyle(fontSize: 14),),
                                        Text('${controller.my_orders[controller.selected_order_index.value]["province"]}', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.arrow_right),
                                        Text('Country: ', style: TextStyle(fontSize: 14),),
                                        Text('${controller.my_orders[controller.selected_order_index.value]["country"]}', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.arrow_right),
                                        Text('Zipcode: ', style: TextStyle(fontSize: 14),),
                                        Text('${controller.my_orders[controller.selected_order_index.value]["zipcode"]}', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ),
                                ],
                              )
                                  :
                              Container();
                            })
                          ],
                        ),
                      ),

                      controller.my_orders[controller.selected_order_index.value]["is_shipping_different"] == 1?
                      Card(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.all(10),
                              title: Text('Shipping Details'),
                              subtitle: Text('Information of the receiving user'),
                              trailing: Icon(Icons.info),
                              onTap: (){
                                controller.HIDE_SHOW_SHIPPING_DETAILS.isFalse? controller.HIDE_SHOW_SHIPPING_DETAILS(true) : controller.HIDE_SHOW_SHIPPING_DETAILS(false);
                              },
                            ),
                            Obx((){
                              if(controller.ORDERS_SHIPPING_LOADING.value == true){
                                return CircularProgressIndicator();
                              }else{
                                return controller.HIDE_SHOW_SHIPPING_DETAILS.isTrue?
                                Column(
                                  children: [
                                    Container(
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.arrow_right),
                                          Text('Name: ', style: TextStyle(fontSize: 14),),
                                          Text('${controller.orderShipping['firstname']} ${controller.orderShipping['lastname']}', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.arrow_right),
                                          Text('Email: ', style: TextStyle(fontSize: 14),),
                                          Text('${controller.orderShipping['email']}', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.arrow_right),
                                          Text('Phone: ', style: TextStyle(fontSize: 14),),
                                          Text('${controller.orderShipping['mobile']}', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.arrow_right),
                                          Text('Line 1: ', style: TextStyle(fontSize: 14),),
                                          Text('${controller.orderShipping['line1']}', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.arrow_right),
                                          Text('Line 2: ', style: TextStyle(fontSize: 14),),
                                          Text('${controller.orderShipping['line2']}', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.arrow_right),
                                          Text('City: ', style: TextStyle(fontSize: 14),),
                                          Text('${controller.orderShipping['city']}', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.arrow_right),
                                          Text('Province: ', style: TextStyle(fontSize: 14),),
                                          Text('${controller.orderShipping['province']}', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.arrow_right),
                                          Text('Country: ', style: TextStyle(fontSize: 14),),
                                          Text('${controller.orderShipping['country']}', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.arrow_right),
                                          Text('Zipcode: ', style: TextStyle(fontSize: 14),),
                                          Text('${controller.orderShipping['zipcode']}', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                                    :
                                    Container();
                              }
                            })
                          ],
                        ),
                      )
                      :
                      SizedBox(),

                      Card(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Column(
                          children: [
                            ListTile(
                                contentPadding: EdgeInsets.all(10),
                                title: Text('Transaction'),
                                subtitle: Text('The order status'),
                                trailing: Icon(Icons.local_shipping),
                                onTap: (){
                                  controller.HIDE_SHOW_TRANSACTION_DETAILS.isFalse? controller.HIDE_SHOW_TRANSACTION_DETAILS(true) : controller.HIDE_SHOW_TRANSACTION_DETAILS(false);
                                },
                            ),
                            Obx((){
                              if(controller.ORDERS_TRANSACTION_LOADING.value == true){
                                return CircularProgressIndicator();
                              }else{
                                return controller.HIDE_SHOW_TRANSACTION_DETAILS.isTrue?
                                Column(
                                  children: [
                                    Container(
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.arrow_right),
                                          Text('Transaction Mode: ', style: TextStyle(fontSize: 14),),
                                          Text('${controller.orderTransaction['mode']}', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.arrow_right),
                                          Text('Status: ', style: TextStyle(fontSize: 14),),
                                          Text('${controller.orderTransaction['status']}', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.arrow_right),
                                          Text('Transaction Date: ', style: TextStyle(fontSize: 14),),
                                          Text('${controller.orderTransaction['created_at'].substring(0, 10)}', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                                    :
                                    Container();
                              }
                            })
                          ],
                        ),
                      )
                    ],
                  )
              ),
            )
        )
    );
  }
}
