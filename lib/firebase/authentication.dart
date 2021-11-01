import 'package:firebase_core/firebase_core.dart'; // new
import 'package:firebase_auth/firebase_auth.dart'; // new

enum ApplicationLoginState{
  loggedOut,
  loggedIn
}

class Authentication {
  ApplicationLoginState loginState = ApplicationLoginState.loggedOut;
  String? email;

  Authentication() {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp();
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        loginState = ApplicationLoginState.loggedOut;
      } else {
        loginState = ApplicationLoginState.loggedIn;
      }
    });
  }

  void verifyEmail(String email) async {
    var methods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
    if (methods.contains('password')) {
      // user and signing method exists

    }
    this.email = email;
  }

  void signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void registerAccount(String name, String surname, String email, String password) async {
    try {
      var credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      ); // user will be signed in, userChange() listener will be activated
      //TODO write name and surname to DB
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

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

}