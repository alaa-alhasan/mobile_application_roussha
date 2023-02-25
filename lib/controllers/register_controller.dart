import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:roussha_store/functions/check_internet.dart';
import 'package:roussha_store/functions/store_auth_info.dart';
import 'package:roussha_store/models/auth.dart';
import 'package:roussha_store/services/api.dart';

class RegisterController extends GetxController {


  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController cmfPassword;

  RxString responseMessage = "".obs;
  RxBool LOADING_AUTH = false.obs;

  GlobalKey<FormState> register_form_state = GlobalKey<FormState>();

  late Auth auth;

  Future<bool> register() async {
    LOADING_AUTH(true);
    responseMessage("");
    var form_data = register_form_state.currentState;
    if(form_data!.validate()){

      await ApiData.register(username.text, email.text, password.text).then((value) => {
        auth = value
      });

      responseMessage(auth.message);
      if(auth.status == 1){
        storeUserDate();
        LOADING_AUTH(false);
        return true;
      }else{
        LOADING_AUTH(false);
        return false;
      }

    }else{
      LOADING_AUTH(false);
      return false;
    }
  }

  storeUserDate() async {

    clearData();

    await setLogin(true);
    await setEmail(email.text);
    await setUsername(username.text);
    await setAuthData(auth.status, auth.user_id, auth.token, auth.message);
  }


  @override
  void onInit() {
    username = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    cmfPassword = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

}