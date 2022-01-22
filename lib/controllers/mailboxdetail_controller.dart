import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tp_mobile_app/firebase/database.dart';
import 'package:tp_mobile_app/models/settings.dart';

class MailboxDetailController extends GetxController {
  int listPercentage = 30;
  final titleController = TextEditingController();
  final mailboxId = Get.arguments['mailboxId'];
  final mailboxSettings = Settings.empty().obs;
  final mailboxFutureSettings = Future.value(Settings.empty()).obs;

  Settings get mailbox => mailboxSettings.value;
  Future<Settings> get futureMailbox => mailboxFutureSettings.value;

  @override
  void onInit() async {
    mailboxFutureSettings.value = Database.getMailboxSettingsById(mailboxId);
    super.onInit();
  }

  @override
  void onClose() {
    titleController.dispose();
    super.onClose();
  }

  void setData(data) {
    mailboxSettings.value = data;
  }

  void updateLimit(double value) {
    mailboxSettings.value.limit = value.round();
    mailboxSettings.refresh();
  }

  void updateLowPowerMode(value) {
    mailboxSettings.value.lowPower = value;
    mailboxSettings.refresh();
    Database.updateLowPower(mailboxId, value);
  }

  void updateMailboxName() {
    mailboxSettings.value.name = titleController.text;
    mailboxSettings.refresh();
    Database.updateTitle(mailboxId, titleController.text);
  }
}
