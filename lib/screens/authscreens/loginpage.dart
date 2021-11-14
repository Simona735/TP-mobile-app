import 'package:flutter/material.dart';
import 'package:tp_mobile_app/screens/authscreens/registrationpage.dart';
import 'package:tp_mobile_app/widgets/animations.dart';
import 'package:tp_mobile_app/firebase/authentication.dart';

import '../manager.dart';
class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPage createState() => _LoginPage();
}


class _LoginPage extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    if(Authentication.isSignedIn){
      // Navigator.pop(context);
      // Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      resizeToAvoidBottomInset: true,
      body: ListView(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 80),
            color: Colors.blue,
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'E-mail'),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Heslo'),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: ElevatedButton(
                onPressed: () {
                  Authentication.signInWithEmailAndPassword(emailController.text, passwordController.text);
                  //TODO neuspesne prihlasenie
                  Navigator.pop(context);
                  // Navigator.push(
                  //     context, FadeRoute(page: const ListOfMailboxes()));
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
                },
                child: const Text("Prihlásenie")
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: ElevatedButton(
              onPressed: () {
                // Navigator.pop(context);
                Navigator.push(
                    context, FadeRoute(page: RegistrationPage()));
              },
              child: const Text("Registrácia"),
              style: ElevatedButton.styleFrom(primary: Colors.red),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            child: IconButton(
              color: Colors.blue,
              onPressed: () {},
              iconSize: 60,
              icon: const Icon(
                Icons.fingerprint_outlined,
                size: 60,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
