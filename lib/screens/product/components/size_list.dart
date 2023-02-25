import 'package:roussha_store/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roussha_store/controllers/product_controller.dart';

class SizeList extends StatefulWidget {
  final List<String> sizeList;

  SizeList(this.sizeList);

  @override
  _SizeListState createState() => _SizeListState();
}

class _SizeListState extends State<SizeList> {
  int active = 0;

  final ProductController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 3),
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
                        'Size',
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
          Flexible(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.sizeList.length,

              /// list of button colors based on sizeList
              itemBuilder: (_, index) => InkWell(
                onTap: () {
                  setState(() {
                    active = index;
                    controller.selected_size_attr(widget.sizeList[index]);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 8.0),

                  ///scale based on active size
                  child: Transform.scale(
                    scale: active == index ? 1.3 : 1,
                    child: SizeOption(widget.sizeList[index]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SizeOption extends StatelessWidget {
  final String size;

  const SizeOption(this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)), color: darkGrey),
      child: Center(
        child: Text(
          '${size}',
          style: TextStyle(color: deepGrey, fontWeight: FontWeight.bold),
        ),
      )
    );
  }
}
