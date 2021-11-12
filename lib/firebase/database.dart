
class Database{
  FirebaseFirestore db = FirebaseFirestore.instance.reference(); // Instance on DB

  void createRecord(){
    db.child( "1" ).set({ // Create record with "id":1
      'title' : 'test' // The content of the title record is a test
    });
  }


}