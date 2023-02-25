import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:roussha_store/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:roussha_store/functions/alert_exit_app.dart';
import '../main/main_page.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  PageController controller = PageController();
  int pageIndex = 0;


  @override
  Widget build(BuildContext context) {

    return Material(
      child: WillPopScope(
        onWillPop: alertExitApp,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[100],
              image: DecorationImage(image: AssetImage('assets/background.png'))),
          child: Stack(
            children: <Widget>[
              PageView(
                onPageChanged: (value) {
                  setState(() {
                    pageIndex = value;
                  });
                },
                controller: controller,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Lottie.asset('assets/online_shopping.json',height: 200, width: 200)
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          'Get your style online',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16.0),
                        child: Text(
                          'Welcome to our store! you make us happy by using our application, you can browse and get Clothes, Shoes, Accessories and Collection within few clicks.',
                          style: TextStyle(color: darkGrey, fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Lottie.asset('assets/shopping_cart.json',height: 200, width: 200)
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          'Fill your basket ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16.0),
                        child: Text(
                          'We are sure that our products will appeal to you, so fill your basket and choose the products that you like, sort them according to their specifications.',
                          style: TextStyle(color: Colors.grey, fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Lottie.asset('assets/payments.json',height: 300, width: 300)
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          'Save payment',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16.0),
                        child: Text(
                          'You can make payments in a very easy and secure way using your credit card\nDo not be afraid of anything, we work with the best electronic payment gateways.',
                          style: TextStyle(color: Colors.grey, fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                bottom: 16.0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(8.0),
                            height: 12,
                            width: 12,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black, width: 2),
                                color: pageIndex == 0 ? grey : Colors.white),
                          ),
                          Container(
                            margin: EdgeInsets.all(8.0),
                            height: 12,
                            width: 12,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black, width: 2),
                                color: pageIndex == 1 ? grey : Colors.white),
                          ),
                          Container(
                            margin: EdgeInsets.all(8.0),
                            height: 12,
                            width: 12,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black, width: 2),
                                color: pageIndex == 2 ? grey : Colors.white),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Opacity(
                            opacity: pageIndex != 2 ? 1.0 : 0.0,
                            child: RawMaterialButton(
                              splashColor: Colors.transparent,
                              child: Text(
                                'SKIP',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => MainPage()));
                              },
                            ),
                          ),
                          pageIndex != 2
                              ? RawMaterialButton(
                                  splashColor: Colors.transparent,
                                  child: Text(
                                    'NEXT',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onPressed: () {
                                    if (!(controller.page == 2.0))
                                      controller.nextPage(
                                          duration: Duration(milliseconds: 200),
                                          curve: Curves.linear);
                                  },
                                )
                              : RawMaterialButton(
                                  splashColor: Colors.transparent,
                                  child: Text(
                                    'SHOP',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => MainPage()));
                                  },
                                )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
