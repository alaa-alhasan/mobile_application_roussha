import 'package:cached_network_image/cached_network_image.dart';
import 'package:lottie/lottie.dart';
import 'package:roussha_store/controllers/profile_controller.dart';
import 'package:get/get.dart';
import 'package:roussha_store/screens/product/product_page.dart';
import '../../app_properties.dart';
import 'package:flutter/material.dart';

class WishlistPage extends StatelessWidget {

  final ProfileController controller = Get.find();

  @override
  Widget build(BuildContext context) {

    controller.fetchMyWishlist();

    return Material(
      color: Colors.grey[100],
      child: SafeArea(
        child: Container(
            margin: const EdgeInsets.only(top: kToolbarHeight),
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Wishlist',
                    style: TextStyle(
                      color: darkGrey,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Obx(() {
                    if(controller.REMOVE_ITEM_WISHLIST_LOADING.value){
                      return CircularProgressIndicator();
                    }else {
                      return SizedBox();
                    }
                  }),
                  Row(
                    children: [
                      Obx((){
                        if(controller.my_wishlist.length > 0){
                          return RawMaterialButton(onPressed: (){
                            controller.clearWishlist();
                          },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: grey,
                                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                child: Text('Clear'),
                              )
                          );
                        }else {
                          return SizedBox();
                        }
                      }),
                      CloseButton()
                    ],
                  )
                ],
              ),
              Flexible(
                child: Obx((){
                  if(controller.INTERNET_CONNECTION.isTrue){
                    if(controller.WISHLIST_LOADING.value){
                      return Center(
                          child: CircularProgressIndicator()
                      );
                    }else{
                      if(controller.my_wishlist.length > 0){
                        return ListView.builder(
                          itemCount: controller.my_wishlist.length,
                          itemBuilder: (_, index) => Container(
                            //padding: const EdgeInsets.all(16.0),
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(5.0))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Row(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          Get.to(() => ProductPage(product: controller.my_wishlist[index].product));
                                        },
                                        child: SizedBox(
                                          height: 110,
                                          width: 110,
                                          child: CachedNetworkImage(
                                            imageUrl: "${imagepath}products/${controller.my_wishlist[index].product.image}",
                                            placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                                            fit: BoxFit.contain,
                                          ),
                                        )
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller.my_wishlist[index].product.name,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Obx((){
                                            if(controller.saleState.value == 1 && controller.my_wishlist[index].product.sale_price != null){
                                              return RichText(
                                                text: TextSpan(
                                                    style: TextStyle(
                                                      color: deepGrey,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                          text: '${double.parse(controller.my_wishlist[index].product.regular_price)}\n',
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                            decoration: TextDecoration.lineThrough,
                                                          )
                                                      ),
                                                      TextSpan(
                                                          text: '${double.parse(controller.my_wishlist[index].product.sale_price!)}',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          )
                                                      ),
                                                      TextSpan(
                                                          text: ' CHF',
                                                          style: TextStyle(
                                                            fontSize: 8,
                                                          )
                                                      ),
                                                    ]),
                                              );
                                            }else{
                                              return RichText(
                                                text: TextSpan(
                                                    style: TextStyle(
                                                      color: deepGrey,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                          text: '${double.parse(controller.my_wishlist[index].product.regular_price)}',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          )
                                                      ),
                                                      TextSpan(
                                                          text: ' CHF',
                                                          style: TextStyle(
                                                            fontSize: 8,
                                                          )
                                                      ),
                                                    ]),
                                              );
                                            }
                                          }),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: grey,
                                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10))
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller.removeItemWishlist(controller.my_wishlist[index].rowId);
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.all(14.0),
                                            decoration: BoxDecoration(
                                                color: grey,
                                                borderRadius: BorderRadius.only(
                                                    bottomRight: Radius.circular(5.0),
                                                    bottomLeft: Radius.circular(5.0))),
                                            child: Align(
                                                alignment: Alignment.centerRight,
                                                child:  Row(
                                                  children: [
                                                    Icon(
                                                      Icons.cancel,
                                                      size: 14,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      'Remove',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 12),
                                                    )
                                                  ],
                                                )
                                            )),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller.moveToCart(controller.my_wishlist[index].rowId, index);
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.all(14.0),
                                            decoration: BoxDecoration(
                                                color: grey,
                                                borderRadius: BorderRadius.only(
                                                    bottomRight: Radius.circular(5.0),
                                                    bottomLeft: Radius.circular(5.0))),
                                            child: Align(
                                                alignment: Alignment.centerRight,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.double_arrow_sharp,
                                                      size: 14,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      'Move to Cart',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 12),
                                                    )
                                                  ],
                                                ))),
                                      )
                                    ],),
                                )
                              ],
                            ),
                          ),
                        );
                      }else {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset('assets/empty_box.json', width: 200, height: 200),
                              Text('You Wishlist Is Empty!')
                            ],
                          ),
                        );
                      }
                    }
                  }else{
                    return Center(child: Lottie.asset('assets/offline.json',height: 100, width: 100));
                  }
                }),
              )
            ])),
      ),
    );
  }
}
