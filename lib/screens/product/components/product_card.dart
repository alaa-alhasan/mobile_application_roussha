import 'package:cached_network_image/cached_network_image.dart';
import 'package:roussha_store/app_properties.dart';
import 'package:roussha_store/controllers/product_controller.dart';
import 'package:roussha_store/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../product_page.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  final ProductController controller = Get.find();

  ProductCard(this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.delete<ProductController>();
          Get.off(()=> ProductPage(product: product));
        },
        child: Container(
            height: 250,
            width: MediaQuery.of(context).size.width / 2 - 29,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: mediumGrey.withOpacity(0.5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: "${imagepath}products/${product.image}",
                        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                        fit: BoxFit.fitWidth,
                      )
                  ),
                ),
                Flexible(
                  child: Align(
                    alignment: Alignment(1, 0.5),
                    child: Container(
                        //margin: const EdgeInsets.only(left: 16.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            color: darkGrey.withOpacity(0.5),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                        child: Text(
                          product.name,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: deepGrey,
                          ),
                        )),
                  ),
                ),
                Flexible(
                  child: Align(
                    alignment: Alignment(1, -0.5),
                    child: Container(
                      //margin: const EdgeInsets.only(left: 16.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            color: darkGrey.withOpacity(0.5),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                      child: Obx((){
                        if(controller.saleState.value == 1 && product.sale_price != null){
                          return RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: '${double.parse(product.regular_price)}\n',
                                  style: const TextStyle(
                                      color: deepGrey,
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 9.0)),
                              TextSpan(
                                  text: '${double.parse(product.sale_price!)}',
                                  style: const TextStyle(
                                      color: deepGrey,
                                      fontSize: 12.0)),
                              TextSpan(
                                  text: 'CHF',
                                  style: const TextStyle(
                                      color: deepGrey,
                                      fontSize: 5))
                            ]),
                          );
                        }else{
                          return RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: '${double.parse(product.regular_price)}',
                                  style: const TextStyle(
                                      color: deepGrey,
                                      fontSize: 12.0)),
                              TextSpan(
                                  text: 'CHF',
                                  style: const TextStyle(
                                      color: deepGrey,
                                      fontSize: 8.0))
                            ]),
                          );
                        }
                      }),
                    ),
                  ),
                )
              ],
            )));
  }
}
