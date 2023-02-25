import 'package:flutter/material.dart';
import 'package:roussha_store/controllers/product_controller.dart';
import 'package:roussha_store/screens/product/components/size_list.dart';
import 'package:get/get.dart';
import 'color_list.dart';

class ProductProperties extends StatelessWidget {

  final ProductController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  child: Obx((){
                    if(controller.LOADING_PRODUCT_PROPERTIES.value){
                      return Center(
                          child: CircularProgressIndicator()
                      );
                    }else {
                      if(controller.productColors.length > 0){
                        return ColorList(controller.productColors);
                      }else{
                        return SizedBox(height: 0);
                      }
                    }
                  }),
                ),

              ]),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  child: Obx((){
                    if(controller.LOADING_PRODUCT_PROPERTIES.value){
                      return Center(
                          child: CircularProgressIndicator()
                      );
                    }else {
                      if(controller.productSizes.length > 0){
                        return SizeList(controller.productSizes);
                      }else{
                        return SizedBox(height: 0);
                      }
                    }
                  }),
                ),
              ]),
        )
        ]
    );
  }
}
