import 'package:get/get.dart';

class RegistrationController extends GetxController {
  final showPassword = false.obs;
  final showRepeatPassword = false.obs;

  @override
  void onInit() {
    showPassword.value = false;
    showRepeatPassword.value = false;
    super.onInit();
  }
}
