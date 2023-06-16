import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fyxt/Fyxt/DashboardSettings/Assigned_to_me.dart';
import 'package:fyxt/Fyxt/FirstScreen.dart';
import 'package:fyxt/variables/baseUrl.dart';
import 'package:fyxt/variables/token.dart';

import 'CreateJob/Standardpages.dart';

class DashBoardlanding extends StatefulWidget {
  const DashBoardlanding({Key? key}) : super(key: key);

  @override
  State<DashBoardlanding> createState() => _DashBoardlandingState();
}

class _DashBoardlandingState extends State<DashBoardlanding> {
  String baseUrl = '';
  String baseurl = hostValue.baseUrl;
  Map<String, int> ApiDatas = {};
  var _selectedindex = 0;
  final token =
      "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJlWnBNd0VPZDRsTUFLcjVDYmtHN3VOd1JucjVLR2h5bWJZVFlXNVV6Nk1rIn0.eyJleHAiOjE2ODQzODQyOTIsImlhdCI6MTY4NDEyNTA5MiwianRpIjoiYWViMjgxMmYtNGFmZC00ZDY0LWIyOGEtM2Q0ZWZlYzQ2YzU5IiwiaXNzIjoiaHR0cHM6Ly9hY2NvdW50LXFhLmZ5eHQuY29tL2F1dGgvcmVhbG1zL3plcm8tZHJhbWEiLCJhdWQiOlsidGVzdC1sb2dpbi1zIiwicmVhbG0tbWFuYWdlbWVudCIsImJyb2tlciIsImFjY291bnQiXSwic3ViIjoibmF2aW4uYSsxQGJ1aWxkaW5nYmxvY2tzLmxhIiwidHlwIjoiQmVhcmVyIiwiYXpwIjoidGVzdC1sb2dpbi1zIiwic2Vzc2lvbl9zdGF0ZSI6ImNhNTk1N2U0LTNkZWMtNDY0Yy04YzNjLWEwZWFjY2RmNzhlMCIsImFjciI6IjEiLCJhbGxvd2VkLW9yaWdpbnMiOlsiKiIsImh0dHA6Ly9sb2NhbGhvc3Q6NDIwMCJdLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsiZGVmYXVsdC1yb2xlcy16ZXJvLWRyYW1hIiwib2ZmbGluZV9hY2Nlc3MiLCJ1bWFfYXV0aG9yaXphdGlvbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7InJlYWxtLW1hbmFnZW1lbnQiOnsicm9sZXMiOlsidmlldy1pZGVudGl0eS1wcm92aWRlcnMiLCJ2aWV3LXJlYWxtIiwibWFuYWdlLWlkZW50aXR5LXByb3ZpZGVycyIsImltcGVyc29uYXRpb24iLCJyZWFsbS1hZG1pbiIsImNyZWF0ZS1jbGllbnQiLCJtYW5hZ2UtdXNlcnMiLCJxdWVyeS1yZWFsbXMiLCJ2aWV3LWF1dGhvcml6YXRpb24iLCJxdWVyeS1jbGllbnRzIiwicXVlcnktdXNlcnMiLCJtYW5hZ2UtZXZlbnRzIiwibWFuYWdlLXJlYWxtIiwidmlldy1ldmVudHMiLCJ2aWV3LXVzZXJzIiwidmlldy1jbGllbnRzIiwibWFuYWdlLWF1dGhvcml6YXRpb24iLCJtYW5hZ2UtY2xpZW50cyIsInF1ZXJ5LWdyb3VwcyJdfSwiYnJva2VyIjp7InJvbGVzIjpbInJlYWQtdG9rZW4iXX0sImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJ2aWV3LWFwcGxpY2F0aW9ucyIsInZpZXctY29uc2VudCIsIm1hbmFnZS1hY2NvdW50LWxpbmtzIiwiZGVsZXRlLWFjY291bnQiLCJtYW5hZ2UtY29uc2VudCIsInZpZXctcHJvZmlsZSJdfX0sInNjb3BlIjoiZW1haWwgcHJvZmlsZSB0ZXN0LWxvZ2luLXMiLCJzaWQiOiJjYTU5NTdlNC0zZGVjLTQ2NGMtOGMzYy1hMGVhY2NkZjc4ZTAiLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwidXNlcl9pZCI6ImVhYTVkNDdlLWRhNjAtNDkzNC1hMmY1LWYzZGM1NTlmOGFhOCIsIm5hbWUiOiJOYXZpbiBBbnRvbnkgUkIiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJuYXZpbi5hKzFAYnVpbGRpbmdibG9ja3MubGEiLCJnaXZlbl9uYW1lIjoiTmF2aW4iLCJmYW1pbHlfbmFtZSI6IkFudG9ueSBSQiIsImVtYWlsIjoibmF2aW4uYSsxQGJ1aWxkaW5nYmxvY2tzLmxhIiwidXNlcl9pZF9yZW1vdGUiOiJjNDBkZmYyMC1mNjk1LTQ2ZjItYmVjYS1jMDZmNTVjNDhlMDkifQ.jp7ndlzROIXJ8ISmekw6Pt9vHkbOkM7EmYTtpkDeEiWgLOTeL3nQCZPAW0edKgmLtt0UofTwUE6vJ7Pyoj72MnjC-nKINCa5r344DpwKyT24jEaglqAVTe_tTpijzfJqe6VJ69BvXxqdQViGWr9KpoknX2heLZPovTUBWDpOJlIKEQq8_zvfyarmXBw8QcLKjqDAKhcFYdW5DcpgXaGHJ6GvCX_8gY2wFjK5bX3dRL1WwFpUKJrn4KXu0lGdtIT9WoP3WUY-9FlSJJK-NRfXm7YD5Mj_Q4vnlqsKbD53t3ciOi7alKqDCfwgdVO3JbW1lrusI6RP51vPm9huMIzDtQ";
  String token1 = ApiToken.token1;
  Future<Map<String, dynamic>> getContentFordashboard() async {
    try {
      Dio dio = Dio();
      final response = await dio.get('https://web.devapifyxt.com/v1/dashboard/',
          data: jsonEncode(<String, String>{
            'email': 'navin.a+1@buildingblocks.la',
            'password': 'Admin12345',
          }),
          options: Options(headers: {
            'source': 'android',
            'Authorization': 'Bearer ${token1}',
            'content-type': 'application/json'
          }));

      if (response.statusCode == 200) {
        // print('Dashboard Response:${response.data}');
        response.data.forEach((key, value) {
          ApiDatas[key] = value as int;
        });
        print('api:${ApiDatas}');
        // print('Api length:${ApiDatas.length}');
        // print('baseUrl:${baseUrl}');
        return response.data;
      } else {
        print("failed");
      }
    } catch (e) {
      print('dash:${e.toString()}');
    }
    return {};
  }

