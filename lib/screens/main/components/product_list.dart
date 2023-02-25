import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:lottie/lottie.dart';
import 'package:roussha_store/app_properties.dart';
import 'package:roussha_store/controllers/home_controller.dart';
import 'package:roussha_store/models/product.dart';
import 'package:roussha_store/screens/product/product_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductList extends StatelessWidget {

  final SwiperController swiperController = SwiperController();
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.height / 2.7;
    double cardWidth = MediaQuery.of(context).size.width / 1.8;

    return SizedBox(
      height: cardHeight,
      child: Obx((){
        if(controller.INTERNET_CONNECTION.isTrue){
          if(controller.LOADING_PRODUCTS.value){
            return Center(
                child: CircularProgressIndicator()
            );
          }else{
            if(controller.products.length > 0){
              return Swiper(
                itemCount: controller.products.length,
                itemBuilder: (_, index) {
                  return ProductCard(
                      height: cardHeight, width: cardWidth, product: controller.products[index]);
                },
                scale: 0.8,
                controller: swiperController,
                viewportFraction: 0.6,
                loop: false,
                fade: 0.5,
                pagination: SwiperCustomPagination(
                  builder: (context, config) {
                    if (config!.itemCount! > 20) {
                      print(
                          "The itemCount is too big, we suggest use FractionPaginationBuilder instead of DotSwiperPaginationBuilder in this sitituation");
                    }
                    Color activeColor = mediumGrey;
                    Color color = Colors.grey.withOpacity(.3);
                    double size = 10.0;
                    double space = 5.0;

                    if (config.indicatorLayout != PageIndicatorLayout.NONE &&
                        config.layout == SwiperLayout.DEFAULT) {
                      return new PageIndicator(
                        count: config.itemCount!,
                        controller: config.pageController!,
                        layout: config.indicatorLayout,
                        size: size,
                        activeColor: activeColor,
                        color: color,
                        space: space,
                      );
                    }

                    List<Widget> dots = [];

                    int itemCount = config.itemCount!;
                    int activeIndex = config.activeIndex!;

                    for (int i = 0; i < itemCount; ++i) {
                      bool active = i == activeIndex;
                      dots.add(Container(
                        key: Key("pagination_$i"),
                        margin: EdgeInsets.all(space),
                        child: ClipOval(
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: active ? activeColor : color,
                            ),
                            width: size,
                            height: size,
                          ),
                        ),
                      ));
                    }

                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: dots,
                        ),
                      ),
                    );
                  },
                ),
              );
            }else{
              return Center(child: Lottie.asset('assets/empty.json',height: 200, width: 200));
            }
          }
        }else{
          return Center(child: Lottie.asset('assets/offline.json',height: 100, width: 100));
        }
      }
      )
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final double height;
  final double width;

  final HomeController controller = Get.find();

  ProductCard({
    required this.product,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(()=> ProductPage(product: product));
      },
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 30),
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              color: mediumGrey,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Obx((){
                  if(controller.product_tag.value == 0){
                    return Padding(
                      padding: EdgeInsets.all(12),
                      child: Text('NEW', style: TextStyle(color: deepGrey, fontSize: 12)),
                    );
                  }
                  if(controller.product_tag.value == 1){
                    return Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(Icons.wb_sunny_outlined, color: deepGrey, size: 20),
                    );
                  }
                  if(controller.product_tag.value == 2){
                    return Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(Icons.star_outline, color: deepGrey, size: 20),
                    );
                  }else{
                    return SizedBox();
                  }
                }),
                Column(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product.name,
                            style: TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                        )),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20.0),
                        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 12.0, 4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          color: deepGrey,
                        ),
                        child: Obx((){
                          if(controller.saleState.value == 1 && product.sale_price != null){
                            return RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: '${double.parse(product.regular_price)}\n',
                                      style: const TextStyle(
                                          color: grey,
                                          decoration: TextDecoration.lineThrough,
                                          fontSize: 14.0)),
                                  TextSpan(
                                      text: '${double.parse(product.sale_price!)}',
                                      style: const TextStyle(
                                          color: const Color(0xFFFFFFFF),
                                          fontSize: 24.0)),
                                  TextSpan(
                                      text: 'CHF',
                                      style: const TextStyle(
                                          color: const Color(0xFFFFFFFF),
                                          fontSize: 10.0))
                                ]));
                          }else{
                            return RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: '${double.parse(product.regular_price)}',
                                      style: const TextStyle(
                                          color: const Color(0xFFFFFFFF),
                                          fontSize: 24.0)),
                                  TextSpan(
                                      text: 'CHF',
                                      style: const TextStyle(
                                          color: const Color(0xFFFFFFFF),
                                          fontSize: 10.0))
                                ]));
                          }
                        }),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 5,
            height: height / 1.8,
            width: width / 1.2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Hero(
                tag: product.image!,
                child: CachedNetworkImage(
                  imageUrl: "${imagepath}products/${product.image}",
                  placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
