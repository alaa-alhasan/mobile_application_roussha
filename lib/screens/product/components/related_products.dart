import 'package:roussha_store/app_properties.dart';
import 'package:roussha_store/controllers/product_controller.dart';
import 'product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RelatedProducts extends StatelessWidget {

  final ProductController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 24.0, bottom: 8.0),
          child: Text(
            'Related products',
            style: TextStyle(color: deepGrey, shadows: shadow, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20.0),
          height: 250,
          child: Obx((){
            if(controller.LOADING_RELATED_PRODUCTS.value){
              return Center(
                  child: CircularProgressIndicator()
              );
            }else{
              if(controller.relatedProducts.length > 0){
                return ListView.builder(
                  itemCount: controller.relatedProducts.length,
                  itemBuilder: (_, index) {
                    return Padding(
                        padding: index == 0
                            ? EdgeInsets.only(left: 24.0, right: 8.0)
                            : index == 4
                            ? EdgeInsets.only(right: 24.0, left: 8.0)
                            : EdgeInsets.symmetric(horizontal: 8.0),
                        child: ProductCard(controller.relatedProducts[index]));
                  },
                  scrollDirection: Axis.horizontal,
                );
              }else{
                return Center(
                  child: Text('No Related Products!'),
                );
              }
            }
          }),
        )
      ],
    );
  }
}
