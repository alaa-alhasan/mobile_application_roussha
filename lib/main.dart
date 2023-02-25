import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:roussha_store/bindings/init_bindings.dart';
import 'package:roussha_store/screens/intro/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharepref;  // not used

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharepref = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Roussha',
      debugShowCheckedModeBanner: true,
      initialRoute: "/splashScreen",
      initialBinding: InitialBindings(),
      theme: ThemeData(
        brightness: Brightness.light,
        canvasColor: Colors.transparent,
        primarySwatch: Colors.grey,
        fontFamily: "Montserrat",
      ),
      getPages: [
        GetPage(name: "/splashScreen", page: () => SplashScreen()),
      ],
    );
  }
}