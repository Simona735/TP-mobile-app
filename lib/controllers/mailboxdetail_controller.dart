import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tp_mobile_app/firebase/database.dart';
import 'package:tp_mobile_app/models/settings.dart';

class MailboxDetailController extends GetxController {
  int listPercentage = 30;
  bool isDialogOpen = false;
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

  void updateNotifyNew(value) {
    _mailboxSettings.value.notif_new = value;
    _mailboxSettings.refresh();
    Database.updateNotificationsNewMail(mailboxId, value);
  }

  void updateNotifyEmpty(value) {
    _mailboxSettings.value.notif_empty = value;
    _mailboxSettings.refresh();
    Database.updateNotificationsEmpty(mailboxId, value);
  }

  void updateNotifyFull(value) {
    _mailboxSettings.value.notif_full = value;
    _mailboxSettings.refresh();
    Database.updateNotificationsFull(mailboxId, value);
  }

  void updateUCI(value) {
    if(!isDialogOpen){
      _mailboxSettings.value.UCI = value.round();
      _mailboxSettings.refresh();
      Database.updateControlsInterval(mailboxId, value.round());
    }
  }

  void updateUEC(value) {
    if(!isDialogOpen){
      _mailboxSettings.value.UEC = value.round();
      _mailboxSettings.refresh();
      Database.updateExtraControls(mailboxId, value.round());
    }
  }

  void updateUECI(value) {
    if(!isDialogOpen){
      _mailboxSettings.value.UECI = value.round();
      _mailboxSettings.refresh();
      Database.updateExtraControlsInterval(mailboxId, value.round());
    }
  }

  void updateUT(value) {
    if(!isDialogOpen){
      _mailboxSettings.value.UT = value;
      _mailboxSettings.refresh();
      Database.updateTolerance(mailboxId, value);
    }
  }

  void updateMailboxName() {
    _mailboxSettings.value.name = titleController.text;
    _mailboxSettings.refresh();
    Database.updateTitle(mailboxId, titleController.text);
  }

  void updateMailboxDetail(){
    if(!isDialogOpen){
      _mailboxFutureSettings.value = Database.getMailboxSettingsById(mailboxId);
    }
  }

  void updateMailbox(){
    _mailboxSettings.refresh();
  }
}
