import 'dart:ffi';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:tp_mobile_app/models/mailbox.dart';
import 'package:tp_mobile_app/models/service.dart';
import 'package:tp_mobile_app/models/settings.dart';
import 'package:tp_mobile_app/widgets/notifications.dart';
import 'dart:developer' as developer;

import 'authentication.dart';

class Database {
  static final Map<String, Mailbox> _mailboxes = <String, Mailbox>{};

  static final DatabaseReference _messagesRef =
      FirebaseDatabase.instance.reference();

  static DatabaseReference get ref => _messagesRef;

  static void createUser() {
    _messagesRef.child(Authentication.getUserId ?? '').set({
      'mailbox_iter': 0,
    });
  }

  static Future<String> getMailboxIter() async {
    String data = '';
    await _messagesRef
        .child((Authentication.getUserId ?? '') + '/mailbox_iter')
        .once()
        .then((DataSnapshot snapshot) {
      data = snapshot.value.toString();
    });
    return data;
  }

  static Future<String> updateMailboxIter(String current) async {
    var num = int.parse(current) + 1;
    await _messagesRef.child(Authentication.getUserId ?? '').update({
      'mailbox_iter': num,
    });
    return num.toString();
  }

  static Future<String> createMailbox() async {
    String mailboxId = await getMailboxIter();
    mailboxId = await updateMailboxIter(mailboxId);
    await _messagesRef
        .child((Authentication.getUserId ?? '') +
            '/mailbox' +
            mailboxId +
            '/events/')
        .set({
      'NewMail': false,
      'EmptyBox': false,
      'FullBox': false,
      'FatalError': false,
      'LastMsgTime': ServerValue.timestamp,
    });
    await _messagesRef
        .child((Authentication.getUserId ?? '') +
            '/mailbox' +
            mailboxId +
            '/settings/')
        .set({
      'UCI': 7000000,
      'UEC': 4,
      'UECI': 500,
      'UT': 0.1,
      'reset': false,
      'low_power': true,
      'notif_empty': true,
      'notif_full': true,
      'notif_new': true,
      'name': 'Schránka ' + mailboxId,
    });
    listenToAllNotifications('mailbox' + mailboxId, 'Schránka ' + mailboxId);
    return 'mailbox' + mailboxId;
  }

  static void setReset(String mailboxId) {
    _messagesRef
        .child((Authentication.getUserId ?? '') + '/' + mailboxId + '/settings/')
        .update({
    //   _messagesRef.child(('user01') + '/' + mailboxId + '/settings/').update({
      'reset': true,
    });
    _mailboxes[mailboxId]!.settings.reset = true;
  }

  static Future<Map<String, Mailbox>> getMailboxes() async {
      await _messagesRef
          // .child(('user01') + '/')
          .child((Authentication.getUserId ?? '') + '/')
          .once()
          .then((DataSnapshot snapshot) {
      _mailboxes.clear();
      var data = snapshot.value ?? {};
      data.remove('mailbox_iter');
      if (data.length > 0) {
        for (var k in data.keys) {
          Settings settings =
              Settings.fromJson(Map<String, dynamic>.from(data[k]['settings']));
          Mailbox mailbox = Mailbox(settings);
          _mailboxes.addAll({k: mailbox});
        }
      }
    });
    return _mailboxes;
  }

  static Future<String> getTitleById(String mailboxId) async {
    String data = '';
      await _messagesRef
          // .child(('user01') + '/' + mailboxId + '/settings/name')
          .child((Authentication.getUserId ?? '') +
              '/' +
              mailboxId +
              '/settings/name')
          .once()
          .then((DataSnapshot snapshot) {
      data = snapshot.value.toString();
    });
    return _mailboxes[mailboxId]!.settings.name;
  }

  static Future<Map> getMailboxDetailById(String mailboxId) async {
    var data = {};
      await _messagesRef
          // .child(('user01') + '/' + mailboxId + '/settings/')
          .child((Authentication.getUserId ?? '') + '/' + mailboxId + '/settings/')
          .once()
          .then((DataSnapshot snapshot) {
      data = snapshot.value ?? {};
    });
    return data;
  }

  static Future<Settings> getMailboxSettingsById(String mailboxId) async {
    var data = Settings.empty();
      await _messagesRef
          // .child(('user01') + '/' + mailboxId + '/settings/')
          .child((Authentication.getUserId ?? '') + '/' + mailboxId + '/settings/')
          .once()
          .then((DataSnapshot snapshot) {
      data = Settings.fromJson(Map<String, dynamic>.from(snapshot.value));
    });
    return data;
  }

  static void updateLimit(String mailboxId, int limit) {
    // _messagesRef
    //     .child(
    //         (Authentication.getUserId ?? '') + '/' + mailboxId + '/settings/')
    //     .update({
      _messagesRef.child(('user01') + '/' + mailboxId + '/settings/').update({
      'limit': limit,
    });

    // Mailbox? mailbox = _mailboxes[mailboxId];
    // mailbox!.settings.limit = limit;
    // _mailboxes.update(mailboxId, (value) => mailbox);
  }

