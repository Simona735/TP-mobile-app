import 'package:firebase_auth/firebase_auth.dart'; // new

class Authentication{
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static bool get isSignedIn => firebaseAuth.currentUser != null;
  static String? get getDisplayName => firebaseAuth.currentUser?.displayName;

  static Future<void> init() async {
    firebaseAuth.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print(user.uid);
      }
    });
  }

  static Future<User?> getCurrentUser(String email) async {
    var currentUser = firebaseAuth.currentUser;

    if (currentUser != null) {
      print(currentUser.uid);
      return currentUser;
    }else{
      return null;
    }
  }

  static Future<String> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      print(userCredential.user!.uid);
      return Future.value(userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('User not found');
        return Future.value('User not found');
      } else if (e.code == 'wrong-password') {
        print('Wrong password');
        return Future.value('Wrong password');
      }else if(e.code == 'invalid-email'){
        print('Invalid email');
        return Future.value('Invalid email');
      } else if(e.code == 'network-request-failed'){
        print('Network error');
        return Future.value('Network error');
      } else if(e.code == 'unknown'){
        print('Given string is empty or null.');
        return Future.value('Given string is empty or null');
      }
    }
    return Future.value('');
  }

  static Future<void> registerAccount(String name, String surname, String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      userCredential.user!.updateDisplayName(name + " " + surname);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

}
