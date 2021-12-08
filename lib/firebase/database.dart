import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'authentication.dart';

class Database{
  static final DatabaseReference _messagesRef =
  FirebaseDatabase.instance.reference();// Instance on DB

  // Create user
  static void createUser(){
    _messagesRef.child(Authentication.getUserId ?? '').set({
      'mailbox_iter': 0,
    });
  }

  static String getMailboxIter(){
    String data = '';
    data = _messagesRef.child((Authentication.getUserId ?? '') + '/mailbox_iter').key;
    return data;
  }

  // Create record with child "user_id": user_id ,"mailbox_id":mailbox_id
  static void createRecordService(String mailboxId, String counter, String distance){
    _messagesRef.child((Authentication.getUserId ?? '') +'/'+mailboxId+'/service/').set({
      // service -> "counter": counter
      'counter': counter,
      // service -> "distance_from_senzor: distance"
      'distance_from_senzor': distance,
    });
  }

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