import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:roussha_store/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:roussha_store/screens/product/product_page.dart';
import '../../../app_properties.dart';

class OnSaleCard extends StatelessWidget {

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8.0),
        height: 80,
        width: 800,
        child: Obx((){
          if(controller.LOADING_ON_SALE_PRODUCTS.value){
            return Center(
                child: CircularProgressIndicator()
            );
          }else{
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.onSaleProducts.length,
                itemBuilder: (_, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('${controller.onSaleProducts[index].name}'),
                                RichText(
                                  text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text: '${double.parse(controller.onSaleProducts[index].regular_price)}',
                                            style: TextStyle(color: grey, fontSize: 15,decoration: TextDecoration.lineThrough)),
                                        TextSpan(
                                            text: ' CHF',
                                            style: TextStyle(color: grey, fontSize: 8)),
                                      ]),
                                ),
                                RichText(
                                  text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text: '${double.parse(controller.onSaleProducts[index].sale_price!)}',
                                            style: TextStyle(color: darkGrey, fontSize: 15)),
                                        TextSpan(
                                            text: ' CHF',
                                            style: TextStyle(color: darkGrey, fontSize: 8)),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 80,
                            width: 90,
                            padding: EdgeInsets.all(3),
                            child: InkWell(
                              onTap: (){
                                Get.to(()=> ProductPage(product: controller.onSaleProducts[index]));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: "${imagepath}products/${controller.onSaleProducts[index].image}",
                                  placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
            );
          }
        })
    );
  }
}





