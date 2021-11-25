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
        return Future.value('Používateľ sa nenašiel');
      } else if (e.code == 'wrong-password') {
        print('Wrong password');
        return Future.value('Nesprávne heslo');
      }else if(e.code == 'invalid-email'){
        print('Invalid email');
        return Future.value('Neplatný e-mail');
      } else if(e.code == 'network-request-failed'){
        print('Network error');
        return Future.value('Chyba siete');
      } else if(e.code == 'unknown'){
        print('Given string is empty or null.');
        return Future.value('Vyplň prihlasovacie údaje');
      }
    }
    return Future.value('');
  }

  static Future<String> registerAccount(String name, String surname, String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      userCredential.user!.updateDisplayName(name + " " + surname);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Future.value('Slabé heslo');
      } else if (e.code == 'invalid-password') {
        return Future.value('Heslo musí obsahovať aspoň 6 znakov');
      } else if (e.code == 'email-already-in-use') {
        return Future.value('Konto pre tento e-mail už existuje');
      } else if (e.code == 'invalid-display-name') {
        return Future.value('Zadaj meno a priezvisko');
      } else if (e.code == 'invalid-email') {
        return Future.value('Neplatný e-mail');
      } else if(e.code == 'network-request-failed'){
        return Future.value('Chyba siete');
      } else if(e.code == 'unknown'){
        return Future.value('Neznáma chyba');
      }
    } catch (e) {
      print(e);
    }
    return Future.value('');
  }

  static Future<String> changePassword(String currentPassword, String newPassword) async {
    final user = firebaseAuth.currentUser;
    final cred = EmailAuthProvider.credential(
        email: firebaseAuth.currentUser?.email ?? '',
        password: currentPassword
    );
    try {
      user!.reauthenticateWithCredential(cred).then((value) {
        user.updatePassword(newPassword).then((_) {
          return Future.value('ok');
        });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Future.value('Slabé heslo');
      } else if (e.code == 'invalid-password') {
        return Future.value('Heslo musí obsahovať aspoň 6 znakov');
      } else if(e.code == 'network-request-failed'){
        return Future.value('Chyba siete');
      } else if(e.code == 'unknown'){
        return Future.value('Neznáma chyba');
      }
    } catch (e) {
      print(e);
    }
    return Future.value('NOK');
  }

  static Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

}
