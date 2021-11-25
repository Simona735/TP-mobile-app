import 'package:firebase_database/firebase_database.dart';

class Database{
  static final DatabaseReference _messagesRef =
  FirebaseDatabase.instance.reference();// Instance on DB

  static void createRecord(){
    _messagesRef.child( "1" ).set({ // Create record with "id":1
      'title' : 'test' // The content of the title record is a test
    });
  }
  static void getData(){
    _messagesRef.once().then((DataSnapshot snapshot) {
      print( 'Data: ${snapshot. value } ' ); // Print all record from DB
    });
  }
  static void updateData(){
    _messagesRef.child('1').update({
      'description': 'test update' // Update
    });
  }

   static void deleteData(){
    _messagesRef.child('1').remove(); //Delete
  }

}