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
    final snapshot = await _messagesRef
        .child((Authentication.getUserId ?? '') + '/mailbox_iter').get();
    if (snapshot.exists) {
      return snapshot.value.toString();
    }
    return '';
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
      'UCI': 300000000,
      'UEC': 4,
      'UT': 0.1,
      'UECI': 500,
      'low_power': true,
      'notif_empty': true,
      'notif_full': true,
      'notif_new': true,
      'name': 'Schránka ' + mailboxId,
      'last_event': "Prázdna schránka",
      'last_event_timestamp': ServerValue.timestamp,
    });
    return 'mailbox' + mailboxId;
  }

  static Future<Map<String, Mailbox>> getMailboxes() async {
    final snapshot = await _messagesRef
          .child((Authentication.getUserId ?? '') + '/').get();
    if (snapshot.exists) {
      _mailboxes.clear();
      var data = Map<String, dynamic>.from(snapshot.value);
      data.remove('mailbox_iter');
      if (data.isNotEmpty) {
        for (var k in data.keys) {
          Settings settings =
          Settings.fromJson(Map<String, dynamic>.from(data[k]['settings']));
          Mailbox mailbox = Mailbox(settings);
          _mailboxes.addAll({k: mailbox});
        }
      }
    }
    return _mailboxes;
  }

  static Future<String> getTitleById(String mailboxId) async {
    String data = '';
    final snapshot = await _messagesRef.child(
        (Authentication.getUserId ?? '') +
        '/' +
        mailboxId +
        '/settings/name').get();

    if (snapshot.exists) {
      data = snapshot.value.toString();
    }

    return _mailboxes[mailboxId]!.settings.name;
  }

  static Future<Map> getMailboxDetailById(String mailboxId) async {
    var data = {};
    final snapshot = await _messagesRef.child(
        (Authentication.getUserId ?? '') + '/'
            + mailboxId
            + '/settings/').get();

    if (snapshot.exists) {
      data = snapshot.value as Map<dynamic, dynamic>;
    }
    return data;
  }

  static Future<Settings> getMailboxSettingsById(String mailboxId) async {
    var data = Settings.empty();
    final snapshot = await _messagesRef.child(
          (Authentication.getUserId ?? '') + '/' + mailboxId + '/settings/').get();

    if (snapshot.exists) {
      var detail = Map<String, dynamic>.from(snapshot.value);
      data = Settings.fromJson(detail);
    }
    return data;
  }

  //---------------------- SETTINGS ------------------------

  static void updateLowPower(String mailboxId, bool value) {
    _messagesRef
        .child(
            (Authentication.getUserId ?? '') + '/' + mailboxId + '/settings/')
        .update({
      'low_power': value,
    });
  }

  static void updateTitle(String mailboxId, String title) {
    _messagesRef
        .child(
            (Authentication.getUserId ?? '') + '/' + mailboxId + '/settings/')
        .update({
      'name': title,
    });
  }

  static void updateControlsInterval(String mailboxId, int value) {
    _messagesRef
        .child(
        (Authentication.getUserId ?? '') + '/' + mailboxId + '/settings/')
        .update({
      'UCI': value,
    });
  }

  static void updateExtraControls(String mailboxId, int value) {
    _messagesRef
        .child(
        (Authentication.getUserId ?? '') + '/' + mailboxId + '/settings/')
        .update({
      'UEC': value,
    });
  }

  static void updateExtraControlsInterval(String mailboxId, int value) {
    _messagesRef
        .child(
        (Authentication.getUserId ?? '') + '/' + mailboxId + '/settings/')
        .update({
      'UECI': value,
    });
  }

  static void updateTolerance(String mailboxId, double value) {
    if (value == -1.0){
      value = -0.99;
    }
    _messagesRef
        .child(
        (Authentication.getUserId ?? '') + '/' + mailboxId + '/settings/')
        .update({
      'UT': value,
    });
  }

  static void defaultSettings(String mailboxId) {
    _messagesRef
        .child(
        (Authentication.getUserId ?? '') + '/' + mailboxId + '/settings/')
        .update({
      'UCI': 7000000,
      'UEC': 4,
      'UT': 0.1,
      'low_power': true,
      'notif_empty': true,
      'notif_full': true,
      'notif_new': true,
    });
  }

  //---------------------- NOTIFICATIONS SETTINGS ------------------------
  static void updateNotificationsNewMail(String mailboxId, bool value) {
    _messagesRef
        .child(
        (Authentication.getUserId ?? '') + '/' + mailboxId + '/settings/')
        .update({
      'notif_new': value,
    });
  }

  static void updateNotificationsEmpty(String mailboxId, bool value) {
    _messagesRef
        .child(
        (Authentication.getUserId ?? '') + '/' + mailboxId + '/settings/')
        .update({
      'notif_empty': value,
    });
  }

  static void updateNotificationsFull(String mailboxId, bool value) {
    _messagesRef
        .child(
        (Authentication.getUserId ?? '') + '/' + mailboxId + '/settings/')
        .update({
      'notif_full': value,
    });
  }

  static Future<void> deleteMailbox(String mailboxId) async {
    await _messagesRef
        .child(
        (Authentication.getUserId ?? '') + '/' + mailboxId).remove();

    final snapshot = await _messagesRef
        .child((Authentication.getUserId ?? '') + '/mailbox_iter').get();

    if (snapshot.exists) {
      await _messagesRef.child(Authentication.getUserId ?? '').update({
        'mailbox_iter': snapshot.value - 1,
      });
    }
  }
}
