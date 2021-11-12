
class Database{
  final FirebaseFirestore db = FirebaseFirestore.instance.reference(); // Instance on DB

  void createRecord(){
    db.child( "1" ).set({ // Create record with "id":1
      'title' : 'test' // The content of the title record is a test
    });
  }
  void getData(){
    db.once().then((Snapshot DataSnapshot) {
      print( 'Data: ${snapshot. value } ' ); // Print all record from DB
    });
  }

  void updateData(){
    databaseReference.child('1').update({
      'description': 'test update' // Update
    });
  }

  void deleteData(){
    databaseReference.child('1').remove(); //Delete
  }

}