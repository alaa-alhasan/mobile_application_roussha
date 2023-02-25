import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:roussha_store/app_properties.dart';
import 'package:roussha_store/controllers/cart_controller.dart';
import 'package:roussha_store/models/cart.dart';
import 'package:roussha_store/screens/product/components/color_list.dart';
import 'package:flutter/material.dart';
import 'package:roussha_store/screens/product/components/size_list.dart';
import 'package:get/get.dart';

class CartItemList extends StatelessWidget {


  final Cart cartItem;

  final CartController controller = Get.find();

  CartItemList(this.cartItem);

  @override
  Widget build(BuildContext context) {

    return LongPressDraggable(
      data: cartItem,
      maxSimultaneousDrags: 1,
      feedback: DraggableChildFeedback(cartItem: cartItem,),
      childWhenDragging: DraggableChild(cartItem: cartItem,),
      child: Container(
        height: 110,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment(0, 0.8),
              child: Container(
                  height: 100,
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                      color: grey,
                      boxShadow: shadow,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            height: 90,
                            width: 90,
                            margin: EdgeInsets.only(left: 5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: "${imagepath}products/${cartItem.product.image}",
                                placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                                fit: BoxFit.contain,
                              ),
                            ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RawMaterialButton(
                              onPressed: () {
                                controller.increaseItemCartQuantity(cartItem.rowId);
                              },
                              constraints: const BoxConstraints(maxWidth: 25, maxHeight: 25),
                              child: Icon(Icons.add_circle_outlined, color: darkGrey,),
                              shape: CircleBorder(),
                              fillColor: Color.fromRGBO(255, 255, 255, 0.5),
                            ),
                            RawMaterialButton(
                              onPressed: () {
                                if(cartItem.qty > 1){
                                  controller.decreaseItemCartQuantity(cartItem.rowId);
                                }else{
                                  Get.snackbar('Roussha', 'You have only One item!', margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10), icon: Icon(Icons.error_outline));
                                }
                              },
                              constraints: const BoxConstraints(maxWidth: 25, maxHeight: 25),
                              child: Icon(Icons.remove_circle_outlined, color: darkGrey),
                              shape: CircleBorder(),
                              fillColor: Color.fromRGBO(255, 255, 255, 0.5),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 12.0, right: 12.0),
                          //width: 180,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                cartItem.product.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: deepGrey,
                                ),
                              ),
                              SizedBox(height:4.0),
                              Obx((){
                                if(controller.saleState.value == 1 && cartItem.product.sale_price != null){
                                  return RichText(
                                    text: TextSpan(
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          color: deepGrey,
                                        ),
                                        children: [
                                          TextSpan(
                                              text: '${double.parse(cartItem.product.regular_price)}',
                                              style: TextStyle(
                                                fontSize: 10,
                                                decoration: TextDecoration.lineThrough,
                                              )
                                          ),
                                          TextSpan(
                                              text: '${double.parse(cartItem.product.sale_price!)}',
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
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          color: deepGrey,
                                        ),
                                        children: [
                                          TextSpan(
                                              text: '${double.parse(cartItem.product.regular_price)}',
                                              style: TextStyle(
                                                fontSize: 16,
                                              )
                                          ),
                                          TextSpan(
                                              text: ' CHF',
                                              style: TextStyle(
                                                fontSize: 10,
                                              )
                                          ),
                                        ]),
                                  );
                                }
                              }),
                              SizedBox(height:4.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  cartItem.color != null? ColorOption(cartItem.color!) : SizedBox(),
                                  SizedBox(width: 2),
                                  cartItem.size != null? SizeOption(cartItem.size!) : SizedBox(),
                                ],
                              )
                            ],
                          ),
                        ),

                      ])),
            ),
            Positioned(
                top: 0,
                child: SizedBox(
                  height: 150,
                  width: 200,
                  child: Stack(children: <Widget>[
                    // Positioned(
                    //   left: 5,
                    //   top: 20,
                    //   child: SizedBox(
                    //       height: 120,
                    //       width: 120,
                    //       child: CachedNetworkImage(
                    //         imageUrl: "${imagepath}products/${cartItem.product.image}",
                    //         placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                    //         fit: BoxFit.contain,
                    //       )),
                    // ),
                    // Positioned(
                    //   left: 0,
                    //   top: 0,
                    //   child: Align(
                    //     child: IconButton(
                    //       icon: SvgPicture.asset('assets/icons/clear_icon.svg'),
                    //       onPressed: onRemove,
                    //     ),
                    //   ),
                    // ),
                    Positioned(
                      left: 95,
                      top: 20,
                      child: Container(
                          width: 30,
                          height: 30,
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 0.6),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Center(
                            child: Text(
                              '${cartItem.qty}',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          )
                      ),
                    )
                  ]),
                )),
          ],
        ),
      ),
    );
  }
}

class DraggableChild extends StatelessWidget {
  const DraggableChild({
    required this.cartItem,
  });

  final Cart cartItem;

  @override
  Widget build(BuildContext context) {
    return CartItemList(
        cartItem
    );
  }
}


class DraggableChildFeedback extends StatelessWidget {
  const DraggableChildFeedback({
    required this.cartItem,
  });

  final Cart cartItem;

  @override
  Widget build(BuildContext context) {

    return  Opacity(
      opacity: 0.7,
      child: CartItemList(
          cartItem
      ),
    );
  }
}


class DragTargetWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DragTargetWidgetState();
  }
}

class _DragTargetWidgetState extends State<DragTargetWidget>  {

  Color c = Colors.black;
  double size = 24;
  final CartController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DragTarget<Cart>(
      onWillAccept: (Cart) {
        setState(() {
          c = Colors.red;
          size = 40;
        });
        return true;
      },
      onAccept: (Cart) {
        controller.removeItemCart(Cart.rowId);
      },
      onLeave: (Cart) {
        setState(() {
          c = Colors.black;
          size = 24;
        });
      },
      builder: (context, incoming, rejected) {
        return GestureDetector(
          child: Icon(
            CupertinoIcons.delete,
            size: size, color: c,
          ),
          onTap: () {
            Get.dialog(
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Material(
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              const Text(
                                "Remove all items?",
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "For remove item drag and drop it into trash",
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              //Buttons
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      child: const Text(
                                        'NO',
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(0, 45),
                                        primary: grey,
                                        onPrimary: deepGrey,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      onPressed: () {
                                        Get.back();
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: ElevatedButton(
                                      child: const Text(
                                        'YES',
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(0, 45),
                                        primary: grey,
                                        onPrimary: deepGrey,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      onPressed: () {
                                        controller.clearCart();
                                        Get.back();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}