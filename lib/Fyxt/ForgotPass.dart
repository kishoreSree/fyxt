import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fyxt/Fyxt/Next_Forgorpass.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  TextEditingController emailcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  datapost() async {
    try {
      Dio dio = Dio();
      final response = await dio.post(
          'https://web.devapifyxt.com/v1/password/reset/confirm/',
          data: {'email': emailcontroller.text});
      print('mail${response.data['email']}');
      print(emailcontroller.text);
      if (response.statusCode == 200) {
        print('success');
      } else {
        print('error');
      }
      return response;
    } catch (e) {
      print(e.toString());
    }
  }

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
                  "Forgot Password?",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 15, 25, 3),
                  child: Text(
                    "Enter Your email and We'll send you a link to reset your",
                    style: TextStyle(color: Colors.white60, fontSize: 13),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Text(
                    "Password",
                    style: TextStyle(color: Colors.white60, fontSize: 13),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 5, 23),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      child: TextFormField(
                        controller: emailcontroller,
                        validator: (value) {
                          if (EmailValidator.validate(value!) == false) {
                            return 'Provide valid email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Email",
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.only(left: 150)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 5, 20),
                  child: SizedBox(
                    width: 350,
                    height: 45,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            datapost();
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NextForgotPass()));

                          //emailcontroller.clear();
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 255, 109, 0)),
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                  ),
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
