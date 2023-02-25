
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:roussha_store/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:roussha_store/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:roussha_store/functions/check_internet.dart';
import 'package:roussha_store/functions/input_validation.dart';
import 'package:roussha_store/screens/auth/register_page.dart';
import 'package:roussha_store/screens/main/main_page.dart';

class WelcomeBackPage extends StatelessWidget {

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {

    Widget welcomeBack = SizedBox(
      child: Obx((){
        return Column(
          children: [
            Container(
              alignment: Alignment(-1,0),
              child: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText('Welcome Back,',textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 34.0,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.15),
                          offset: Offset(0, 5),
                          blurRadius: 10.0,
                        )
                      ])),
                ],
                // pause: const Duration(seconds: 2),
              ),
            ),
            controller.last_username != ""?
            Container(
              alignment: Alignment(-1,0),
              child: Text(
                controller.last_username.value,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 34.0,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.15),
                        offset: Offset(0, 5),
                        blurRadius: 10.0,
                      )
                    ]),

            ),
            )
                : SizedBox(),
          ],
        );
      }),
    );

    Widget subTitle = Padding(
        padding: const EdgeInsets.only(right: 56.0),
        child: Text(
          'Login to your account using\nYour Email',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ));

    Widget loginButton = Positioned(
      left: MediaQuery.of(context).size.width / 4,
      bottom: 30,
      child: InkWell(
        onTap: () async {

          await CheckInternet().then((value) => {
            if(value == true){

              controller.login().then((value) => {
                if(value == true){
                  Get.off(() => MainPage())
                }
              })

            }else{

              Get.snackbar('Roussha', 'Sorry, You are offline!!',
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  icon: Icon(Icons.wifi_off_outlined)
              )

            }
          });

        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 60,
          child: Center(
              child: Obx((){
                if(controller.LOADING_AUTH.value){
                  return CircularProgressIndicator();
                }else{
                  return Text("Login",
                      style: const TextStyle(
                          color: const Color(0xfffefefe),
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          fontSize: 20.0)
                  );
                }
              })
          ),
          decoration: BoxDecoration(
              gradient: mainButton,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                  offset: Offset(0, 5),
                  blurRadius: 10.0,
                )
              ],
              borderRadius: BorderRadius.circular(9.0)),
        ),
      ),
    );

    Widget loginForm = Form(
      key: controller.login_form_state,
      child: Container(
        height: 240,
        child: Stack(
          children: <Widget>[
            Container(
              height: 160,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 32.0, right: 12.0),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.8),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextFormField(
                      controller: controller.email,
                      validator: (value) {
                        return validateInput(value!, 5, 40, "email");
                      },
                      style: TextStyle(fontSize: 16.0),
                      decoration: InputDecoration(hintText: 'example@email.com'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextFormField(
                      controller: controller.password,
                      validator: (value) {
                        return validateInput(value!, 8, 50, "password");
                      },
                      style: TextStyle(fontSize: 16.0),
                      decoration: InputDecoration(hintText: '********'),
                      obscureText: true,
                    ),
                  ),
                ],
              ),
            ),
            loginButton,
          ],
        ),
      )
    );

    Widget signup = Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Don't Have Account?  ",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Color.fromRGBO(255, 255, 255, 0.5),
              fontSize: 14.0,
            ),
          ),
          InkWell(
            onTap: () {
              Get.off(() => RegisterPage());
            },
            child: Text(
              'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(

      body: Stack(
        children: <Widget>[

          Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/main_background_image.png'),
                    fit: BoxFit.cover)
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(127, 127, 127, 0.6),

            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.only(left: 28.0,top: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  welcomeBack,
                  subTitle,
                  Obx((){
                    return Center(
                      child: Text(
                        controller.responseMessage.value == 'Login Success'? '' : '${controller.responseMessage.value}',
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                    );
                  }),
                  loginForm,
                  signup
                ],
              ),
            ),
          ),

          Positioned(
            top: 35,
            left: 5,
            child: IconButton(
              color: Colors.white,
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Get.back();
              },
            ),
          )
        ],
      ),
    );
  }
}
