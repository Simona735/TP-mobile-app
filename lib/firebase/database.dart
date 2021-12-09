import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'authentication.dart';

class Database{
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
      'mode': 2,
      'name': 'Schránka ' + mailboxId,
    });
    return 'mailbox' + mailboxId;
  }

  static void setReset(String mailboxId){
    _messagesRef.child((Authentication.getUserId ?? '') + '/' + mailboxId + '/service/').update({
      'reset': true,
    });
  }

  static Future<Map> getMailboxes() async{
    var mailboxes = {};
    await _messagesRef.child((Authentication.getUserId ?? '') +'/').once().then((DataSnapshot snapshot) {
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
      data = snapshot.value.toString();
    });
    return data;
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
