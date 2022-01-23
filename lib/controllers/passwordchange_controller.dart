import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PasswordChangeController extends GetxController{

  final oldPasswordController = TextEditingController();
  final newPassword1Controller = TextEditingController();
  final newPassword2Controller = TextEditingController();

  @override
  void onClose() {
    oldPasswordController.dispose();
    newPassword1Controller.dispose();
    newPassword2Controller.dispose();
    super.onClose();
  }
}
