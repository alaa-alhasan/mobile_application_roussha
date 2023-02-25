import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:roussha_store/controllers/filter_controller.dart';
import 'package:roussha_store/models/product.dart';
import 'package:roussha_store/screens/product/product_page.dart';
import 'package:get/get.dart';
import '../../app_properties.dart';

class ProCard extends StatelessWidget {
  final Product product;

  final FilterController filterController = Get.find();

  ProCard({
    required this.controller,
    required this.product,
  })  : height = Tween<double>(begin: 150, end: 250.0).animate(
    CurvedAnimation(
      parent: controller,
      curve: Interval(
        0.0,
        0.300,
        curve: Curves.ease,
      ),
    ),
  ),
        itemHeight = Tween<double>(begin: 0, end: 150.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.300,
              curve: Curves.ease,
            ),
          ),
        );

  final Animation<double> controller;
  final Animation<double> height;
  final Animation<double> itemHeight;

  // This function is called each time the controller "ticks" a new frame.
  // When it runs, all of the animation's values will have been
  // updated to reflect the controller's current value.
  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Container(
      height: height.value,
      margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [darkGrey, grey],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: SizedBox(
                    width: 130,
                    child: Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Obx((){
                  if(filterController.saleState.value == 1 && product.sale_price != null){
                    return RichText(
                      text: TextSpan(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          children: [
                            TextSpan(
                                text: '${double.parse(product.regular_price)}\n',
                                style: TextStyle(
                                  fontSize: 14,
                                  decoration: TextDecoration.lineThrough,
                                )
                            ),
                            TextSpan(
                                text: '${double.parse(product.sale_price!)}',
                                style: TextStyle(
                                  fontSize: 24,
                                )
                            ),
                            TextSpan(
                                text: ' CHF',
                                style: TextStyle(
                                  fontSize: 12,
                                )
                            ),
                          ]),
                    );
                  }else{
                    return RichText(
                      text: TextSpan(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          children: [
                            TextSpan(
                                text: '${double.parse(product.regular_price)}',
                                style: TextStyle(
                                  fontSize: 24,
                                )
                            ),
                            TextSpan(
                                text: ' CHF',
                                style: TextStyle(
                                  fontSize: 12,
                                )
                            ),
                          ]),
                    );
                  }
                }),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
//        mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 16.0,right: 20),
                height: itemHeight.value,
                //width: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: CachedNetworkImage(
                    imageUrl: "${imagepath}products/${product.image}",
                    placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(24))),
                  child: InkWell(
                    onTap: () {
                      Get.to(()=> ProductPage(product: product));
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(45.0, 10.0, 45.0, 10.0),
                      child: Text(
                        'View',
                        style: TextStyle(color: darkGrey),
                      ),
                  )
                )
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}

class FilterProductCard extends StatefulWidget {
  final Product product;

  const FilterProductCard({required this.product});

  @override
  _FilterProductCardState createState() => _FilterProductCardState();
}

class _FilterProductCardState extends State<FilterProductCard>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  bool isActive = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
  }

  Future<void> _playAnimation() async {
    try {
      await _controller.forward().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  Future<void> _reverseAnimation() async {
    try {
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  @override
  Widget build(BuildContext context) {
    var timeDilation = 10.0; // 1.0 is normal animation speed.
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (isActive) {
          isActive = !isActive;
          _reverseAnimation();
        } else {
          isActive = !isActive;
          _playAnimation();
        }
      },
      child: ProCard(
        controller: _controller.view,
        product: widget.product
      ),
    );
  }
}