  @override
  void initState() {
    super.initState();
    // getHost();
    //getContentFordashboard();
    ApiToken().GetToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 1, 42, 62),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 290),
              child: SizedBox(
                  height: 40,
                  width: 40,
                  child: Image.asset('assets/splashlogo.png')),
            ),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text('Are you sure,want to logout!!'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'No',
                                  style: TextStyle(color: Colors.black),
                                )),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LogInPage()));
                                },
                                child: Text('yes',
                                    style: TextStyle(color: Colors.black))),
                          ],
                        );
                      });
                },
                icon: Icon(
                  Icons.power_settings_new,
                  color: Colors.orangeAccent[700],
                ))
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<Map<String, dynamic>>(
                future: getContentFordashboard(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 4 / 5,
                              crossAxisSpacing: 6,
                              mainAxisSpacing: 15),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        const SizedBox(
                          height: 20,
                        );
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10, 15, 5, 5),
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 150,
                                width: 150,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 246, 215, 189),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 40),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.warning,
                                          color: Colors.orangeAccent[700],
                                          size: 40,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '${ApiDatas["emergency"]}',
                                          style: TextStyle(
                                              fontSize: 35,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Text(
                                          'Emergency',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 1, 42, 62),
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        if (index == 1) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10, 15, 5, 5),
                            child: GestureDetector(
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 249, 230, 198),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 40, 0, 0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.business_center,
                                          color: Colors.yellow[700],
                                          size: 40,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '${ApiDatas["all_jobs"]}',
                                          style: TextStyle(
                                              fontSize: 35,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Text(
                                          'All jobs',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 1, 42, 62),
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        if (index == 2) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Assigned_to_me()));
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 231, 244, 250),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 40),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Icon(
                                          Icons.assignment,
                                          color: Colors.blue,
                                          size: 40,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '${ApiDatas["assigned_to_me"]}',
                                          style: TextStyle(
                                              fontSize: 35,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Text(
                                          'Asigned To Me',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 1, 42, 62),
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 50,
                  width: 400,
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 1, 42, 62)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StandardCjPages()));
                      },
                      icon: const Icon(Icons.add),
                      label: const Text(
                        "Create Job",
                        style: TextStyle(fontSize: 17),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