  static void updateLowPower(String mailboxId, bool value) {
    _messagesRef
        .child(
            (Authentication.getUserId ?? '') + '/' + mailboxId + '/settings/')
        .update({
      // _messagesRef.child(('user01') + '/' + mailboxId + '/settings/').update({
      'low_power': value,
    });

    // Mailbox? mailbox = _mailboxes[mailboxId];
    // mailbox!.settings.lowPower = value;
    // _mailboxes.update(mailboxId, (value) => mailbox);
  }

  static void updateTitle(String mailboxId, String title) {
    _messagesRef
        .child(
            (Authentication.getUserId ?? '') + '/' + mailboxId + '/settings/')
        .update({
      // _messagesRef.child(('user01') + '/' + mailboxId + '/settings/').update({
      'name': title,
    });

    // Mailbox? mailbox = _mailboxes[mailboxId];
    // mailbox!.settings.name = title;
    // _mailboxes.update(mailboxId, (value) => mailbox);
  }

  //---------------------- NOTIFICATIONS ------------------------

  static void listenToAllNotifications(String mailboxId, String mailboxName) {
    listenToNewMailNotification(mailboxId, mailboxName);
    listenToEmptyBoxNotifications(mailboxId, mailboxName);
    listenToFullBoxNotifications(mailboxId, mailboxName);
  }

  static Future<void> listenToNewMailNotification(String mailboxId, String mailboxName) async {
    _messagesRef
        .child(
        (Authentication.getUserId ?? '') + '/' + mailboxId + '/events/NewMail')
        .onValue.listen((event) async {
      await FirebaseDatabase.instance.reference()
          .child((Authentication.getUserId ?? '') +
          '/' + mailboxId + '/settings/notif_new')
          .once().then((DataSnapshot snapshotSetting) {
        if(event.snapshot.value && snapshotSetting.value){
          Notifications.basicNotification(
              "Nová pošta",
              "Nový list v schránke: " + mailboxName,
              Random().nextInt(2147483647));
        }
      });
    });
  }

  static void listenToEmptyBoxNotifications(String mailboxId, String mailboxName) {
    _messagesRef
        .child(
        (Authentication.getUserId ?? '') + '/' + mailboxId + '/events/EmptyBox')
        .onValue.listen((event) async {
      await FirebaseDatabase.instance.reference()
          .child((Authentication.getUserId ?? '') +
          '/' + mailboxId + '/settings/notif_empty')
          .once().then((DataSnapshot snapshotSetting) {
        if(event.snapshot.value && snapshotSetting.value){
          Notifications.basicNotification(
              "Prázdna schránka",
              "Schránka '" + mailboxName + "' je prázdna.",
              Random().nextInt(2147483647));
        }
      });
    });
  }

  static void listenToFullBoxNotifications(String mailboxId, String mailboxName) {
    _messagesRef
        .child(
        (Authentication.getUserId ?? '') + '/' + mailboxId + '/events/FullBox')
        .onValue.listen((event) async {
      await FirebaseDatabase.instance.reference()
          .child((Authentication.getUserId ?? '') +
          '/' + mailboxId + '/settings/notif_full')
          .once().then((DataSnapshot snapshotSetting) {
        if(event.snapshot.value && snapshotSetting.value){
          Notifications.basicNotification(
              "Plná schránka",
              "Schránka '" + mailboxName + "' je plná.",
              Random().nextInt(2147483647));
        }
      });
    });
  }

  //------------------------------------------------------------------------
  //Writing data and returning a string with data from the service table
  static String getDataService(String mailboxId) {
    String data = '';
    //Redirect to service table
    _messagesRef
        .child((Authentication.getUserId ?? '') + '/' + mailboxId + '/service/')
        .once()
        .then((DataSnapshot snapshot) {
      // Print all data from the service table
      print('Data SERVICE: ${snapshot.value} ');
      data = snapshot.value.toString();
    });
    return data;
  }

  // To change the data for a user's mailbox service table
  static void updateDataService(
      String mailboxId, int counter, int distance) {
    //Redirect to service table and update
    _messagesRef
        .child(Authentication.getUserId ?? '')
        .child(mailboxId)
        .child('service')
        .update({'counter': counter, 'distance_from_senzor': distance});
    // _mailboxes[mailboxId]!.service.counter = counter;
    // _mailboxes[mailboxId]!.service.distanceFromSensor = distance;
  }

  //Removing data from the service table for a user's mailbox
  static void deleteDataService(String mailboxId) {
    //Redirect to service table an remove
    _messagesRef
        .child(Authentication.getUserId ?? '')
        .child(mailboxId)
        .child('service')
        .remove();
  }
}
