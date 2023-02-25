import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:roussha_store/functions/check_internet.dart';
import 'package:roussha_store/functions/store_auth_info.dart';
import 'package:roussha_store/services/api.dart';

class SupportController extends GetxController {


  GlobalKey<FormState> support_form_state = GlobalKey<FormState>();

  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController comment;

  RxBool SENDING = false.obs;


  Future<bool> sendMessage() async {


    SENDING(true);
    var form_data = support_form_state.currentState;
    if(form_data!.validate()){
      bool done = false;

      String? token = await getToken();

      await ApiData.sendMessage(token!, name.text, email.text, phone.text, comment.text).then((value) => {
        if(value == 1)
          {
            done = true
          }
      });

      if(done){
        SENDING(false);
        return true;
      }else{
        SENDING(false);
        return false;
      }

    }else{
      SENDING(false);
      return false;
    }
  }


  @override
  void onInit() async {

   name = TextEditingController();
   email = TextEditingController();
   phone = TextEditingController();
   comment = TextEditingController();

   String? username = await getUsername();
   String? e_mail = await getEmail();

   name.text = username!;
   email.text = e_mail!;

    super.onInit();
  }

}