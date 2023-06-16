import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fyxt/Fyxt/Environmentscr.dart';
import 'package:fyxt/Fyxt/ForgotPass.dart';

import 'SecureStorage.dart';

// validation validator = validation();

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool? checkvalue = false;
  bool? _signin = true;
  bool _afterauth = true;
  TextEditingController emailcontroler = TextEditingController();
  TextEditingController Passwordcontroler = TextEditingController();
  String err = "";
  bool clientside = false;
  bool clientside1 = false;
  bool _obscureText = true;

  void auth() async {
    try {
      Dio dio = Dio();
      final response = await dio.post('https://devapifyxt.com/v1/login/',
          data: {
            "email": emailcontroler.text,
            "password": Passwordcontroler.text,
          },
          options: Options(headers: {
            'source': 'android',
          }));
      print(response.data['email']);
      print(emailcontroler.text);
      print(Passwordcontroler.text);
      if (response.statusCode == 200) {
        setState(() {
          err = 'Success';
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => environment()));
        });
      } else {
        setState(() {
          err = 'Unable to log in with provided crendentials';
          _signin = false;
          _afterauth = false;
          alertdialog();
        });
      }
    } on DioError catch (e) {
      setState(() {
        err = "Unable to log in with provided crendentials";
        print(err);
        _signin = false;
        _afterauth = false;
        alertdialog();
      });
    }
  }

  alertdialog() {
    if (_signin == false) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(err),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Ok',
                      style: TextStyle(color: Colors.orangeAccent[700]),
                    )),
              ],
            );
          });
    }
  }

  emailvalidation(var email) {
    if (EmailValidator.validate(email) == false) {
      setState(() {
        clientside = true;
      });
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

  passwordValidation(String password) async {
    if (password == null || password.length <= 8) {
      setState(() {
        clientside1 = true;
      });
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

  @override
  void initState() {
    super.initState();
    getStoreddata();
  }

  Future getStoreddata() async {
    final name = await secureDatas.getEmail() ?? '';
    final pass = await secureDatas.getpass() ?? '';
    final newemailcontroller = TextEditingController(text: name);
    final newpasswordcontroller = TextEditingController(text: pass);
    setState(() {
      this.emailcontroler = newemailcontroller;
      this.Passwordcontroler = newpasswordcontroller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/Group 4806@2x.png'), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Image.asset(
                        'assets/splashlogo.png',
                        height: 60,
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 60),
                    child: Text(
                      'Welcome Back!',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                          child: TextField(
                        controller: emailcontroler,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'Username',
                          fillColor: Colors.white,
                          filled: true,
                          border: InputBorder.none,
                        ),
                      )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 25, 8, 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                          child: TextField(
                        textAlign: TextAlign.center,
                        obscureText: _obscureText,
                        controller: Passwordcontroler,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              color: Colors.grey[140],
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey[500],
                                ))),
                      )),
                    ),
                  ),
                  Row(
                    children: [
                      Theme(
                        data: ThemeData(unselectedWidgetColor: Colors.white),
                        child: Checkbox(
                            activeColor: Colors.white,
                            value: checkvalue,
                            checkColor: Color.fromARGB(255, 0, 63, 199),
                            onChanged: (value) async {
                              await secureDatas.setEmail(emailcontroler.text);
                              await secureDatas.setpass(Passwordcontroler.text);
                              setState(() {
                                checkvalue = value;
                              });
                            }),
                      ),
                      Text(
                        "Remember Me",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: 400,
                        height: 45,
                        child: ElevatedButton(
                          child: Text(
                            'Log In',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            clientside = false;
                            clientside1 = false;
                            emailvalidation(emailcontroler.text);
                            if (clientside == false) {
                              passwordValidation(Passwordcontroler.text);
                            }
                            if (clientside1 == false && clientside == false) {
                              auth();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.orangeAccent[700]),
                        ),
                      )),
                  Text(
                    'Or',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: 400,
                      height: 45,
                      child: ElevatedButton(
                        child: Text(
                          'Log In With SSO',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            primary: Colors.orangeAccent[700]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 170),
                    child: TextButton(
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPass()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
