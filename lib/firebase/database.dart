import 'package:firebase_database/firebase_database.dart';

class Database{
  static final DatabaseReference _messagesRef =
  FirebaseDatabase.instance.reference();// Instance on DB


  // Create record  DATABASE with child "user_id": user_id ,"mailbox_id":mailbox_id
  static void createRecordService(String user_id, String mailbox_id, String counter, String distance){
    _messagesRef.child('DATABASE/'+user_id +'/'+mailbox_id+'/service/').set({
      // service -> "counter": counter
      'counter': counter,
      // service -> "distance_from_senzor: distance"
      'distance_from_senzor': distance,
    });
  }

  //Writing data and returning a string with data from the service table
  static String getDataService(String user_id, String mailbox_id){
    String data = '';
    //Redirect to service table
    _messagesRef.child('DATABASE/'+user_id +'/'+mailbox_id+'/service/').once().then((DataSnapshot snapshot) {
      // Print all data from the service table
      print( 'Data SERVICE: ${snapshot. value } ' );
      data = snapshot.value.toString();
    });
    return data;
  }

  // To change the data for a user's mailbox service table
  static void updateDataService(String user_id, String mailbox_id, String counter, String distance){
    //Redirect to service table and update
    _messagesRef.child('DATABASE').child(user_id).child(mailbox_id).child('service').update({
      'counter': counter,
      'distance_from_senzor': distance
    });
  }

  //Removing data from the service table for a user's mailbox
   static void deleteDataService(String user_id, String mailbox_id){
    //Redirect to service table an remove
    _messagesRef..child('DATABASE').child(user_id).child(mailbox_id).child('service').remove();
  }

}