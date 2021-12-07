import 'package:flutter/material.dart';

class Notifications {
  static SnackBar snackBar(IconData icon, String text) {
    return SnackBar(
      content: SizedBox(
        height: 40,
        child: Row(
          children: [
            Icon(icon),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(text),
            ),
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: const Color.fromRGBO(33, 150, 243, 0.5),
      elevation: 0.1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
