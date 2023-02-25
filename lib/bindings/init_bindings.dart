import 'package:get/get.dart';
import 'package:roussha_store/controllers/home_controller.dart';

class InitialBindings implements Bindings{

  @override
  void dependencies() {
    Get.put(HomeController(), permanent: true);
  }

}