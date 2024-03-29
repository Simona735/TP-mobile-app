import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer' as developer;

class Authentication{
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static bool get isSignedIn => firebaseAuth.currentUser != null;
  static String? get getDisplayName => firebaseAuth.currentUser?.displayName;
  static String? get getUserId => firebaseAuth.currentUser?.uid;
  static String? get getUserEmail => firebaseAuth.currentUser?.email;

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
      await FirebaseMessaging.instance
          .subscribeToTopic(userCredential.user!.uid);
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
      await FirebaseMessaging.instance
          .subscribeToTopic(userCredential.user!.uid);
      print(userCredential.user!.uid);
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

  static Future<bool> verifyUser(String password) async {
    final user = firebaseAuth.currentUser;
    final cred = EmailAuthProvider.credential(
        email: firebaseAuth.currentUser?.email ?? '',
        password: password
    );
    try {
      await user!.reauthenticateWithCredential(cred);
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return Future.value(false);
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  static Future<String> changePassword(String currentPassword, String newPassword) async {
    final user = firebaseAuth.currentUser;
    final cred = EmailAuthProvider.credential(
        email: firebaseAuth.currentUser?.email ?? '',
        password: currentPassword
    );
    try {
      await user!.reauthenticateWithCredential(cred).then((value) async {
        await user.updatePassword(newPassword);
      });
      return Future.value('OK');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Future.value('Slabé heslo');
      } else if (e.code == 'invalid-password') {
        return Future.value('Heslo musí obsahovať aspoň 6 znakov');
      } else if(e.code == 'network-request-failed'){
        return Future.value('Chyba siete');
      } else if(e.code == 'unknown'){
        return Future.value('Neznáma chyba');
      } else if(e.code == 'wrong-password'){
        return Future.value('Nesprávne heslo');
      }
    } catch (e) {
      print(e);
    }
    return Future.value('NOK');
  }

  static Future<void> sendPasswordResetEmail(String email) async {
    firebaseAuth.sendPasswordResetEmail(email: email);
    print("Password reset email sent successfully.");
  }

  static Future<void> signOut() async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(
        Authentication.getUserId ?? '');
    await firebaseAuth.signOut();
  }

}
