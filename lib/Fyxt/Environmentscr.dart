import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fyxt/Fyxt/SecureStorage.dart';

import 'Dasboard.dart';
import 'DashboardSettings/StandardDashboard.dart';

class environment extends StatefulWidget {
  const environment({super.key});

  @override
  State<environment> createState() => _EnvironmentState();
}

class _EnvironmentState extends State<environment> {
  List<String> names = [];
  int selectedindex = -1;
  Future<List<String>>? _namesFuture;
  List<String> hostLink = [];
  String baseUrl1 = '';

  Future<List<String>> getName() async {
    names.clear();
    try {
      Dio dio = Dio();
      final response = await dio.post('https://devapifyxt.com/v1/login/',
          data: jsonEncode(<String, String>{
            'email': 'navin.a+1@buildingblocks.la',
            'password': 'Admin12345'
          }),
          options: Options(headers: {'source': 'android'}));
      if (response.statusCode == 200) {
        print('ok');
        final resString = response.toString();
        print(resString);
        final parsedjason = jsonDecode(resString);
        final domain = parsedjason['domains'];
        print('Length of Domain is:${domain.length}');
        List<String> namess = [];

        for (int i = 0; i < domain.length; i++) {
          final name = parsedjason['domains'][i]['name'];
          final hostLinks = parsedjason['domains'][i]['host'];
          print(name);
          names.add(name);
          namess.add(name);
          hostLink.add(hostLinks);

          print(names);
          print("Hosts:$hostLink");
          print("Hosts:${hostLink.length}");
        }
        return namess;
      }
    } catch (e) {
      print(e.toString());
    }
    throw Exception('failed');
  }

  ontapped(int index) {
    setState(() {
      selectedindex = index;
      print(selectedindex);
    });
  }

  @override
  void initState() {
    super.initState();
    _namesFuture = getName();
    getHost();
  }

  getHost() async {
    await secureDatas.gethost();
    print('${await secureDatas.gethost()}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
                      padding: const EdgeInsets.fromLTRB(50, 60, 50, 80),
                      child: Image.asset(
                        'assets/splashlogo.png',
                        height: 60,
                      )),
                  SizedBox(
                    height: 70,
                  ),
                  const Text(
                    "Environment",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35),
                  ),
                  const Padding(
                    padding: const EdgeInsets.fromLTRB(25, 15, 25, 3),
                    child: Text(
                      "Choose which environment you want",
                      style: TextStyle(color: Colors.white60, fontSize: 15),
                    ),
                  ),
                  Container(
                    height: 140,
                    width: 400,
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder<List<String>>(
                      future: _namesFuture,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: names.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(3, 3, 20, 8),
                                child: Container(
                                  height: 125,
                                  width: 210,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      border: Border.all(
                                        width: 3,
                                        color: selectedindex == index
                                            ? Colors.orangeAccent[700] ??
                                                Colors.transparent
                                            : Colors.transparent,
                                      )),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          side: BorderSide(
                                              width: 2,
                                              color: selectedindex == index
                                                  ? Colors.orangeAccent[700] ??
                                                      Colors.white
                                                  : Colors.white)),
                                      onPressed: () async {
                                        ontapped(index);
                                        if (selectedindex == index) {
                                          await secureDatas
                                              .sethost(hostLink[index]);
                                          print('${hostLink[index]}');
                                          setState(() {
                                            baseUrl1 = hostLink[index];
                                          });
                                        }
                                      },
                                      child: Text(
                                        "${names[index]}",
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 1, 42, 62),
                                            fontWeight: FontWeight.w800,
                                            fontSize: 20),
                                      )),
                                ),
                              );
                            },
                          );
                        }
                        ;
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.orangeAccent[700] ?? Colors.white),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 350,
                    height: 45,
                    child: ElevatedButton(
                        onPressed: () {
                          if (selectedindex == -1) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content:
                                        Text("Kindly Choose an Environment!!"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Ok",
                                            style: TextStyle(
                                                color:
                                                    Colors.orangeAccent[700]),
                                          ))
                                    ],
                                  );
                                });
                          } else if (baseUrl1 != "web.devapifyxt.com") {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Text("Api host Is Not Running!!"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Ok",
                                            style: TextStyle(
                                                color:
                                                    Colors.orangeAccent[700]),
                                          ))
                                    ],
                                  );
                                });
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StandardDashboard()));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 255, 109, 0)),
                        child: const Text(
                          "Enter",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        )),
                  ),
                  const SizedBox(
                    height: 160,
                  ),
                ])),
              ),
            )));
  }
}
