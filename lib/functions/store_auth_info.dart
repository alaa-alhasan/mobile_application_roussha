

import 'package:roussha_store/models/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

// login
// token
// email
// username
// userid
// authStatus
// authMessage


//==================== get data from local storage ==============//

Future<bool?> isLogin() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getBool("login");
}

Future<String?> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString("token");
}

Future<String?> getEmail() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString("email");
}

Future<String?> getUsername() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString("username");
}

Future<int?> getUserId() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt("userid");
}

Future<int?> getAuthStatus() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt("authStatus");
}

Future<String?> getAuthMessage() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString("authMessage");
}

Future<Auth?> getAuthData() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  if(pref.getBool("login")!){
    return Auth(status: pref.getInt("authStatus")!,
        user_id: pref.getInt("userid")!,
        token: pref.getString("token")!,
        message: pref.getString("authMessage")!);
  }else {
    return Auth(status: -1, user_id: -1, token: "", message: "");
  }
}


//==================== Store data in  local storage ==============//


setLogin(bool b) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setBool("login", b);
}

setToken(String token) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString("token", token);
}

setEmail(String email) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString("email", email);
}

setUsername(String username) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString("username", username);
}

setUserId(int uid) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setInt("userid", uid);
}

setAuthStatus(String status) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString("authStatus", status);
}

setAuthMessage(String message) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString("authMessage", message);
}

setAuthData(int status, int uid, String token, String message) async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  pref.setInt("authStatus",status);
  pref.setInt("userid", uid);
  pref.setString("token", token);
  pref.setString("authMessage", message);

}



//========================= clear some or all data ================================//

clearData() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.clear();
}

clearDataItem(String key) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.remove(key);
}