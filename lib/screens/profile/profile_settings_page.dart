import 'dart:ui';
import 'package:get/get.dart';
import 'package:roussha_store/controllers/profile_settings_controller.dart';
import 'package:roussha_store/functions/check_internet.dart';
import 'package:roussha_store/functions/input_validation.dart';
import '../../app_properties.dart';
import 'package:flutter/material.dart';
import '../../custom_background.dart';


class ProfileSettingsPage extends StatelessWidget {

  final ProfileSettingsController controller = Get.put(ProfileSettingsController());


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

    Widget saveButton = InkWell(
      onTap:() async {

        await CheckInternet().then((value) => {
          if(value == true){

            controller.updateMyProfile().then((value) => {
              if(value == true){
                Get.snackbar('Roussha', 'Your information has been saved successfully!',
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
              if(controller.LOADING_UPDATE.value){
                return CircularProgressIndicator();
              }else{
                return Text("Save",
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

    return CustomPaint(
      painter: MainBackground(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: darkGrey),
          title: Text(
            'Profile Settings',
            style: const TextStyle(
                color: darkGrey,
                fontWeight: FontWeight.w500,
                fontFamily: "Montserrat",
                fontSize: 18.0),
          ),
        ),
        body: LayoutBuilder(
          builder: (_, viewportConstraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
              BoxConstraints(minHeight: viewportConstraints.maxHeight),
              child: Container(
                padding: EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    bottom: MediaQuery.of(context).padding.bottom == 0
                        ? 20
                        : MediaQuery.of(context).padding.bottom),
                child: Form(
                  key: controller.profile_form_state,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        alignment: const Alignment(1,0),
                        child: InkWell(
                          onTap: (){
                            controller.pickImage();
                          },
                          child: GetBuilder<ProfileSettingsController>(
                            builder: (controller){
                              if(controller.image_path != null){
                                return CircleAvatar(
                                    maxRadius: 45,
                                    backgroundImage: FileImage(controller.image_path)
                                );
                              }
                              else if(controller.image.value != ""){
                                return CircleAvatar(
                                  maxRadius: 45,
                                  backgroundImage: NetworkImage('${controller.image.value}'),
                                );
                              }else {
                                return CircleAvatar(
                                    maxRadius: 45,
                                    backgroundImage: AssetImage('assets/avatar.jpg')
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      Container(
                          alignment: const Alignment(-1,0),
                          child: Container(
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
                          )
                      ),
                      Container(
                          alignment: const Alignment(-1,0),
                          child: Container(
                            width: 200,
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                              controller: controller.birthdate,
                              decoration: setDecoration('birthdate'),
                              onTap: () => controller.selectDate(context),
                              readOnly: true,
                              validator: (value) {
                                return validateInput(value!, 4, 20, "");
                              },
                            ),
                          )
                      ),
                      Container(
                          alignment: const Alignment(-1,0),
                          child: Container(
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
                          )
                      ),
                      Container(
                          alignment: const Alignment(-1,0),
                          child: Container(
                            width: 200,
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: controller.line1,
                              validator: (value) {
                                return validateInput(value!, 5, 30, "");
                              },
                              decoration: setDecoration('line1'),
                            ),
                          )
                      ),
                      Container(
                          alignment: const Alignment(-1,0),
                          child: Container(
                            width: 200,
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: controller.line2,
                              validator: (value) {
                                return validateInput(value!, 5, 30, "");
                              },
                              decoration: setDecoration('line2'),
                            ),
                          )
                      ),
                      Container(
                          alignment: const Alignment(-1,0),
                          child: Container(
                            width: 200,
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: controller.country,
                              validator: (value) {
                                return validateInput(value!, 2, 30, "");
                              },
                              decoration: setDecoration('country'),
                            ),
                          )
                      ),
                      Container(
                          alignment: const Alignment(-1,0),
                          child: Container(
                            width: 200,
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: controller.province,
                              validator: (value) {
                                return validateInput(value!, 2, 30, "");
                              },
                              decoration: setDecoration('province'),
                            ),
                          )
                      ),
                      Container(
                          alignment: const Alignment(-1,0),
                          child: Container(
                            width: 200,
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: controller.city,
                              validator: (value) {
                                return validateInput(value!, 2, 30, "");
                              },
                              decoration: setDecoration('city'),
                            ),
                          )
                      ),
                      Container(
                          alignment: const Alignment(-1,0),
                          child: Container(
                            width: 200,
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: controller.zipcode,
                              validator: (value) {
                                return validateInput(value!, 2, 10, "");
                              },
                              decoration: setDecoration('zipcode'),
                            ),
                          )
                      ),
                      Center(child: saveButton)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


}
