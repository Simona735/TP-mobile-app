import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:tp_mobile_app/models/mailbox.dart';
import 'package:tp_mobile_app/models/service.dart';
import 'package:tp_mobile_app/models/settings.dart';

import 'authentication.dart';

class Database {
  static final Map<String, Mailbox> _mailboxes = <String, Mailbox>{};

  static final DatabaseReference _messagesRef =
  FirebaseDatabase.instance.reference();// Instance on DB

  static void createUser(){
    _messagesRef.child(Authentication.getUserId ?? '').set({
      'mailbox_iter': 0,
    });
  }

  static Future<String> getMailboxIter() async {
    String data = '';
    await _messagesRef.child((Authentication.getUserId ?? '') + '/mailbox_iter').once().then((DataSnapshot snapshot) {
      data = snapshot.value.toString();
    });
    return data;
  }

  static Future<String> updateMailboxIter(String current)async{
    var num = int.parse(current) + 1;
    await _messagesRef.child(Authentication.getUserId ?? '').update({
      'mailbox_iter': num,
    });
    return num.toString();
  }

  static Future<String> createMailbox() async {
    String mailboxId = await getMailboxIter();
    mailboxId = await updateMailboxIter(mailboxId);
    await _messagesRef.child((Authentication.getUserId ?? '') + '/mailbox' + mailboxId + '/service/').set({
      'counter': 0,
      'distance_from_senzor': 100,
      'reset': false,
    });
    await _messagesRef.child((Authentication.getUserId ?? '') + '/mailbox' + mailboxId + '/settings/').set({
      'duty_cycle': 'time',
      'limit': 100,
      'low_power': false,
      'name': 'Schránka ' + mailboxId,
    });
    return 'mailbox' + mailboxId;
  }

  static void setReset(String mailboxId){
    _messagesRef.child((Authentication.getUserId ?? '') + '/' + mailboxId + '/service/').update({
    // _messagesRef.child(('user01') + '/' + mailboxId + '/service/').update({
      'reset': true,
    });
  }

  static Future<Map> getMailboxes() async{
    var mailboxes = {};
    await _messagesRef.child((Authentication.getUserId ?? '') +'/').once().then((DataSnapshot snapshot) {
    // await _messagesRef
    //     .child(('user01') + '/')
    //     .once()
    //     .then((DataSnapshot snapshot) {
      _mailboxes.clear();
      var data = snapshot.value ?? {};
      data.remove('mailbox_iter');
      if (data.length > 0) {
        for (var k in data.keys) {
          mailboxes[k] = data[k]['settings']['name'];
        }
      }
    });
    return mailboxes;
  }

  static Future<String> getTitleById(String mailboxId) async{
    String data = '';
    await _messagesRef.child((Authentication.getUserId ?? '') + '/' + mailboxId + '/settings/name').once().then((DataSnapshot snapshot) {
    // await _messagesRef
    //     .child(('user01') + '/' + mailboxId + '/settings/name')
    //     .once()
    //     .then((DataSnapshot snapshot) {
      data = snapshot.value.toString();
    });
    return data;
  }

  static Future<Map> getMailboxDetailById(String mailboxId) async{
    var data = {};
    await _messagesRef.child((Authentication.getUserId ?? '') + '/' + mailboxId + '/settings/').once().then((DataSnapshot snapshot) {
    // await _messagesRef
    //     .child(('user01') + '/' + mailboxId + '/settings/')
    //     .once()
    //     .then((DataSnapshot snapshot) {
      data = snapshot.value ?? {};
    });
    return data;
  }

  static void updateLimit(String mailboxId, int limit){
    _messagesRef.child((Authentication.getUserId ?? '') + '/' + mailboxId + '/settings/').update({
    // _messagesRef.child(('user01') + '/' + mailboxId + '/settings/').update({
      'limit': limit,
    });
  }

  static void updateLowPower(String mailboxId, bool value){
    _messagesRef.child((Authentication.getUserId ?? '') + '/' + mailboxId + '/settings/').update({
      'low_power': value,
    });
  }

  static void updateTitle(String mailboxId, String title){
    _messagesRef.child((Authentication.getUserId ?? '') + '/' + mailboxId + '/settings/').update({
      'name': title,
    });
  }

  //------------------------------------------------------------------------
  //Writing data and returning a string with data from the service table
  static String getDataService(String mailboxId){
    String data = '';
    //Redirect to service table
    _messagesRef.child((Authentication.getUserId ?? '') +'/'+mailboxId+'/service/').once().then((DataSnapshot snapshot) {
      // Print all data from the service table
      print( 'Data SERVICE: ${snapshot. value } ' );
      data = snapshot.value.toString();
    });
    return data;
  }

  // To change the data for a user's mailbox service table
  static void updateDataService(String mailboxId, String counter, String distance){
    //Redirect to service table and update
    _messagesRef.child(Authentication.getUserId ?? '').child(mailboxId).child('service').update({
      'counter': counter,
      'distance_from_senzor': distance
    });
  }

  //Removing data from the service table for a user's mailbox
   static void deleteDataService(String mailboxId){
    //Redirect to service table an remove
    _messagesRef.child(Authentication.getUserId ?? '').child(mailboxId).child('service').remove();
  }

}
