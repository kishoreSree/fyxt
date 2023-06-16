import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class validation {
  emailvalidation(BuildContext context, var email) {
    if (EmailValidator.validate(email) == false) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text('Invalid Email'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'ok',
                      style: TextStyle(color: Colors.orangeAccent[700]),
                    ))
              ],
            );
          });
    }
  }

  passwordValidation(BuildContext context, String password) {
    if (password == null && password.length <= 8) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(
                'Invalid Password',
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "ok",
                      style: TextStyle(color: Colors.orangeAccent[700]),
                    )),
              ],
            );
          });
    }
  }
}
