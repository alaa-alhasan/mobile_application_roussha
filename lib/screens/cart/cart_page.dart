import 'package:lottie/lottie.dart';
import 'package:roussha_store/app_properties.dart';
import 'package:roussha_store/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:roussha_store/screens/checkout/check_out_page.dart';
import 'package:get/get.dart';
import 'components/cart_item_list.dart';

class CartPage extends StatefulWidget {

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartController controller = Get.put(CartController());

  @override
  void initState() {
    controller.initController();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Widget checkOutButton = InkWell(
      onTap: () {
        Get.to(() => CheckOutPage());
      },
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width / 1.5,
        decoration: BoxDecoration(
            gradient: mainButton,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0)),
        child: Center(
          child: Text("Check Out",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );

    return RefreshIndicator(
        displacement: 0,
        backgroundColor: Colors.grey,
        color: deepGrey,
        strokeWidth: 2,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: () async {
          controller.fetchMyCart();
        },
        child: Scaffold(
          //backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              iconTheme: IconThemeData(color: deepGrey),
              actions: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Obx(() {
                      if(controller.REMOVE_ITEM_CART_LOADING.value){
                        return CircularProgressIndicator();
                      }else {
                        return SizedBox();
                      }
                    }),
                  ),
                ),
                Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20,top: 0,bottom: 5),
                      child: Obx(() {
                        if(controller.my_cart.length > 0){
                          return DragTargetWidget();
                        }else {
                          return RawMaterialButton(onPressed: (){
                            controller.fetchMyCart();
                          },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: const Icon(Icons.refresh_outlined),
                              )
                          );
                        }
                      }),
                    ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Obx(() {
                      return Text(
                        '${controller.count.value} items',
                        style: TextStyle(
                            color: deepGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      );
                    }),
                  ),
                ),
              ],
              title: Text(
                'Cart',
                style: TextStyle(
                    color: deepGrey, fontWeight: FontWeight.w500, fontSize: 18.0),
              ),
            ),
            body: Obx(() {
              if(controller.INTERNET_CONNECTION.isTrue){
                if(controller.CART_LOADING.value){
                  return Center(child: CircularProgressIndicator());
                }else{
                  if(controller.my_cart.length > 0){
                    return LayoutBuilder(
                      builder: (_, constraints) => SingleChildScrollView(
                        physics: ClampingScrollPhysics(),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minHeight: constraints.maxHeight),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: controller.my_cart.length == 1? 120 : controller.my_cart.length == 2? 240 : 360,
                                child: Scrollbar(
                                  child: ListView.builder(
                                    itemCount: controller.my_cart.length,
                                    itemBuilder: (_, index) => CartItemList(
                                      controller.my_cart[index]
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(16.0),
                                padding: const EdgeInsets.fromLTRB(
                                    16.0, 0, 16.0, 16.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: shadow,
                                    borderRadius: BorderRadius.all(Radius.circular(10))),
                                child: Obx((){
                                  if(controller.SUMMARY_CART_LOADING.value){
                                    return Center(child: CircularProgressIndicator(),);
                                  }else{
                                    return Column(
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
                                                      text: '${double.parse(controller.cart_summary[0])}',
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
                                                      text: '${double.parse(controller.cart_summary[1])}',
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
                                                      text: '${double.parse(controller.cart_summary[2])}',
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
                                    );
                                  }
                                }),
                              ),
                              SizedBox(height: 24),
                              Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context).padding.bottom == 0
                                            ? 20
                                            : MediaQuery.of(context).padding.bottom),
                                    child: checkOutButton,
                                  ))
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
                          Text('You Cart Is Empty!')
                        ],
                      ),
                    );
                  }
                }
              }else{
                return Center(child: Lottie.asset('assets/offline.json',height: 100, width: 100));
              }
            })
        )
    );
  }
}
