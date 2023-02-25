
import 'package:get/get.dart';

validateInput(String value, int min, int max, String type) {

  switch(type) {

    case "username": {
      if(!GetUtils.isUsername(value)) return "Invalid Username!";
    } break;

    case "email": {
      if(!GetUtils.isEmail(value)) return "Invalid Email!";
    } break;

    case "phone": {
      if(!GetUtils.isPhoneNumber(value)) return "Invalid Phone Number!";
    } break;

    case "number": {
      if(!GetUtils.isNum(value)) return "Invalid Number!";
    } break;

    default: {
      //statements;
    }
    break;
  }


  if(value.length < min) return "Can't be less than ${min}!";
  if(value.length > max) return "Can't be more than ${max}!";

  if(value.isEmpty) return "Can't be empty!";

}