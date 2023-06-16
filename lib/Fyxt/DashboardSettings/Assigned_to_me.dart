import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fyxt/variables/baseUrl.dart';
import 'package:fyxt/variables/token.dart';

class Assigned_to_me extends StatefulWidget {
  const Assigned_to_me({super.key});

  @override
  State<Assigned_to_me> createState() => _Assigned_to_meState();
}

class _Assigned_to_meState extends State<Assigned_to_me> {
  late List<dynamic> DataList = [];
  int _selectedindex = 0;
  int total = 0;
  bool hasMore = true;

  String baseurl = hostValue.baseUrl;
  int page = 2;
  bool Isloading = false;
  final controller = ScrollController();
  //String token = ApiToken.token;
  String token1 = ApiToken.token1;
  Future<void> FetchdatsForssignedJob() async {
    try {
      Dio dio = Dio();
      final response =
          await dio.get('https://${baseurl}/v1/jobs/?filter=assigned_to_me',
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
        print("Success..");
        // print("Assigned_to_me:${response.data}");
        print("Assigned_to_me:${response.data['results'].length}");
        setState(() {
          DataList = response.data['results'];
          total = response.data['count'];
        });
        print(DataList);
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    FetchdatsForssignedJob();
    final limit = 20;
    controller.addListener(() {
      if (controller.position.maxScrollExtent - controller.position.pixels <=
          limit) {
        fetchMore();
        ApiToken().GetToken();
      }
    });
  }

  Future<void> fetchMore() async {
    if (Isloading) return;
    Isloading = true;
    try {
      Dio dio = Dio();
      final limit = 20;
      final response = await dio.get(
          'https://${baseurl}/v1/jobs/?filter=assigned_to_me&page=$page',
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
        print("Success:");
        final AddDataList = response.data['results'];
        setState(() {
          page++;
          Isloading = false;
          if (AddDataList.length < limit) {
            hasMore = false;
          }
          DataList.addAll(AddDataList);
        });
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   FetchdatsForssignedJob();
  // }
  Future Refresh() async {
    setState(() {
      Isloading = false;
      hasMore = true;
      page = 1;
      DataList.clear();
    });
    fetchMore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 42, 62),
        title: Row(
          children: [
            Text('$total'),
            SizedBox(
              width: 10,
            ),
            Text("Assigned to me"),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: Refresh,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  controller: controller,
                  shrinkWrap: true,
                  itemCount: DataList.length + 1,
                  itemBuilder: (context, int index) {
                    if (index < DataList.length) {
                      final items = DataList[index];
                      print(items);
                      print(DataList.length);
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              items['property'],
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Color.fromARGB(255, 1, 42, 62),
                                  fontWeight: FontWeight.w600),
                            ),
                            subtitle:
                                Text('${items['service_type']}-${items['id']}'),
                            trailing: Container(
                                padding: EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colors.blue, width: 1.3)),
                                child: Text(
                                  items['stage']['name'],
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 2, 123, 179)),
                                )),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.fromLTRB(25, 0, 0, 10),
                          //   child: Align(
                          //     alignment: Alignment.topLeft,
                          //     child: Text(
                          //       '${items['description']}',
                          //     ),
                          //   ),
                          // ),
                          Row(
                            children: [
                              // Spacer(),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      'Priority',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    if (items['priority'] == 'Emergency')
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12),
                                        child: Text(
                                          '${items['priority']}',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    else if (items['priority'] == 'Medium')
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12),
                                        child: Text(
                                          '${items['priority']}',
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    else if (items['priority'] == 'High')
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12),
                                        child: Text(
                                          '${items['priority']}',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 214, 116, 3),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    else if (items['priority'] == null)
                                      Text(
                                        'NA',
                                      )
                                    else
                                      Text("${items['priority']}")
                                  ],
                                ),
                              ),

                              //Spacer(),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Location",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      "${items['unit']}",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 1, 42, 62),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              //Spacer(),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Category",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      "${items['category']}",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 1, 42, 62),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1,
                          ),
                        ],
                      );
                    } else {
                      return hasMore
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Center(child: Text("No More datas"));
                    }
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.dashboard,
                size: 30,
              ),
              label: 'Dashboard'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              size: 30,
            ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.photo_camera,
                size: 30,
              ),
              label: 'Photo'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
                size: 30,
              ),
              label: 'Notifications'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,
              size: 30,
            ),
            label: 'More',
          ),
        ],
        currentIndex: _selectedindex,
        selectedItemColor: Colors.orangeAccent[700],
        onTap: _ontapped,
        unselectedItemColor: Color.fromARGB(255, 1, 42, 62),
        unselectedLabelStyle: TextStyle(color: Colors.black),
      ),
    );
  }

  void _ontapped(int index) {
    setState(() {
      _selectedindex = index;
    });
  }
}
