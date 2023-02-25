import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roussha_store/functions/store_auth_info.dart';
import 'package:roussha_store/services/api.dart';
import 'dart:io';
import '../../app_properties.dart';

class ProfileSettingsController extends GetxController {

  RxBool INFO_LOADING = false.obs;
  RxBool LOADING_UPDATE = false.obs;

  GlobalKey<FormState> profile_form_state = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController birthdate = TextEditingController();
  TextEditingController phone = TextEditingController();
  RxString image = "".obs;
  TextEditingController line1 = TextEditingController();
  TextEditingController line2 = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController province = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController zipcode = TextEditingController();
  late DateTime selectedDate;



  var select_image_path;
  var image_path;

  void pickImage() async{
    select_image_path = await ImagePicker().pickImage(source: ImageSource.gallery);
    image_path = File(select_image_path!.path);
    update();
  }


  getProfileInfo() async {
    INFO_LOADING(true);

    String? token = await getToken();
    await ApiData.myProfile(token!).then((value) => {
    initFormInfo(value)
    });

    INFO_LOADING(false);
  }

  initFormInfo(var value) async {
    String? username = await getUsername();
    if(value != null){
      name.text = username == null? 'name' : username;
      birthdate.text = value['date_of_birth'];
      phone.text = value['mobile'];
      image(value['image'] == null? "" : "${imagepath}profile/${value['image']}");
      line1.text = value['line1'];
      line2.text = value['line2'];
      country.text = value['country'];
      province.text = value['province'];
      city.text = value['city'];
      zipcode.text = value['zipcode'];
    }
    update();
  }

  Future<bool> updateMyProfile() async {

    LOADING_UPDATE(true);
    var form_data = profile_form_state.currentState;
    if(form_data!.validate()){
      bool done = false;

      String? token = await getToken();

      await ApiData.updateMyProfile(
          token: token!, name: name.text, date_of_birth: birthdate.text, city: city.text, country: country.text,
          line1: line1.text, line2: line2.text, mobile: phone.text, province: province.text, zipcode: zipcode.text,
          image_path: image_path
      ).then((value) => {
        if(value == 1)
          {
            done = true, LOADING_UPDATE(false)
          }
      });

      if(done){
        return true;
      }else{
        return false;
      }

    }else{
      LOADING_UPDATE(false);
      return false;
    }
  }



  Future<void> selectDate(BuildContext context) async {
    selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950, 1),
        lastDate: DateTime(2050));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      birthdate.text = '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
      print('${selectedDate.year}-${selectedDate.month}-${selectedDate.day}');
    }
  }

  @override
  void onInit() async {

    String? username = await getUsername();
    name.text = username?? 'name';

    image_path = null;

    getProfileInfo();
    super.onInit();
  }

}