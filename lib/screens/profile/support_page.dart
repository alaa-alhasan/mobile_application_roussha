import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roussha_store/controllers/support_controller.dart';
import 'package:roussha_store/functions/check_internet.dart';
import 'package:roussha_store/functions/input_validation.dart';
import '../../app_properties.dart';
import '../../custom_background.dart';

class SupportPage extends StatelessWidget {

  final SupportController controller = Get.put(SupportController());

  @override
  Widget build(BuildContext context) {


    InputDecoration setDecoration(String label){
      return InputDecoration(
        labelText: label,
        contentPadding: EdgeInsets.fromLTRB(10, 2, 0, 2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      );
    }

    Widget sendButton = InkWell(
      onTap:() async {
        await CheckInternet().then((value) => {
         if(value == true){

           controller.sendMessage().then((value) => {
             if(value == true){
               Get.snackbar('Roussha', 'Your message has been sent successfully!',
                   margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                   icon: Icon(Icons.check)
               ),
               Navigator.of(context).pop()
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
        height: 80,
        margin: EdgeInsets.only(top: 25),
        width: MediaQuery.of(context).size.width / 1.5,
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
        child: Center(
            child: Obx((){
              if(controller.SENDING.value){
                return CircularProgressIndicator();
              }else{
                return Text("Send",
                    style: const TextStyle(
                        color: const Color(0xfffefefe),
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        fontSize: 20.0)
                );
              }
            })
        ),
      ),
    );

    Widget contactForm = Form(
        key: controller.support_form_state,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 200,
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: TextFormField(
                keyboardType: TextInputType.name,
                controller: controller.name,
                validator: (value) {
                  return validateInput(value!, 2, 20, "");
                },
                decoration: setDecoration('name'),
              ),
            ),
            Container(
              width: 200,
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: setDecoration('email'),
                controller: controller.email,
                validator: (value) {
                  return validateInput(value!, 8, 30, "email");
                },
              ),
            ),
            Container(
              width: 200,
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                controller: controller.phone,
                validator: (value) {
                  return validateInput(value!, 8, 15, "phone");
                },
                decoration: setDecoration('phone'),
              ),
            ),
            Container(
              width: 300,
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: controller.comment,
                minLines: 1,
                maxLines: 10,
                decoration: setDecoration('comment'),
                validator: (value) {
                  return validateInput(value!, 1, 500, "");
                },
              ),
            ),
          ],
        )
    );


    return CustomPaint(
      painter: MainBackground(),
      child: Scaffold(
          body: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, top: kToolbarHeight,bottom: kToolbarHeight),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        color: darkGrey,
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Container(
                        child: Image.asset('assets/logo.png', height: 200,),
                      ),
                      Divider(),
                      Container(
                        decoration: BoxDecoration(color: Color.fromRGBO(245, 245, 245, 0.8),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.16),
                                offset: Offset(0, 5),
                                blurRadius: 10.0,
                              )
                            ],
                            borderRadius: BorderRadius.circular(9.0)),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                              child: Row(
                                children: [
                                  Text('Hotline: ', style: TextStyle(color: darkGrey,fontSize: 22, fontWeight: FontWeight.bold),),
                                  Text('(+41) 765 469 979', style: TextStyle(color: deepGrey,fontSize: 22, fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                              child: Row(
                                children: [
                                  Text('Website: ', style: TextStyle(color: darkGrey,fontSize: 22, fontWeight: FontWeight.bold),),
                                  Text('roussha.com', style: TextStyle(color: deepGrey,fontSize: 22, fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                              child: Row(
                                children: [
                                  Text('Email: ', style: TextStyle(color: darkGrey,fontSize: 22, fontWeight: FontWeight.bold),),
                                  Text('info@roussha.com', style: TextStyle(color: deepGrey,fontSize: 22, fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                        child: Text('LEAVE A MESSAGE', style: TextStyle(color: darkGrey,fontSize: 18),),
                      ),
                      contactForm,
                      Center(child: sendButton)
                    ],
                  )
              )
          )
      ),
    );
  }
}
