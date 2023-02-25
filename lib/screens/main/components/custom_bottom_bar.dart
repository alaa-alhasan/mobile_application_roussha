import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roussha_store/app_properties.dart';
import 'package:get/get.dart';
import 'package:roussha_store/functions/store_auth_info.dart';
import 'package:roussha_store/screens/auth/welcome_back_page.dart';

class CustomBottomBar extends StatefulWidget {
  final TabController controller;

  const CustomBottomBar({
    required this.controller,
  });

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();

}

class _CustomBottomBarState extends State<CustomBottomBar> {

  int icon_selected = 0;

  @override
  Widget build(BuildContext context) {

    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Column(
              children: [
                SvgPicture.asset('assets/icons/home.svg',
                  height: icon_selected == 0 ? 20 : 25,
                  color: icon_selected == 0 ? deepGrey : grey,
                ),
                icon_selected == 0 ? Text('Home',style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold),) : SizedBox()
              ]
            ),
            onPressed: () {
              widget.controller.animateTo(0);
              setState(() {
                icon_selected = 0;
              });
            }
          ),
          IconButton(
            icon: Column(
              children: [
                SvgPicture.asset('assets/icons/filter.svg',
                    height: icon_selected == 1 ? 20 : 25,
                    color: icon_selected == 1 ? deepGrey : grey
                ),
                icon_selected == 1 ? Text('Filter',style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold),) : SizedBox()
              ],
            ),
            onPressed: () {
              widget.controller.animateTo(1);
              setState(() {
                icon_selected = 1;
              });
            },
          ),
          IconButton(
            icon: Column(
              children: [
                SvgPicture.asset('assets/icons/cart.svg',
                    height: icon_selected == 2 ? 20 : 25,
                    color: icon_selected == 2 ? deepGrey : grey
                ),
                icon_selected == 2 ? Text('Cart',style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold),) : SizedBox()
              ],
            ),
            onPressed: () async {
              await isLogin().then((value) => {
                if(value == true){
                  widget.controller.animateTo(2),
                  setState(() {
                    icon_selected = 2;
                  })
                }else{
                  Get.to(() => WelcomeBackPage())
                }
              });
            },
          ),
          IconButton(
            icon: Column(
              children: [
                SvgPicture.asset('assets/icons/user.svg',
                    height: icon_selected == 3 ? 20 : 25,
                    color: icon_selected == 3 ? deepGrey : grey
                ),
                icon_selected == 3 ? Text('Profile',style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold),) : SizedBox()
              ],
            ),
            onPressed: () async {
              await isLogin().then((value) => {
                if(value == true){
                  widget.controller.animateTo(3),
                  setState(() {
                    icon_selected = 3;
                  })
                }else{
                  Get.to(() => WelcomeBackPage())
                }
              });
            },
          )
        ],
      ),
    );
  }
}
