import 'package:roussha_store/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roussha_store/controllers/product_controller.dart';

class ColorList extends StatefulWidget {
  final List<Color> colorList;

  ColorList(this.colorList);

  @override
  _ColorListState createState() => _ColorListState();
}

class _ColorListState extends State<ColorList> {
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
                        'Color',
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
              itemCount: widget.colorList.length,

              /// list of button colors based on colorList
              itemBuilder: (_, index) => InkWell(
                onTap: () {
                  setState(() {
                    active = index;
                    controller.calculateColorFromString(widget.colorList[index]);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 8.0),

                  ///scale based on active color
                  child: Transform.scale(
                    scale: active == index ? 1.3 : 1,
                    child: ColorOption(widget.colorList[index]),
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

class ColorOption extends StatelessWidget {
  final Color color;

  const ColorOption(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)), color: color),
    );
  }
}
