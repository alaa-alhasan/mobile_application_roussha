import 'package:flutter_html/flutter_html.dart';
import 'package:roussha_store/app_properties.dart';
import 'package:roussha_store/controllers/product_controller.dart';
import 'package:roussha_store/functions/store_auth_info.dart';
import 'package:roussha_store/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roussha_store/screens/search/search_page.dart';
import 'package:get/get.dart';
import 'components/product_display.dart';
import 'view_product_page.dart';

class ProductPage extends StatefulWidget {

  final Product product;

  const ProductPage({
      required this.product,
  });

  @override
  _ProductPageState createState() => _ProductPageState(product);
}

class _ProductPageState extends State<ProductPage> {
  final Product product;

  _ProductPageState(this.product);

  @override
  Widget build(BuildContext context) {

    final ProductController controller = Get.put(ProductController(product: product));

    double width = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;

    Widget viewProductButton = InkWell(
      onTap: () {
        Get.to(()=> ViewProductPage(product: product));
      },
      child: Container(
        height: 80,
        width: width / 1.5,
        decoration: BoxDecoration(
            gradient: mainButton,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.7),
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0)),
        child: Center(
          child: Text("View Product",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: deepGrey),
        actions: <Widget>[
          Obx((){
            if(controller.CART_WISH_ADD_REMOVE_LOADING.value){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else{
              return SizedBox();
            }
          }),
          IconButton(
            icon: new SvgPicture.asset(
              'assets/icons/search_icon.svg',
              fit: BoxFit.scaleDown,
            ),
            onPressed: () {
              Get.to(() => SearchPage());
            },
          )
        ],
        title: Text(
          'Product Overview',
          style: const TextStyle(
              color: deepGrey, fontWeight: FontWeight.w500, fontSize: 18.0),
        ),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                ProductDisplay(),
                SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 16.0),
                  child: Text(
                    product.name,
                    style: const TextStyle(
                        color: deepGrey,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0),
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Obx((){
                  if(controller.in_cart.value == 1){
                    return InkWell(
                      onTap: () async {
                        controller.removeProductFromCart().then((result) {
                          Get.snackbar('Roussha', controller.message.value, margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10), icon: Icon(Icons.shopping_cart));
                        }
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Container(
                          width: 150,
                          height: 40,
                          decoration: BoxDecoration(
                            color: darkGrey,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                offset: Offset(0, 5),
                                blurRadius: 10.0,
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.remove_circle_outlined, color: Colors.white),
                              Center(
                                child: const Text("Remove from Cart",
                                  style: const TextStyle(
                                      color: const Color(0xeefefefe),
                                      fontWeight: FontWeight.w300,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12.0),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  if(controller.in_cart.value == 0){
                    return InkWell(
                      onTap: () async {
                        await isLogin().then((value) => {
                          if(value == true){
                            controller.addToCart().then((result) {
                            Get.snackbar('Roussha', controller.message.value, margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10), icon: Icon(Icons.shopping_cart));
                              }
                            )
                          }else{
                            Get.snackbar('Roussha', 'Please Login before using Cart', margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10), icon: Icon(Icons.error_outlined))
                          }
                        });

                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Container(
                          width: 150,
                          height: 40,
                          decoration: BoxDecoration(
                            color: darkGrey,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                offset: Offset(0, 5),
                                blurRadius: 10.0,
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.add_circle_outlined, color: Colors.white),
                              Center(
                                child: const Text("Add to Cart",
                                    style: const TextStyle(
                                        color: const Color(0xeefefefe),
                                        fontWeight: FontWeight.w300,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 12.0),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  if(controller.in_cart.value == -1){
                    return InkWell(
                      onTap: (){},
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 90,
                              height: 40,
                              decoration: BoxDecoration(
                                color: darkGrey,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.3),
                                    offset: Offset(0, 5),
                                    blurRadius: 10.0,
                                  )
                                ],
                              ),
                              child: Center(
                                child: const Icon(Icons.error, color: Colors.redAccent),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  else{
                    return SizedBox();
                  }
                }),
                SizedBox(
                  height: 16.0,
                ),
                Divider(
                  indent: 20,
                  endIndent: 40,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 40.0, bottom: 20, top: 20),
                    child: Html(
                      data: product.short_description!,
                    ),
                ),
                Divider(
                  indent: 20,
                  endIndent: 40,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 150),
                  child: Html(
                    data: product.description.substring(0,100)+".....",
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(
                  top: 8.0, bottom: bottomPadding != 20 ? 20 : bottomPadding),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                    Color.fromRGBO(255, 255, 255, 0),
                    Color.fromRGBO(127, 127, 127, 0.5),
                    Color.fromRGBO(127, 127, 127, 1),
                  ],
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter)),
              width: width,
              height: 120,
              child: Center(child: viewProductButton),
            ),
          ),
        ],
      ),
    );
  }
}
