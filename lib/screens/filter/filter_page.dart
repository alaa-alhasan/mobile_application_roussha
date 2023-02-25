import 'package:lottie/lottie.dart';
import 'package:roussha_store/controllers/filter_controller.dart';
import '../../app_properties.dart';
import 'package:flutter/material.dart';
import 'package:rubber/rubber.dart';
import 'package:get/get.dart';
import 'filter_product_card.dart';

class FilterPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<FilterPage> with SingleTickerProviderStateMixin {

  FilterController controller = Get.put(FilterController());
  // FilterController controller = Get.find();

  late RubberAnimationController _controller;

  @override
  void initState() {
    controller.initController();
    _controller = RubberAnimationController(
        vsync: this,
        halfBoundValue: AnimationControllerValue(percentage: 0.4),
        upperBoundValue: AnimationControllerValue(percentage: 0.4),
        lowerBoundValue: AnimationControllerValue(pixel: 50),
        duration: Duration(milliseconds: 200));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _expand() {
    _controller.expand();
  }

  Widget _getLowerLayer() {
    return Container(
      child: Obx((){
        if(controller.INTERNET_CONNECTION.isTrue){
          if(controller.LOADING_PRODUCTS.value){
            return Center(
                child: CircularProgressIndicator()
            );
          }else{
            if(controller.filter_Results.length > 0){
              return ListView.builder(
                itemCount: controller.filter_Results.length,
                itemBuilder: (_, index) => Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: FilterProductCard(
                      product: controller.filter_Results[index]
                  ),
                ),
              );
            }else{
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Oops! Not Found'),
                    Lottie.asset('assets/empty.json', width: 200, height: 200)
                  ],
                ),
              );
            }
          }
        }else{
          return Center(child: Lottie.asset('assets/offline.json',height: 100, width: 100));
        }
      })
    );
  }

  Widget _getUpperLayer() {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                offset: Offset(0, -3),
                blurRadius: 10)
          ],
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(24), topLeft: Radius.circular(24)),
          color: Colors.white),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Filters',
                style: TextStyle(color: darkGrey),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:
              const EdgeInsets.only(left: 32.0, top: 16.0, bottom: 16.0),
              child: Text(
                'Filter by Color, Size or Max Price',
                style: TextStyle(fontWeight: FontWeight.bold, color: grey)
              ),
            ),
          ),
          Container(
            height: 50,
            child: Obx((){
              if(controller.LOADING_COLORS.value){
                return Center(
                    child: CircularProgressIndicator()
                );
              }else{
                return ListView.builder(
                  itemCount: controller.colorFilter.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) => Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                controller.selectedColor(controller.colorFilter[index]);
                                controller.fetchFilteredProducts();
                              });
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 8.0),
                                decoration: controller.selectedColor == controller.colorFilter[index]
                                    ? BoxDecoration(
                                    color: darkGrey,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(45)))
                                    : BoxDecoration(),
                                child: Text(
                                  controller.colorFilter[index],
                                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                                ))),
                      )),
                );
              }
            }),
          ),
          Container(
            height: 50,
            child: Obx((){
              if(controller.LOADING_SIZES.value){
                return Center(
                    child: CircularProgressIndicator()
                );
              }else{
                return ListView.builder(
                  itemCount: controller.sizeFilter.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) => Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                controller.selectedSize(controller.sizeFilter[index]);
                                controller.fetchFilteredProducts();
                              });
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 8.0),
                                decoration: controller.selectedSize == controller.sizeFilter[index]
                                    ? BoxDecoration(
                                    color: darkGrey,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(45)))
                                    : BoxDecoration(),
                                child: Text(
                                  controller.sizeFilter[index],
                                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                                ))),
                      )),
                );
              }
            }),
          ),
          Container(
            height: 50,
            child: Obx((){
              if(controller.LOADING_PRICES.value){
                return Center(
                    child: CircularProgressIndicator()
                );
              }else{
                return ListView.builder(
                  itemCount: controller.priceFilter.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) => Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                controller.maxprice(controller.priceFilter[index]);
                                controller.fetchFilteredProducts();
                              });
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 8.0),
                                decoration: controller.maxprice == controller.priceFilter[index]
                                    ? BoxDecoration(
                                    color: darkGrey,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(45)))
                                    : BoxDecoration(),
                                child: Text(
                                  controller.priceFilter[index].toString(),
                                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                                ))),
                      )),
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    controller.checkInternet();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: deepGrey),
        actions: <Widget>[
          Obx(() {
            if(controller.RANDOMLY.value){
              return SizedBox();
            }else{
              return RawMaterialButton(
                onPressed: () {
                  setState(() {
                    controller.clearFilter();
                  });
                },
                child: const Text(
                  'Clear Filter',
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
          })
        ],
        title: Text(
          'Filter',
          style: TextStyle(
              color: deepGrey, fontWeight: FontWeight.w500, fontSize: 18.0),
        ),
      ),
      body: SafeArea(
        top: true,
        bottom: false,
        child: RubberBottomSheet(
          lowerLayer: _getLowerLayer(), // The underlying page (Widget)
          upperLayer: _getUpperLayer(), // The bottomsheet content (Widget)
          animationController: _controller, // The one we created earlier
        ),
      ),
    );
  }
}
