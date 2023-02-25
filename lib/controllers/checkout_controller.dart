import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:roussha_store/functions/store_auth_info.dart';
import 'package:roussha_store/services/api.dart';

class CheckoutController extends GetxController {


  late TextEditingController firstname,lastname,email,phone,line1,line2,country,province,city,zipcode;
  late TextEditingController firstname_diff,lastname_diff,email_diff,phone_diff,line1_diff,line2_diff,country_diff,province_diff,city_diff,zipcode_diff;

  late TextEditingController couponCode;

  late TextEditingController cardNumber, cardMonth, cardYear, cardCVC;


  RxBool coupon = false.obs;
  RxBool shippingDiff = false.obs;

  RxBool SENDING = false.obs;

  late List<String> cart_summary = <String>[].obs;
  RxBool SUMMARY_CART_LOADING = false.obs;

  RxBool coupon_accepted = false.obs;
  RxBool APPLYING_COUPON = false.obs;
  late List<dynamic> cart_summary_after_coupon = <dynamic>[].obs;

  RxString couponMessage = "".obs;
  RxString discount = "".obs;
  RxString subtotal = "".obs;
  RxString tax = "".obs;
  RxString total = "".obs;

  RxInt place_order_result_code = 0.obs;
  RxString place_order_result_message = "".obs;


  GlobalKey<FormState> checkout_form_state = GlobalKey<FormState>();
  GlobalKey<FormState> checkout_diff_form_state = GlobalKey<FormState>();
  GlobalKey<FormState> credit_card_form_state = GlobalKey<FormState>();

  RxBool INFO_LOADING = false.obs;

  cartSummary() async {
    SUMMARY_CART_LOADING(true);
    cart_summary.clear();
    String? token = await getToken();

    await ApiData.cartSummary(token!).then((value) => {
      if(value.isNotEmpty){
        cart_summary.addAll(value),
        SUMMARY_CART_LOADING(false),
        calculateSummary()
      }
    });
    SUMMARY_CART_LOADING(false);
  }

  applyCoupon(String code) async {

    APPLYING_COUPON(true);
    cart_summary_after_coupon.clear();
    coupon_accepted(false);
    String? token = await getToken();

    await ApiData.applyCoupon(token!, code).then((value) => {
      if(value.isNotEmpty){
        cart_summary_after_coupon.addAll(value),
        APPLYING_COUPON(false),
        couponMessage(cart_summary_after_coupon[0]),
        if(cart_summary_after_coupon.length > 1){
          coupon_accepted(true)
        },
        calculateSummary()
      }
    });

    APPLYING_COUPON(false);

  }

  resetCoupon(){
    coupon_accepted(false);
    couponCode.text = "";
    couponMessage("");
    calculateSummary();
  }

  calculateSummary(){
    if(coupon_accepted.isTrue){
      discount('${cart_summary_after_coupon[1]}');
      subtotal('${cart_summary_after_coupon[2]}');
      tax('${cart_summary_after_coupon[3]}');
      total('${cart_summary_after_coupon[4]}');
    }else{
      discount("0");
      subtotal(cart_summary[0]);
      tax(cart_summary[1]);
      total(cart_summary[2]);
    }
  }

  Future<bool> placeOrder() async {

    SENDING(true);
    place_order_result_code(0);
    place_order_result_message("");

    var form_main = checkout_form_state.currentState;
    var form_diff = checkout_diff_form_state.currentState;
    var form_card = credit_card_form_state.currentState;

    bool validating = form_main!.validate() && form_card!.validate();
    if(shippingDiff.isTrue){
      validating = validating && form_diff!.validate();
    }

    if(validating){

      String? token = await getToken();


      await ApiData.placeOrder(

          token: token!,

          subtotal: subtotal.value, discount: discount.value, tax: tax.value, total: total.value,
          firstname: firstname.text, lastname: lastname.text, email: email.text, mobile: phone.text,
          line1: line1.text, line2: line2.text, city: city.text, province: province.text, country: country.text, zipcode: zipcode.text,

          is_shipping_different: shippingDiff.isTrue? 1 : 0 ,

          s_firstname: firstname_diff.text, s_lastname: lastname_diff.text, s_email: email_diff.text, s_mobile: phone_diff.text,
          s_line1: line1_diff.text, s_line2: line2_diff.text, s_city: city_diff.text, s_province: province_diff.text,
          s_country: country_diff.text, s_zipcode: zipcode_diff.text,

          number: cardNumber.text, exp_month: cardMonth.text, exp_year: cardYear.text, cvc: cardCVC.text

      ).then((value) => {
        place_order_result_code(value[0]),
        place_order_result_message(value[1]),
        SENDING(false)
      });

      SENDING(false);
      return true;
    }else{

      SENDING(false);
      return false;
    }


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

    String? e_mail = await getEmail();
    if(value != null){
      email.text = e_mail!;
      phone.text = value['mobile'];
      line1.text = value['line1'];
      line2.text = value['line2'];
      country.text = value['country'];
      province.text = value['province'];
      city.text = value['city'];
      zipcode.text = value['zipcode'];
    }
    update();
  }


  @override
  void onInit() async {

    firstname = TextEditingController();
    lastname = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    line1 = TextEditingController();
    line2 = TextEditingController();
    country = TextEditingController();
    province = TextEditingController();
    city = TextEditingController();
    zipcode = TextEditingController();

    couponCode = TextEditingController();

    firstname_diff = TextEditingController();
    lastname_diff = TextEditingController();
    email_diff = TextEditingController();
    phone_diff = TextEditingController();
    line1_diff = TextEditingController();
    line2_diff = TextEditingController();
    country_diff = TextEditingController();
    province_diff = TextEditingController();
    city_diff = TextEditingController();
    zipcode_diff = TextEditingController();

    cardNumber = TextEditingController();
    cardMonth = TextEditingController();
    cardYear = TextEditingController();
    cardCVC = TextEditingController();


    cart_summary_after_coupon.clear();
    coupon_accepted(false);
    couponMessage("");

    cartSummary();
    getProfileInfo();

    super.onInit();
  }
}