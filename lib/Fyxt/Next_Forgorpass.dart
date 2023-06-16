import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fyxt/Fyxt/FirstScreen.dart';

class NextForgotPass extends StatefulWidget {
  const NextForgotPass({super.key});

  @override
  State<NextForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<NextForgotPass> {
  TextEditingController emailcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  // datapost() async {
  //   try {
  //     Dio dio = Dio();
  //     final response = await dio.post(
  //         'https://web.devapifyxt.com/v1/password/reset/confirm/',
  //         data: {'email': emailcontroller.text});
  //     print('mail${response.data['email']}');
  //     print(emailcontroller.text);
  //     if (response.statusCode == 200) {
  //       print('success');
  //     } else {
  //       print('error');
  //     }
  //     return response;
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formkey,
      child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/Group 4806@2x.png'),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: SingleChildScrollView(
                  child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(right: 300),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                    ),
                    color: Colors.white,
                    iconSize: 28,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(50, 60, 50, 80),
                    child: Image.asset(
                      'assets/splashlogo.png',
                      height: 60,
                    )),
                SizedBox(
                  height: 70,
                ),
                Text(
                  "Thanks!",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 35),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 15, 25, 3),
                  child: Text(
                    "you should receive an email in a few moments",
                    style: TextStyle(color: Colors.white60, fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Text(
                    "Please open that link to reset your password",
                    style: TextStyle(color: Colors.white60, fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 5, 23),
                  child: Text(
                    "Test@fyxt.com",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 5, 20),
                  child: SizedBox(
                    width: 350,
                    height: 45,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LogInPage()));
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 255, 109, 0)),
                        child: Text(
                          "Back to Log In",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 19),
                        )),
                  ),
                ),
                TextButton(
                  child: Text(
                    'Resend Email?',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: 160,
                ),
              ])),
            ),
          )),
    ));
  }
}
