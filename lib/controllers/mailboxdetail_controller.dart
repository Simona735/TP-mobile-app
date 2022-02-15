import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tp_mobile_app/firebase/database.dart';
import 'package:tp_mobile_app/models/settings.dart';

class MailboxDetailController extends GetxController {
  int listPercentage = 30;
  final titleController = TextEditingController();
  final mailboxId = Get.arguments['mailboxId'];
  final _mailboxSettings = Settings.empty().obs;
  final _mailboxFutureSettings = Future.value(Settings.empty()).obs;

  Settings get mailbox => _mailboxSettings.value;
  Future<Settings> get futureMailbox => _mailboxFutureSettings.value;

  @override
  void onInit() async {
    _mailboxFutureSettings.value = Database.getMailboxSettingsById(mailboxId);
    super.onInit();
  }

  @override
  void onClose() {
    titleController.dispose();
    super.onClose();
  }

  void setData(data) {
    _mailboxSettings.value = data;
  }

  // void updateLimit(double value) {
  //   _mailboxSettings.value.limit = value.round();
  //   _mailboxSettings.refresh();
  // }

  void updateLowPowerMode(value) {
    _mailboxSettings.value.lowPower = value;
    _mailboxSettings.refresh();
    Database.updateLowPower(mailboxId, value);
  }

  void updateMailboxName() {
    _mailboxSettings.value.name = titleController.text;
    _mailboxSettings.refresh();
    Database.updateTitle(mailboxId, titleController.text);
  }

  void updateMailboxDetail(){
    _mailboxFutureSettings.value = Database.getMailboxSettingsById(mailboxId);
  }
}
