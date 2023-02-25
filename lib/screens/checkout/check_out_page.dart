import 'dart:io';

import 'package:flutter/services.dart';
import 'package:roussha_store/controllers/cart_controller.dart';
import 'package:roussha_store/controllers/checkout_controller.dart';
import 'package:roussha_store/functions/check_internet.dart';
import 'package:roussha_store/functions/input_validation.dart';
import 'package:roussha_store/screens/main/main_page.dart';

import '../../app_properties.dart';
import 'package:flutter/material.dart';
import '../../custom_background.dart';
import 'package:get/get.dart';

class CheckOutPage extends StatelessWidget {

  final CheckoutController controller = Get.put(CheckoutController());


  @override
  Widget build(BuildContext context) {

    InputDecoration setDecoration(String label){
      return InputDecoration(
        labelText: label,
        contentPadding: EdgeInsets.fromLTRB(10, 2, 0, 2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      );
    }

    Widget placeOrderButton = InkWell(
      onTap:() async {

        await CheckInternet().then((value) => {
          if(value == true){

            controller.placeOrder().then((value) => {
              if(controller.place_order_result_code.value == -1){
                Get.snackbar('Roussha', controller.place_order_result_message.value,
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    icon: Icon(Icons.error_outline)
                )
              },
              if(controller.place_order_result_code.value == 1){
                Get.snackbar('Roussha', controller.place_order_result_message.value,
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    icon: Icon(Icons.check)
                ),
                Get.to(() => MainPage())
              }
            })

          }else{

            Get.snackbar('Roussha', 'Sorry, You are offline!!',
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                icon: Icon(Icons.wifi_off_outlined)
            )

          }
        });
      },
      child: Container(
        height: 80,
        margin: EdgeInsets.only(top: 25),
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
            child: Obx((){
              if(controller.SENDING.value){
                return CircularProgressIndicator();
              }else{
                return Text("Place Order",
                    style: const TextStyle(
                        color: const Color(0xfffefefe),
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        fontSize: 20.0)
                );
              }
            })
        ),
      ),
    );

    return CustomPaint(
      painter: MainBackground(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: darkGrey),
          title: Text(
            'Check Out',
            style: const TextStyle(
                color: darkGrey,
                fontWeight: FontWeight.w500,
                fontFamily: "Montserrat",
                fontSize: 18.0),
          ),
        ),
        body: LayoutBuilder(
          builder: (_, viewportConstraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
              BoxConstraints(minHeight: viewportConstraints.maxHeight),
              child: Container(
                padding: EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    bottom: MediaQuery.of(context).padding.bottom == 0
                        ? 20
                        : MediaQuery.of(context).padding.bottom),
                child: Column(
                  children: [
                    Form(
                      key: controller.checkout_form_state,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                              alignment: const Alignment(-1,0),
                              child: Container(
                                width: 200,
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                  keyboardType: TextInputType.name,
                                  controller: controller.firstname,
                                  validator: (value) {
                                    return validateInput(value!, 2, 20, "");
                                  },
                                  decoration: setDecoration('first name'),
                                ),
                              )
                          ),
                          Container(
                              alignment: const Alignment(-1,0),
                              child: Container(
                                width: 200,
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                  keyboardType: TextInputType.name,
                                  controller: controller.lastname,
                                  validator: (value) {
                                    return validateInput(value!, 2, 20, "");
                                  },
                                  decoration: setDecoration('last name'),
                                ),
                              )
                          ),
                          Container(
                              alignment: const Alignment(-1,0),
                              child: Container(
                                width: 200,
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: controller.email,
                                  validator: (value) {
                                    return validateInput(value!, 2, 30, "email");
                                  },
                                  decoration: setDecoration('email'),
                                ),
                              )
                          ),
                          Container(
                              alignment: const Alignment(-1,0),
                              child: Container(
                                width: 200,
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  controller: controller.phone,
                                  validator: (value) {
                                    return validateInput(value!, 8, 15, "phone");
                                  },
                                  decoration: setDecoration('phone'),
                                ),
                              )
                          ),
                          Container(
                              alignment: const Alignment(-1,0),
                              child: Container(
                                width: 200,
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: controller.line1,
                                  validator: (value) {
                                    return validateInput(value!, 5, 30, "");
                                  },
                                  decoration: setDecoration('line 1'),
                                ),
                              )
                          ),
                          Container(
                              alignment: const Alignment(-1,0),
                              child: Container(
                                width: 200,
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: controller.line2,
                                  validator: (value) {
                                    return validateInput(value!, 5, 30, "");
                                  },
                                  decoration: setDecoration('line 2'),
                                ),
                              )
                          ),
                          Container(
                              alignment: const Alignment(-1,0),
                              child: Container(
                                width: 200,
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: controller.country,
                                  validator: (value) {
                                    return validateInput(value!, 2, 30, "");
                                  },
                                  decoration: setDecoration('country'),
                                ),
                              )
                          ),
                          Container(
                              alignment: const Alignment(-1,0),
                              child: Container(
                                width: 200,
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: controller.province,
                                  validator: (value) {
                                    return validateInput(value!, 2, 30, "");
                                  },
                                  decoration: setDecoration('province'),
                                ),
                              )
                          ),
                          Container(
                              alignment: const Alignment(-1,0),
                              child: Container(
                                width: 200,
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: controller.city,
                                  validator: (value) {
                                    return validateInput(value!, 2, 30, "");
                                  },
                                  decoration: setDecoration('city'),
                                ),
                              )
                          ),
                          Container(
                              alignment: const Alignment(-1,0),
                              child: Container(
                                width: 200,
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: controller.zipcode,
                                  validator: (value) {
                                    return validateInput(value!, 2, 10, "");
                                  },
                                  decoration: setDecoration('zipcode'),
                                ),
                              )
                          ),
                        ],
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx((){
                          return Switch(
                            onChanged: (value) {
                              controller.coupon(value);
                              if(value == false){
                                controller.resetCoupon();
                              }
                            },
                            value: controller.coupon.value,
                            activeColor: deepGrey,
                          );
                        }),
                        Text(
                          'Have Coupon Code?',
                          style: TextStyle(
                              color: darkGrey, fontSize: 14, fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                    Obx((){
                      if(controller.coupon.value){
                        return Container(
                            alignment: const Alignment(-1,0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 200,
                                  margin: const EdgeInsets.symmetric(vertical: 5),
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: controller.couponCode,
                                    validator: (value) {
                                      return validateInput(value!, 2, 10, "");
                                    },
                                    decoration: setDecoration('coupon code'),
                                  ),
                                ),
                                RawMaterialButton(
                                  onPressed: (){
                                    if(controller.coupon_accepted.isFalse){
                                      if(controller.couponCode.text.isNotEmpty){
                                        controller.applyCoupon(controller.couponCode.text);
                                      }
                                    }else{
                                      Get.snackbar('Roussha', 'Your coupon has been accepted!', margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10), icon: Icon(Icons.check_circle));
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Obx((){
                                        if(controller.APPLYING_COUPON.value){
                                          return CircularProgressIndicator();
                                        }else{
                                          return controller.coupon_accepted.isTrue? Icon(Icons.check_box) : Icon(Icons.check_box_outlined);
                                        }
                                      }),
                                      Obx((){
                                        return Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: controller.coupon_accepted.isTrue? Text('Accepted') : Text('Apply'),
                                        );
                                      })
                                    ],
                                  ),
                                ),

                              ],
                            )
                        );
                      }else{
                        return SizedBox();
                      }
                    }),
                    Obx((){
                      return Container(
                        alignment: const Alignment(-1,0),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text('${controller.couponMessage}'),
                        ),
                      );
                    }),


                    Container(
                      padding: const EdgeInsets.fromLTRB(
                          16.0, 0, 16.0, 16.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: shadow,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Obx((){
                        if(controller.SUMMARY_CART_LOADING.value){
                          return CircularProgressIndicator();
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
                                            text: '${double.parse(controller.subtotal.value)}',
                                            style: TextStyle( fontSize: 16)
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
                                            text: '${double.parse(controller.tax.value)}',
                                            style: TextStyle(fontSize: 16)
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
                                            text: '${double.parse(controller.total.value)}',
                                            style: TextStyle(fontSize: 20)
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx((){
                          return Switch(
                            onChanged: (value) {
                              controller.shippingDiff(value);
                            },
                            value: controller.shippingDiff.value,
                            activeColor: deepGrey,
                          );
                        }),
                        Text(
                          'Ship to Different Address?',
                          style: TextStyle(
                              color: darkGrey, fontSize: 14, fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                    Obx((){
                      if(controller.shippingDiff.value){
                         return Form(
                           key: controller.checkout_diff_form_state,
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                             mainAxisSize: MainAxisSize.min,
                             children: <Widget>[
                               Container(
                                   alignment: const Alignment(-1,0),
                                   child: Container(
                                     width: 200,
                                     margin: const EdgeInsets.symmetric(vertical: 5),
                                     child: TextFormField(
                                       keyboardType: TextInputType.name,
                                       controller: controller.firstname_diff,
                                       validator: (value) {
                                         return validateInput(value!, 2, 20, "");
                                       },
                                       decoration: setDecoration('first name'),
                                     ),
                                   )
                               ),
                               Container(
                                   alignment: const Alignment(-1,0),
                                   child: Container(
                                     width: 200,
                                     margin: const EdgeInsets.symmetric(vertical: 5),
                                     child: TextFormField(
                                       keyboardType: TextInputType.name,
                                       controller: controller.lastname_diff,
                                       validator: (value) {
                                         return validateInput(value!, 2, 20, "");
                                       },
                                       decoration: setDecoration('last name'),
                                     ),
                                   )
                               ),
                               Container(
                                   alignment: const Alignment(-1,0),
                                   child: Container(
                                     width: 200,
                                     margin: const EdgeInsets.symmetric(vertical: 5),
                                     child: TextFormField(
                                       keyboardType: TextInputType.emailAddress,
                                       controller: controller.email_diff,
                                       validator: (value) {
                                         return validateInput(value!, 2, 30, "email");
                                       },
                                       decoration: setDecoration('email'),
                                     ),
                                   )
                               ),
                               Container(
                                   alignment: const Alignment(-1,0),
                                   child: Container(
                                     width: 200,
                                     margin: const EdgeInsets.symmetric(vertical: 5),
                                     child: TextFormField(
                                       keyboardType: TextInputType.phone,
                                       controller: controller.phone_diff,
                                       validator: (value) {
                                         return validateInput(value!, 8, 15, "phone");
                                       },
                                       decoration: setDecoration('phone'),
                                     ),
                                   )
                               ),
                               Container(
                                   alignment: const Alignment(-1,0),
                                   child: Container(
                                     width: 200,
                                     margin: const EdgeInsets.symmetric(vertical: 5),
                                     child: TextFormField(
                                       keyboardType: TextInputType.text,
                                       controller: controller.line1_diff,
                                       validator: (value) {
                                         return validateInput(value!, 5, 30, "");
                                       },
                                       decoration: setDecoration('line 1'),
                                     ),
                                   )
                               ),
                               Container(
                                   alignment: const Alignment(-1,0),
                                   child: Container(
                                     width: 200,
                                     margin: const EdgeInsets.symmetric(vertical: 5),
                                     child: TextFormField(
                                       keyboardType: TextInputType.text,
                                       controller: controller.line2_diff,
                                       validator: (value) {
                                         return validateInput(value!, 5, 30, "");
                                       },
                                       decoration: setDecoration('line 2'),
                                     ),
                                   )
                               ),
                               Container(
                                   alignment: const Alignment(-1,0),
                                   child: Container(
                                     width: 200,
                                     margin: const EdgeInsets.symmetric(vertical: 5),
                                     child: TextFormField(
                                       keyboardType: TextInputType.text,
                                       controller: controller.country_diff,
                                       validator: (value) {
                                         return validateInput(value!, 2, 30, "");
                                       },
                                       decoration: setDecoration('country'),
                                     ),
                                   )
                               ),
                               Container(
                                   alignment: const Alignment(-1,0),
                                   child: Container(
                                     width: 200,
                                     margin: const EdgeInsets.symmetric(vertical: 5),
                                     child: TextFormField(
                                       keyboardType: TextInputType.text,
                                       controller: controller.province_diff,
                                       validator: (value) {
                                         return validateInput(value!, 2, 30, "");
                                       },
                                       decoration: setDecoration('province'),
                                     ),
                                   )
                               ),
                               Container(
                                   alignment: const Alignment(-1,0),
                                   child: Container(
                                     width: 200,
                                     margin: const EdgeInsets.symmetric(vertical: 5),
                                     child: TextFormField(
                                       keyboardType: TextInputType.text,
                                       controller: controller.city_diff,
                                       validator: (value) {
                                         return validateInput(value!, 2, 30, "");
                                       },
                                       decoration: setDecoration('city'),
                                     ),
                                   )
                               ),
                               Container(
                                   alignment: const Alignment(-1,0),
                                   child: Container(
                                     width: 200,
                                     margin: const EdgeInsets.symmetric(vertical: 5),
                                     child: TextFormField(
                                       keyboardType: TextInputType.text,
                                       controller: controller.zipcode_diff,
                                       validator: (value) {
                                         return validateInput(value!, 2, 10, "");
                                       },
                                       decoration: setDecoration('zipcode'),
                                     ),
                                   )
                               ),
                             ],
                           ),
                         );
                      }else{
                        return SizedBox();
                      }
                    }),

                    Form(
                      key: controller.credit_card_form_state,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.only(left: 16.0),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                    color: Colors.grey[200],
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: controller.cardNumber,
                                    validator: (value) {
                                      return validateInput(value!, 16, 19, "number");
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Card Number'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.only(left: 16.0),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                    color: Colors.grey[200],
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: controller.cardMonth,
                                    validator: (value) {
                                      return validateInput(value!, 1, 2, "number");
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Month'),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.only(left: 16.0),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                    color: Colors.grey[200],
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: controller.cardYear,
                                    validator: (value) {
                                      return validateInput(value!, 4, 4, "number");
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Year'),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.only(left: 16.0),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                    color: Colors.grey[200],
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: controller.cardCVC,
                                    validator: (value) {
                                      return validateInput(value!, 3, 4, "number");
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'CVC'),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),

                    Center(child: placeOrderButton)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
