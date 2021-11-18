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

  static Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      print(userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return Future.value(false);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return Future.value(false);
      }
    }
    return Future.value(true);
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
