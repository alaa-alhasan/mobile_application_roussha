import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:roussha_store/controllers/product_controller.dart';
import 'package:roussha_store/controllers/search_controller.dart';
import 'package:roussha_store/screens/product/product_page.dart';
import '../../app_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(
            body: Container(
              margin: const EdgeInsets.only(top: kToolbarHeight),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Search',
                          style: TextStyle(
                            color: darkGrey,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CloseButton()
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                        border:
                        Border(bottom: BorderSide(color: deepGrey, width: 1))),
                    child: GetBuilder<SearchController>(
                      init: SearchController(),
                      builder: (controller){
                        return TextField(
                          controller: controller.textEditController,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              controller.textUpdate(value);
                            } else {
                              controller.clearList();
                            }
                          },
                          cursorColor: darkGrey,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            prefixIcon: SvgPicture.asset(
                              'assets/icons/search_icon.svg',
                              fit: BoxFit.scaleDown,
                            ),
                            suffix: RawMaterialButton(
                              onPressed: () {
                                controller.textEditController.clear();
                                controller.clearList();
                              },
                              child: Text(
                                'Clear',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ),
                  GetBuilder<SearchController>(
                      builder: (controller){
                        return Flexible(
                            child: Container(
                                color: grey,
                                child: ListView.builder(
                                  itemCount: controller.products.length,
                                  itemBuilder: (_, index) => Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                    child: ListTile(
                                      onTap: () {
                                        Get.delete<ProductController>();
                                        Get.to(() => ProductPage(product: controller.products[index]));
                                      },
                                      title: Text(controller.products[index].name),
                                      trailing: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: CachedNetworkImage(
                                            imageUrl: "${imagepath}products/${controller.products[index].image}",
                                            placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                                            fit: BoxFit.cover
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                            ));
                      }
                  )
                ],
              )
            )
        ),
      ),
    );
  }
}
