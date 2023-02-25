import 'package:cached_network_image/cached_network_image.dart';
import 'package:roussha_store/app_properties.dart';
import 'package:roussha_store/controllers/product_controller.dart';
import 'package:roussha_store/functions/store_auth_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDisplay extends StatelessWidget {

  final ProductController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment(-1, 0),
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
            child: Container(
              height: screenAwareSize(220, context),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18.0,),
                    child: Container(
                      height: 230,
                      width: 230,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Hero(
                          tag: controller.product.image!,
                          child: CachedNetworkImage(
                            imageUrl: "${imagepath}products/${controller.product.image}",
                            placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
            top: 30.0,
            right: 0,
            child: Container(
                width: MediaQuery.of(context).size.width /2,
                height: 55,
                padding: EdgeInsets.only(right: 24),
                decoration: new BoxDecoration(
                    color: deepGrey,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.7),
                          offset: Offset(0, 3),
                          blurRadius: 6.0),
                    ]),
                child: Align(
                  alignment: Alignment(1, 0),
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
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 26.0)),
                            TextSpan(
                                text: 'CHF',
                                style: const TextStyle(
                                    color: const Color(0xFFFFFFFF),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Montserrat",
                                    fontSize: 8.0))
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
                                    fontSize: 26.0)),
                            TextSpan(
                                text: 'CHF',
                                style: const TextStyle(
                                    color: const Color(0xFFFFFFFF),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Montserrat",
                                    fontSize: 8.0))
                          ]));
                    }
                  }),
                ))),
        Positioned(
          left: 20.0,
          bottom: 0.0,
          child: Obx((){
            if(controller.in_wishlist.value == 1){
              return RawMaterialButton(
                onPressed: () async {
                  controller.removeProductFromWishlist().then((result) {
                    Get.snackbar('Roussha', controller.message.value, margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10), icon: Icon(Icons.remove_circle));
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
                        Get.snackbar('Roussha', controller.message.value, margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10), icon: Icon(Icons.add_circle));
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
        )
      ],
    );
  }
}
