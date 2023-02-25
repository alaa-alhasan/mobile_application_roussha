import 'package:flutter_svg/svg.dart';
import 'package:roussha_store/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:roussha_store/controllers/profile_controller.dart';
import 'package:roussha_store/functions/check_internet.dart';
import 'package:roussha_store/screens/main/main_page.dart';
import 'package:roussha_store/screens/orders/user_orders.dart';
import 'package:roussha_store/screens/profile/return_exchange_page.dart';
import 'package:roussha_store/screens/profile/support_page.dart';
import 'profile_settings_page.dart';
import 'package:roussha_store/screens/wishlist/wishlist_page.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController controller = Get.put(ProfileController());

  @override
  void initState() {
    controller.initController();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding:
            EdgeInsets.only(left: 16.0, right: 16.0, top: kToolbarHeight),
            child: Column(
              children: <Widget>[
                Obx(() {
                  if(controller.image.value == ""){
                    return CircleAvatar(
                      maxRadius: 48,
                      backgroundImage: AssetImage('assets/avatar.jpg'),
                    );
                  }else{
                    return CircleAvatar(
                      maxRadius: 48,
                      backgroundImage: NetworkImage('${imagepath}profile/${controller.image.value}'),
                    );
                  }
                }),
                Obx(() {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      controller.username.value,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                }),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: transparentGrey,
                            blurRadius: 4,
                            spreadRadius: 1,
                            offset: Offset(0, 1))
                      ]),
                  height: 150,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.favorite, size: 30, color: darkGrey),
                              onPressed:(){
                                Get.to(() => WishlistPage());
                              },
                            ),
                            Text(
                              'Wishlist',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.local_shipping, size: 30, color: darkGrey),
                              onPressed: () {
                                Get.to(() => MyOrders());
                              },
                            ),
                            Text(
                              'Orders',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.support, size: 30, color: darkGrey),
                              onPressed: () {
                                Get.to(() => SupportPage());
                              },
                            ),
                            Text(
                              'Support',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Settings'),
                  subtitle: Text('Change Account Settings'),
                  leading: SvgPicture.asset('assets/icons/user_settings.svg',width: 40,),
                  trailing: Icon(Icons.chevron_right, color: Colors.grey[500]),
                  onTap: () {
                    Get.to(() => ProfileSettingsPage());
                  },
                ),
                Divider(),
                ListTile(
                  title: Text('Returns & Exchanges'),
                  subtitle: Text('Privacy Policy'),
                  leading: SvgPicture.asset('assets/icons/info.svg',width:35),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Colors.grey[500],
                  ),
                  onTap: () {
                    Get.to(() => ReturnExchange());
                  },
                ),
                Divider(),
                Obx(() {
                  return ListTile(
                    title: const Text('Logout'),
                    leading: SvgPicture.asset('assets/icons/logout.svg',width:40),
                    trailing: controller.LOGOUT_LOADING.value == true? CircularProgressIndicator() : SizedBox(),
                    onTap: () async {

                      await CheckInternet().then((value) => {
                        if(value == true){


                          controller.logout().then((value) => {
                            if(value == true){
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => MainPage()))
                            }
                          })

                        }else{

                          Get.snackbar('Roussha', 'Sorry, You are offline!!',
                              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                              icon: Icon(Icons.wifi_off_outlined)
                          )

                        }
                      });

                    }
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
