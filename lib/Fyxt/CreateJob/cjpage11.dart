import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:fyxt/Fyxt/SecureStorage.dart';

import 'package:fyxt/variables/baseUrl.dart';
import 'package:fyxt/variables/token.dart';


class cjpage11 extends StatefulWidget {
  final GlobalKey<FormState>? formKey;

  const cjpage11({Key? key, this.formKey}) : super(key: key);

  @override
  State<cjpage11> createState() => cjpage11State();
  GlobalKey<FormState>? getFormKey() {
    return formKey;
  }
}

class cjpage11State extends State<cjpage11> {
  String baseurl = hostValue.baseUrl;
  String token = ApiToken.token1;
  List serviceType = [];
  String selectedService = "";
  List<dynamic> Properties = [];
  String id = "";
  String? property = '';
  int unitlength = 0;
  String adddres = "";
  String unit = "";
  String tenentName = "";
  int locpress = 0;
  List<dynamic> filterProperties = [];
  bool isSearching = false;
  List<Map<String, dynamic>> idLocations = [];
  List<Map<String, dynamic>> filterIDlocations = [];
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _selectedindex = 1;
  late TextEditingController _editingController;

  Future getServiceType() async {
    try {
      Dio dio = Dio();
      final response = await dio.get('https://${baseurl}/v1/jobs/service-type/',
          data: jsonEncode(<String, String>{
            'email': 'navin.a+1@buildingblocks.la',
            'password': 'Admin12345',
          }),
          options: Options(headers: {
            'source': 'android',
            'Authorization': 'Bearer ${token}',
            'content-type': 'application/json'
          }));
      if (response.statusCode == 200) {
        print("Success..");
        for (int i = 0; i < response.data.length; i++) {
          serviceType.add(response.data[i]['name']);
        }
        print(serviceType);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future GetProperties() async {
    try {
      Dio dio = Dio();
      final response =
          await dio.get('https://${baseurl}/v1/properties/dropdown/',
              data: jsonEncode(<String, String>{
                'email': 'navin.a+1@buildingblocks.la',
                'password': 'Admin12345',
              }),
              options: Options(headers: {
                'source': 'android',
                'Authorization': 'Bearer ${token}',
                'content-type': 'application/json'
              }));
      if (response.statusCode == 200) {
        print("Success..");

        setState(() {
          Properties = filterProperties = response.data as List<dynamic>;
        });

        print("Properties:${Properties}");
        //print(id);
        return Properties;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getLocation() async {
    try {
      Dio dio = Dio();
      final response =
          await dio.get('https://${baseurl}/v1/properties/${id}/units/',
              data: jsonEncode(<String, String>{
                'email': 'navin.a+1@buildingblocks.la',
                'password': 'Admin12345',
              }),
              options: Options(headers: {
                'source': 'android',
                'Authorization': 'Bearer ${token}',
                'content-type': 'application/json'
              }));
      if (response.statusCode == 200) {
        print("Success..");

        // print(response.data);

        idLocations = List<Map<String, dynamic>>.from(response.data);
        filterIDlocations = List<Map<String, dynamic>>.from(response.data);
        print("id:${idLocations}");

        //print(idLocations.length);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  String? validateMethod(String? value, String? message) {
    if (value != null && value.isEmpty) {
      flushbarMessage(message);
      return message;
    }
    return null;
  }

  void flushbarMessage(msg) {
    Flushbar(
      message: msg,
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Colors.red[700]!,
    ).show(context);
  }

  void filters(String value) {
    setState(() {
      filterProperties = Properties.where((property) => property['name']
          .toString()
          .toLowerCase()
          .contains(value.toLowerCase())).toList();
      isSearching == true;
    });
  }

  void Locationfilters(String value) {
    setState(() {
      filterIDlocations = idLocations.where((Location) {
        final units = Location['units'] as List<dynamic>;
        return Location['address']
                .toString()
                .toLowerCase()
                .contains(value.toLowerCase()) ||
            units.any((unit) => unit['name']
                .toString()
                .toLowerCase()
                .contains(value.toLowerCase())) ||
            units.any((unit) =>
                unit['tenant'] != null &&
                unit['tenant']['name']
                    .toString()
                    .toLowerCase()
                    .contains(value.toLowerCase()));
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getServiceType();
    GetProperties();
    // getDatasFixed();
  }

  Future getDatasFixed() async {
    final srType = await secureDatas.getSRtype() ?? '';
    setState(() {
      selectedService = srType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 10, 10, 10),
                  child: Row(
                    children: const [
                      Text(
                        "Service Type",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '*',
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(7, 0, 10, 10),
                  child: Container(
                    height: 40,
                    child: TextFormField(
                      controller: TextEditingController(text: selectedService),
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                      readOnly: true,
                      onTap: () {
                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 500,
                              child: Column(children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 20, 0, 10),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.keyboard_arrow_left),
                                        color: Colors.black,
                                      ),
                                      const Text(
                                        "Sevice Type",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: serviceType.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            selectedService =
                                                serviceType[index];
                                          });
                                          Navigator.pop(context);
                                          await secureDatas
                                              .setSRType(serviceType[index]);
                                        },
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30),
                                              child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    "${serviceType[index]}",
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )),
                                            ),
                                            Divider(
                                              thickness: 0.7,
                                              color: Colors.grey[500],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ]),
                            );
                          },
                        );
                      },
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blueGrey[300]!, width: 0.7)),
                          hintText: 'select',
                          hintStyle: TextStyle(
                              color: Colors.blueGrey[400],
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.all(8.0),
                          fillColor: Colors.grey[50],
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 0.8),
                              borderRadius: BorderRadius.circular(5)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          suffixIcon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey[500],
                          )),
                      validator: (value) {
                        validateMethod(value, 'Kindly Choose Service type');
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 10, 10, 10),
                  child: Row(
                    children: const [
                      Text(
                        "Property",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '*',
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(7, 0, 10, 10),
                  child: Container(
                    height: 40,
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                      controller: TextEditingController(text: property),
                      readOnly: true,
                      onTap: () {
                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 500,
                              child: Column(children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 20, 0, 10),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.keyboard_arrow_left),
                                        color: Colors.black,
                                      ),
                                      const Text(
                                        "Property",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  width: 380,
                                  child: TextField(
                                    cursorColor: Color.fromARGB(255, 1, 84, 44),
                                    onChanged: (value) {
                                      setState(() {
                                        filters(value);
                                      });
                                      if (value.isEmpty) {
                                        setState(() {
                                          filterProperties = Properties;
                                        });
                                      }
                                    },
                                    decoration: const InputDecoration(
                                      hintText: 'search',
                                      alignLabelWithHint: true,
                                      contentPadding: EdgeInsets.all(8),
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey)),

                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: filterProperties.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            property =
                                                filterProperties[index]['name'];
                                            id = filterProperties[index]['id'];
                                            print(id);
                                            getLocation();
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                color: Color.fromARGB(
                                                    255, 240, 239, 239),
                                                child: ListTile(
                                                  title: Text(
                                                    "${filterProperties[index]["name"]}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 15),
                                                  ),
                                                  subtitle: Text(
                                                    "${filterProperties[index]['address']}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ]),
                            );
                          },
                        );
                      },
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blueGrey[300]!, width: 0.7)),
                          hintText: 'select',
                          hintStyle: TextStyle(
                              color: Colors.blueGrey[400],
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.all(8.0),
                          fillColor: Colors.grey[50],
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          suffixIcon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey[500],
                          )),
                      validator: (value) {
                        validateMethod(value, 'Kindly Choose Property');
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 10, 10, 10),
                  child: Row(
                    children: const [
                      Text(
                        "Location",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '*',
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(7, 0, 10, 10),
                  child: Container(
                    height: 40,
                    child: TextFormField(
                      controller: TextEditingController(
                          text: locpress == 0
                              ? null
                              : "$adddres,$unit,$tenentName"),
                      readOnly: true,
                      onTap: () {
                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 500,
                              child: Column(children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 20, 0, 10),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.keyboard_arrow_left),
                                        color: Colors.black,
                                      ),
                                      const Text(
                                        "Location",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Container(
                                    height: 30,
                                    width: 400,
                                    child: TextField(
                                      cursorColor:
                                          Color.fromARGB(255, 1, 84, 44),
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          setState(() {
                                            Locationfilters(value);
                                          });
                                        } else if (value.isEmpty) {
                                          filterIDlocations = idLocations;
                                        }
                                      },
                                      decoration: const InputDecoration(
                                          hintText: 'search',
                                          alignLabelWithHint: true,
                                          contentPadding: EdgeInsets.all(8.0),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey))),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: filterIDlocations.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Container(
                                                  color: Colors.grey[300],
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    "${filterIDlocations[index]['address']}",
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                ),
                                                for (int i = 0;
                                                    i <
                                                        filterIDlocations[index]
                                                                ['units']
                                                            .length;
                                                    i++)
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        adddres =
                                                            filterIDlocations[
                                                                    index]
                                                                ['address'];
                                                        unit =
                                                            filterIDlocations[
                                                                        index]
                                                                    ['units'][i]
                                                                ['name'];
                                                        tenentName = filterIDlocations[
                                                                            index]
                                                                        [
                                                                        'units']
                                                                    [
                                                                    i]['tenant']
                                                                ?['name'] ??
                                                            "Unknown";
                                                        locpress = 1;
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 5),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                              "${filterIDlocations[index]['units'][i]['name']}"),
                                                          Spacer(),
                                                          Text(
                                                              "${filterIDlocations[index]['units'][i]['tenant']?['name'] ?? "Unknown"}"),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ]),
                            );
                          },
                        );
                      },
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blueGrey[300]!, width: 0.6)),
                          hintText: 'select tenent and unit',
                          hintStyle: TextStyle(
                              color: Colors.blueGrey[400],
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.all(8.0),
                          fillColor: Colors.grey[50],
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueGrey)),
                          suffixIcon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          )),
                      validator: (value) {
                        validateMethod(value, 'Kindly Choose Location');
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 10, 10, 10),
                  child: Row(
                    children: [
                      Text(
                        "Brief Description",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '*',
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(7, 0, 10, 10),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    maxLines: 3,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueGrey[300]!, width: 0.7)),
                        hintText: 'Description',
                        hintStyle: TextStyle(
                            color: Colors.blueGrey[400],
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                        alignLabelWithHint: true,
                        contentPadding: EdgeInsets.all(8.0),
                        fillColor: Colors.grey[50],
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey))),
                    //minLines: null,
                    validator: (value) {
                      validateMethod(value, 'Please Provide Brief Description');
                    },
                  ),
                ),
                const Padding(
                  padding: const EdgeInsets.fromLTRB(8, 10, 10, 10),
                  child: Text(
                    "Detailed Description",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(7, 0, 10, 10),
                  child: TextFormField(
                      cursorColor: Colors.black,
                      maxLines: 3,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blueGrey[300]!, width: 0.7)),
                          hintText: 'Description',
                          hintStyle: TextStyle(
                              color: Colors.blueGrey[400],
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.all(8.0),
                          fillColor: Colors.grey[50],
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)))),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
