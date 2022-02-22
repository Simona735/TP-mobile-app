import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PasswordChangeController extends GetxController{

  final oldPasswordController = TextEditingController();
  final newPassword1Controller = TextEditingController();
  final newPassword2Controller = TextEditingController();

  final showOldPassword = false.obs;
  final showPassword1Password = false.obs;
  final showPassword2Password = false.obs;

  @override
  void onInit() {
    showOldPassword.value = false;
    showPassword1Password.value = false;
    showPassword2Password.value = false;
    super.onInit();
  }

  @override
  void onClose() {
    oldPasswordController.dispose();
    newPassword1Controller.dispose();
    newPassword2Controller.dispose();
    super.onClose();
  }
}
