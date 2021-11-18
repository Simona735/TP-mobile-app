import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'dart:developer' as developer;

import 'package:tp_mobile_app/routes/router.gr.dart';

class PinPutView extends StatefulWidget {
  const PinPutView({Key? key}) : super(key: key);

  @override
  PinPutViewState createState() => PinPutViewState();
}

class PinPutViewState extends State<PinPutView> {
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  EncryptedSharedPreferences encryptedSharedPreferences =
  EncryptedSharedPreferences();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: onlySelectedBorderPinPut(),
    );
  }

  final LocalAuthentication auth = LocalAuthentication();
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  Future<bool> authenticateIsAvailable() async {
    final isAvailable = await auth.canCheckBiometrics;
    final isDeviceSupported = await auth.isDeviceSupported();
    return isAvailable && isDeviceSupported;
  }

  Future<void> _authenticate() async {
    if (await auth.canCheckBiometrics && await auth.isDeviceSupported()) {
      bool authenticated = false;
      try {
        setState(() {
          _isAuthenticating = true;
          _authorized = 'Authenticating';
        });
        authenticated = await auth.authenticate(
          // localizedReason: 'Let OS determine authentication method',
            localizedReason: 'Prilož prstik na senzor',
            useErrorDialogs: true,
            stickyAuth: false);
        setState(() {
          _isAuthenticating = false;
        });
      } on PlatformException catch (e) {
        developer.log(e.toString());
        setState(() {
          _isAuthenticating = false;
          _authorized = "Error - ${e.message}";
        });
        return;
      }
      if (!mounted) return;

      authenticated ? AutoRouter.of(context).replace(BottomBarRoute()) : Future.value(false);
    }
  }

  Widget pinView() {
    final BoxDecoration pinPutDecoration = BoxDecoration(
      color: const Color.fromRGBO(235, 236, 237, 1),
      borderRadius: BorderRadius.circular(20.0),
    );
    Orientation orientation = MediaQuery.of(context).orientation;
    return Expanded(
      flex: (orientation == Orientation.landscape) ? 5 : 0,
      child: SafeArea(
        child: PinPut(
          useNativeKeyboard: false,
          autovalidateMode: AutovalidateMode.always,
          withCursor: false,
          fieldsCount: 4,
          fieldsAlignment: MainAxisAlignment.spaceEvenly,
          textStyle: const TextStyle(fontSize: 25.0, color: Colors.black),
          eachFieldMargin: const EdgeInsets.all(0),
          eachFieldWidth: 45.0,
          eachFieldHeight: 55.0,
          obscureText: '●',
          onSubmit: (String pin) => _showSnackBar(pin),
          focusNode: _pinPutFocusNode,
          controller: _pinPutController,
          submittedFieldDecoration: pinPutDecoration,
          selectedFieldDecoration: pinPutDecoration.copyWith(
            color: Colors.white,
            border: Border.all(
              width: 2,
              color: const Color.fromRGBO(160, 215, 220, 1),
            ),
          ),
          followingFieldDecoration: pinPutDecoration,
          pinAnimationType: PinAnimationType.scale,
        ),
      ),
    );
  }

  Widget keyboardView() {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Expanded(
      flex: (orientation == Orientation.landscape) ? 5 : 0,
      child: SafeArea(
        child: AbsorbPointer(
          absorbing: false,
          child: Container(
            margin: (orientation == Orientation.landscape)
                ? const EdgeInsets.only(left: 20, right: 20)
                : const EdgeInsets.only(left: 60, right: 60),
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: (orientation == Orientation.landscape) ? 2 : 1,
              padding: const EdgeInsets.all(0),
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ...[1, 2, 3, 4, 5, 6, 7, 8, 9, 0].map((e) {
                  return ElevatedButton(
                    child: Text(
                      '$e',
                      style: const TextStyle(fontSize: 25),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onPressed: () {
                      if (_pinPutController.text.length >= 5) return;

                      _pinPutController.text = '${_pinPutController.text}$e';
                      _pinPutController.selection = TextSelection.collapsed(
                          offset: _pinPutController.text.length);
                    },
                  );
                }),
                ElevatedButton(
                  child: const Icon(
                    Icons.backspace_outlined,
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onPressed: () {
                    if (_pinPutController.text.isNotEmpty) {
                      _pinPutController.text = _pinPutController.text
                          .substring(0, _pinPutController.text.length - 1);
                      _pinPutController.selection = TextSelection.collapsed(
                          offset: _pinPutController.text.length);
                    }
                  },
                ),
                ElevatedButton(
                  child: const Icon(
                    Icons.fingerprint_outlined,
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onPressed: () {
                    _authenticate();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // var _homeScaffoldKey = Key("Scaffold Key");

  Widget onlySelectedBorderPinPut() {
    Orientation orientation = MediaQuery.of(context).orientation;
    return SafeArea(
      child: Form(
        // key: _homeScaffoldKey,
        child: (orientation == Orientation.landscape)
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: const Text(
                "Zadaj pin",
                style: TextStyle(fontSize: 25),
              ),
              margin: const EdgeInsets.only(bottom: 30),
            ),
            Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  pinView(),
                  keyboardView(),
                ],
              ),
            ),
          ],
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Zadaj pin",
              style: TextStyle(fontSize: 25),
            ),
            pinView(),
            keyboardView(),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(String pin) {
    encryptedSharedPreferences.getString('pin').then((String value) {
      developer.log(value);
      if (value == pin) {
        Timer(const Duration(milliseconds: 500), () {
          AutoRouter.of(context).replace(BottomBarRoute());
        });
      } else {
        const snackBar = SnackBar(
          duration: Duration(seconds: 3),
          content: SizedBox(
            height: 80.0,
            child: Center(
              child: Text(
                'Nesprávny PIN',
                style: TextStyle(fontSize: 25.0),
              ),
            ),
          ),
          backgroundColor: Colors.deepPurpleAccent,
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    });
  }
}
