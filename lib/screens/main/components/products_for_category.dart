import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:roussha_store/app_properties.dart';
import 'package:roussha_store/controllers/home_controller.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:roussha_store/screens/product/product_page.dart';
import 'package:get/get.dart';

class CategoryProducts extends StatelessWidget {

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              IntrinsicHeight(
                child: Container(
                  margin: const EdgeInsets.only(left: 16.0, right: 8.0),
                  width: 4,
                  color: mediumGrey,
                ),
              ),
              Center(
                  child: Text(
                    'Products',
                    style: TextStyle(
                        color: deepGrey,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
            child: Obx((){
              if(controller.LOADING_PRODUCTS_BY_CATEGORY.value){
                return Center(
                    child: CircularProgressIndicator()
                );
              }else{
                return StaggeredGridView.countBuilder(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  crossAxisCount: 4,
                  itemCount: controller.productsByCategory.length,
                  itemBuilder: (BuildContext context, int index) => new ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: InkWell(
                      onTap: (){
                        Get.to(()=> ProductPage(product: controller.productsByCategory[index]));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                                colors: [
                                  Colors.grey.withOpacity(0.3),
                                  Colors.grey.withOpacity(0.7),
                                ],
                                center: Alignment(0, 0),
                                radius: 0.6,
                                focal: Alignment(0, 0),
                                focalRadius: 0.1
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Hero(
                                tag: controller.productsByCategory[index].image!,
                                child: CachedNetworkImage(
                                  imageUrl: "${imagepath}products/${controller.productsByCategory[index].image}",
                                  placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              Text(
                                controller.productsByCategory[index].name,
                              ),
                              Obx(() {
                                if(controller.saleState.value == 1 && controller.productsByCategory[index].sale_price != null){
                                  return RichText(
                                    text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: '${double.parse(controller.productsByCategory[index].regular_price)}\n',
                                              style: TextStyle(
                                                  color: deepGrey,
                                                  decoration: TextDecoration.lineThrough,
                                                  fontSize: 14
                                              )
                                          ),
                                          TextSpan(
                                              text: '${double.parse(controller.productsByCategory[index].sale_price!)}',
                                              style: TextStyle(
                                                  color: deepGrey,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 20
                                              )
                                          ),
                                          TextSpan(
                                              text: ' CHF',
                                              style: TextStyle(
                                                  color: deepGrey,
                                                  fontSize: 10
                                              )
                                          ),
                                        ]),
                                  );
                                }else{
                                  return RichText(
                                    text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: '${double.parse(controller.productsByCategory[index].regular_price)}',
                                              style: TextStyle(
                                                  color: deepGrey,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 20
                                              )
                                          ),
                                          TextSpan(
                                              text: ' CHF',
                                              style: TextStyle(
                                                  color: deepGrey,
                                                  fontSize: 10
                                              )
                                          ),
                                        ]),
                                  );
                                }
                              }),
                            ],
                          )
                      ),
                    ),
                  ),
                  staggeredTileBuilder: (int index) =>
                      StaggeredTile.count(2, index.isEven ? 3.5 : 3),
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                );
              }
            })
          ),
        ),
      ],
    );
  }


}
