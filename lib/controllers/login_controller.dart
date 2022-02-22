import 'package:get/get.dart';

class LoginController extends GetxController {
  final showPassword = false.obs;

  @override
  void onInit() {
    showPassword.value = false;
    super.onInit();
  }
}
