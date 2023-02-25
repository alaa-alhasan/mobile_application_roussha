import 'package:cached_network_image/cached_network_image.dart';
import 'package:roussha_store/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roussha_store/controllers/product_controller.dart';
import 'package:roussha_store/functions/store_auth_info.dart';
import 'package:roussha_store/screens/product/components/show_image.dart';

class ProductOption extends StatelessWidget {

  final ProductController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 12,right: 12,bottom: 0,top: 0,
            child: InkWell(
              onTap: (){
                Get.to(() => ShowImage(url: '${imagepath}products/${controller.product.image}'));
              },
              child: Hero(
                tag: controller.product.image!,
                child: CachedNetworkImage(
                    imageUrl: "${imagepath}products/${controller.product.image}",
                    placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                    fit: BoxFit.cover
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            top: 16,
            child: Obx((){
              if(controller.in_wishlist.value == 1){
                return RawMaterialButton(
                  onPressed: () async {
                    controller.removeProductFromWishlist().then((result) {
                      Get.snackbar('Roussha', controller.message.value, margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10), icon: Icon(Icons.favorite_outline));
                    }
                    );
                  },
                  constraints: const BoxConstraints(minWidth: 45, minHeight: 45),
                  child:
                  Icon(Icons.favorite, color: deepGrey),
                  elevation: 0.0,
                  shape: CircleBorder(),
                  fillColor: Color.fromRGBO(255, 255, 255, 0.5),
                );
              }
              if(controller.in_wishlist.value == 0){
                return RawMaterialButton(
                  onPressed: () async {
                    await isLogin().then((value) => {
                      if(value == true){
                        controller.addToWishlist().then((result) {
                          Get.snackbar('Roussha', controller.message.value, margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),icon: Icon(Icons.favorite_outline));
                        }
                        )
                      }else{
                        Get.snackbar('Roussha', 'Please Login before using Wishlist', margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10), icon: Icon(Icons.error_outlined))
                      }
                    });
                  },
                  constraints: const BoxConstraints(minWidth: 45, minHeight: 45),
                  child:
                  Icon(Icons.favorite_outline, color: deepGrey),
                  elevation: 0.0,
                  shape: CircleBorder(),
                  fillColor: Color.fromRGBO(255, 255, 255, 0.5),
                );
              }
              if(controller.in_wishlist.value == -1){
                return RawMaterialButton(
                  onPressed: () {},
                  constraints: const BoxConstraints(minWidth: 45, minHeight: 45),
                  child:
                  Icon(Icons.error, color: Colors.redAccent),
                  elevation: 0.0,
                  shape: CircleBorder(),
                  fillColor: Color.fromRGBO(255, 255, 255, 0.5),
                );
              }
              else{
                return SizedBox();
              }
            }),
          ),
          Positioned(
            right: 0.0,
            child: Container(
              height: 180,
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                        controller.product.name,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: deepGrey,
                            shadows: shadow)),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    decoration: BoxDecoration(
                        gradient: mainButton,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0))),
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Center(
                      child: Obx((){
                        if(controller.saleState.value == 1 && controller.product.sale_price != null){
                          return RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: '${double.parse(controller.product.regular_price)}\n',
                                    style: const TextStyle(
                                        color: const Color(0xFFFFFFFF),
                                        fontFamily: "Montserrat",
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 14.0)),
                                TextSpan(
                                    text: '${double.parse(controller.product.sale_price!)}',
                                    style: const TextStyle(
                                        color: const Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Montserrat",
                                        fontSize: 24.0)),
                                TextSpan(
                                    text: 'CHF',
                                    style: const TextStyle(
                                        color: const Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Montserrat",
                                        fontSize: 10.0))
                              ]));
                        }else{
                          return RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: '${double.parse(controller.product.regular_price)}',
                                    style: const TextStyle(
                                        color: const Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Montserrat",
                                        fontSize: 24.0)),
                                TextSpan(
                                    text: 'CHF',
                                    style: const TextStyle(
                                        color: const Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Montserrat",
                                        fontSize: 10.0))
                              ]));
                        }
                      }),
                    ),
                  ),
                  Obx((){
                    if(controller.in_cart.value == 1){
                      return InkWell(
                        onTap: () async {
                          controller.removeProductFromCart().then((result) {
                            Get.snackbar('Roussha', controller.message.value, margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10), icon: Icon(Icons.shopping_cart));
                          }
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          decoration: BoxDecoration(
                              gradient: mainButton,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0))),
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.remove_circle_outlined, color: Colors.white),
                              Center(
                                child: Text(
                                  'Remove from cart',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    if(controller.in_cart.value == 0){
                      return InkWell(
                        onTap: () async {
                          await isLogin().then((value) => {
                            if(value == true){
                              controller.addToCart().then((result) {
                                Get.snackbar('Roussha', controller.message.value, margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10), icon: Icon(Icons.shopping_cart));
                              }
                              )
                            }else{
                              Get.snackbar('Roussha', 'Please Login before using Cart', margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10), icon: Icon(Icons.error_outlined))
                            }
                          });

                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          decoration: BoxDecoration(
                              gradient: mainButton,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0))),
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.add_circle_outlined, color: Colors.white),
                              Center(
                                child: Text(
                                  'Add to cart',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    if(controller.in_cart.value == -1){
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          decoration: BoxDecoration(
                              gradient: mainButton,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0))),
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: const Icon(Icons.error, color: Colors.redAccent),
                        ),
                      );
                    }
                    else {
                      return SizedBox();
                    }
                  }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
