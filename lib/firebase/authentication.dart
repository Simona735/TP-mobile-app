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

  }


}