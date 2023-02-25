import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:roussha_store/controllers/product_controller.dart';
import 'package:get/get.dart';
import 'package:roussha_store/screens/product/components/show_image.dart';
import '../../../app_properties.dart';

class ProductGallery extends StatelessWidget {

  final ProductController controller = Get.find();

  @override
  Widget build(BuildContext context) {

    if(controller.PRODUCTS_HAS_GALLERY.value){
      return Container(
          margin: EdgeInsets.fromLTRB(24, 5, 24, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: SizedBox(
                  height: 20,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      IntrinsicHeight(
                        child: Container(
                          margin: EdgeInsets.only(right: 5),
                          width: 4,
                          color: mediumGrey,
                        ),
                      ),
                      Center(
                          child: Text(
                            'Gallery',
                            style: TextStyle(
                                color: deepGrey,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                shadows: shadow
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                height: 100,
                child: ListView.builder(
                  itemCount: controller.gallery.length,
                  itemBuilder: (_, index){
                    return Container(
                      height: 100,
                      width: 100,
                      color: darkGrey.withOpacity(0.5),
                      margin: EdgeInsets.only(right: 5),
                      child: InkWell(
                        onTap: (){
                          Get.to(() => ShowImage(url: '${imagepath}products/${controller.gallery[index]}'));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: CachedNetworkImage(
                            imageUrl: "${imagepath}products/${controller.gallery[index]}",
                            placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                ),
              )
            ],
          )
      );
    }else{
      return Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 0),
            child: Text('Gallery Is Empty For this Product!'),
          ),
        ),
      );
    }

  }
}
