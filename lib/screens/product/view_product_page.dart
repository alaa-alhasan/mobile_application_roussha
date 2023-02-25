import 'package:flutter_html/flutter_html.dart';
import 'package:roussha_store/controllers/product_controller.dart';
import 'package:roussha_store/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roussha_store/screens/search/search_page.dart';
import 'package:get/get.dart';
import '../../app_properties.dart';
import 'components/product_gallery.dart';
import 'components/product_options.dart';
import 'components/product_properties.dart';
import 'components/related_products.dart';

class ViewProductPage extends StatefulWidget {
  final Product product;

  ViewProductPage({required this.product});


  @override
  _ViewProductPageState createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewProductPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    //Get.put(ProductController(product: widget.product));
    final ProductController controller = Get.find();

    return Scaffold(
        //key: _scaffoldKey,
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
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SearchPage()));
              },
            )
          ],
          title: Text(
            'Product Details',
            style: const TextStyle(
                color: deepGrey,
                fontWeight: FontWeight.w500,
                fontFamily: "Montserrat",
                fontSize: 18.0),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                ProductOption(),
                Divider(height: 20,indent: 24,endIndent: 24,),
                ProductGallery(),
                ProductProperties(),
                SizedBox(height: 20,),
                Divider(
                  indent: 20,
                  endIndent: 40,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 40.0, bottom: 20, top: 20),
                  child: Html(
                    data: widget.product.short_description!,
                  ),
                ),
                Divider(
                  indent: 20,
                  endIndent: 40,
                ),
                Padding(
                  padding:
                  EdgeInsets.only(left: 20.0, right: 40.0, bottom: 20, top: 20),
                  child: Html(
                    data: widget.product.description,
                  ),
                ),
                Divider(
                  indent: 20,
                  endIndent: 40,
                ),
                RelatedProducts()
              ],
            ),
          ),
        ));
  }
}
