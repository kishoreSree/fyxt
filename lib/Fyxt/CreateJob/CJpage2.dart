import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyxt/variables/baseUrl.dart';
import 'package:fyxt/variables/token.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:table_calendar/table_calendar.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart';

class CjPage2 extends StatefulWidget {
  const CjPage2({super.key});

  @override
  State<CjPage2> createState() => _CjPage2State();
}

class _CjPage2State extends State<CjPage2> {
  DateTime _selecteddate = DateTime.now();
  DateTime today = DateTime.now();
  String baseurl = hostValue.baseUrl;
  String token = ApiToken.token1;
  List<dynamic> categoryItems = [];
  String category1 = "";
  String Property = "";
  List<dynamic> properties = [];
  bool StandardValue = false;
  DateTime today1 = DateTime.now();
  DateTime? selectedDay1;
  File? image;
  List<File> images = [];
  List<File> images1 = [];
  bool cameraBool = false;
  // DateTime now = DateTime.now();
  // final currentTime=  DateTime(now.day,now.month,now.year).toString();
  String DefaulltPriority = "";
  Widget firstTitle(String Value, bool star, bool target) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12, 8, 10, 10),
      child: Row(
        children: [
          Text(
            "${Value}",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 15,
              fontWeight: target ? FontWeight.w900 : FontWeight.w600,
              color: Color.fromARGB(255, 0, 53, 80),
            ),
          ),
          star
              ? Text(
                  '*',
                  style: TextStyle(color: Colors.red),
                )
              : Container(),
        ],
      ),
    );
  }

  _selectedDay(DateTime selectedday, DateTime focusedday) {
    if (selectedday.day < today1.day) {
      return;
    }
    setState(() {
      today = selectedday;
    });
    Navigator.pop(context);
  }

  bool forLeftChevroon(DateTime selectedDay) {
    return selectedDay.month <= today1.month;
  }

  bool isSameday(DateTime day) {
    return today.year == day.year &&
        today.month == day.month &&
        today.day == day.month;
  }

  void calenderCalling() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.orangeAccent[700]!),
              ),
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TableCalendar(
                      selectedDayPredicate: (day) => isSameDay(day, today),
                      focusedDay: today,
                      firstDay: DateTime.utc(2022),
                      lastDay: DateTime.utc(2030),
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        leftChevronVisible:
                            forLeftChevroon(today) ? true : false,
                      ),
                      rowHeight: 43,
                      onDaySelected: _selectedDay,
                      daysOfWeekHeight: 30,
                      calendarStyle: CalendarStyle(),
                    ),
                  ),
                  // Positioned(
                  //   top: 0,
                  //   right: 0,
                  //   child: IconButton(
                  //     icon: Icon(Icons.close),
                  //     onPressed: () {
                  //       Navigator.pop(context);
                  //     },
                  //   ),
                  //)
                ],
              ),
            ),
          );
        });
  }

  Widget searchBox() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 8, 8, 20),
      child: Container(
        height: 35,
        width: 380,
        decoration: BoxDecoration(color: Colors.blueGrey[50]),
        child: TextField(
          cursorColor: Color.fromARGB(255, 1, 84, 44),
          onChanged: (value) {},
          decoration: InputDecoration(
            hintText: 'search',
            alignLabelWithHint: true,
            contentPadding: EdgeInsets.all(8),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[700]!)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
      ),
    );
  }

  Widget containers(String Value1, String value2, bool target, bool cat,
      bool prior, bool terget) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 10, 10),
      child: Container(
        height: 36,
        child: TextFormField(
          controller: TextEditingController(
              text: cat
                  ? category1
                  : prior
                      ? StandardValue
                          ? Property
                          : "Medium" //DefaulltPriority
                      : DateFormat('dd/MM/yyyy').format(today).toString()),
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          readOnly: true,
          onTap: () {
            target
                ? calenderCalling()
                : showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 600,
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.keyboard_arrow_left),
                                  color: Colors.grey[500],
                                  iconSize: 30,
                                ),
                                Text(
                                  "${value2}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                          cat ? searchBox() : Container(),
                          Expanded(
                            child: cat
                                ? CategoryDatas(true)
                                : CategoryDatas(false),
                          )
                        ]),
                      );
                    },
                  );
          },
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.blueGrey[300]!, width: 0.7)),
              hintText: '${Value1}',
              hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
              alignLabelWithHint: true,
              contentPadding: EdgeInsets.fromLTRB(12, 8, 8, 8),
              fillColor: Colors.grey[50],
              filled: true,
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.8),
                  borderRadius: BorderRadius.circular(5)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              suffixIcon: target
                  ? Icon(
                      Icons.calendar_month,
                      color: Colors.orangeAccent[700],
                    )
                  : Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey[500],
                      size: 35,
                    )),
          validator: (value) {},
        ),
      ),
    );
  }

  Widget CategoryDatas(bool category) {
    return ListView.builder(
      itemCount: category ? categoryItems.length : properties.length,
      itemBuilder: (BuildContext context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              StandardValue = true;
              category
                  ? category1 = categoryItems[index]['name']
                  : Property = properties[index]['name'];
            });
            Navigator.pop(context);
          },
          child: Column(
            children: [
              Padding(
                padding: category
                    ? const EdgeInsets.all(12)
                    : properties[index]['name'] == 'Emergency'
                        ? EdgeInsets.all(0)
                        : EdgeInsets.all(12),
                child: Container(
                  height: category
                      ? null
                      : properties[index]['name'] == 'Emergency'
                          ? 50
                          : null,
                  width: MediaQuery.of(context).size.width,
                  color: category
                      ? Colors.transparent
                      : properties[index]['name'] == 'Emergency'
                          ? Color.fromARGB(255, 223, 6, 56)
                          : Colors.transparent,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        "${category ? categoryItems[index]['name'] : properties[index]['name']}",
                        style: TextStyle(
                            color: category
                                ? Color.fromARGB(
                                    255,
                                    1,
                                    60,
                                    99,
                                  )
                                : properties[index]['name'] == 'Emergency'
                                    ? Colors.white
                                    : properties[index]['name'] == 'Medium'
                                        ? Colors.green
                                        : properties[index]['name'] == 'High'
                                            ? Color.fromARGB(255, 231, 116, 1)
                                            : Color.fromARGB(
                                                255,
                                                1,
                                                60,
                                                99,
                                              ),
                            fontSize: category ? 12 : 13,
                            fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      category
                          ? Text(
                              "Tenant Responsible",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
              category
                  ? Divider(
                      thickness: 1.5,
                    )
                  : properties[index]['name'] == 'Emergency'
                      ? Container()
                      : Divider(
                          thickness: 1.5,
                        ),
            ],
          ),
        );
      },
    );
  }

  Widget photoContainer(String Value3, bool upload) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 20, 10, 10),
      child: Container(
        height: 40,
        width: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color.fromARGB(255, 1, 42, 62),
        ),
        child: GestureDetector(
          onTap: () {
            upload
                ? takePhoto(ImageSource.gallery, false)
                : takePhoto(ImageSource.camera, true);
          },
          child: Row(
            children: [
              upload
                  ? Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Icon(
                        Icons.upload,
                        color: Colors.white,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 4, 0),
                      child: Icon(
                        Icons.photo_camera,
                        color: Colors.white,
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  "${Value3}",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future takePhoto(ImageSource source, bool camera) async {
    try {
      final photoFrom = await ImagePicker().pickImage(source: source);
      final imagePathtemp = File(photoFrom!.path);
      // final imagePathpermenant = await SaveImagePermanent(photoFrom.path);
      // final List<XFile?> UpOrTakePics = await ImagePicker().pickMultiImage();
      // if (UpOrTakePics == null || UpOrTakePics.isEmpty) return;
      // final List<File> tempPhotos = [];
      // for (var pics in UpOrTakePics) {
      //   final tempPhoto = File(pics!.path);
      //   tempPhotos.add(tempPhoto);
      // }
      setState(() {
        //images.addAll(tempPhotos);
        this.images1.add(imagePathtemp);
      });
    } on PlatformException catch (e) {
      print("Failed to Pick Image:$e");
    }
  }

  Future<File> SaveImagePermanent(String imagepath) async {
    final dict = await getApplicationDocumentsDirectory();
    final name = path.basename(imagepath);
    final image = File("${dict.path}/$name");
    return File(imagepath).copy(image.path);
  }

  void getCategory() async {
    Dio dio = Dio();
    try {
      final response = await dio.get("https://${baseurl}/v1/fyxt-categories/",
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
        setState(() {
          categoryItems = response.data;
          //print("${categoryItems}");
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getCategory();
    getPriority();
  }

  void getPriority() async {
    Dio dio = Dio();
    try {
      final response = await dio.get("https://${baseurl}/v1/jobs/priorities/",
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
        setState(() {
          properties = response.data;
          // print("${properties}");
          DefaulltPriority = response.data[3]['name'];
          //print("${DefaulltPriority = response.data[3]['name']}");
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Widget loadPhotos() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 15, 10, 10),
      child: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: //cameraBool
                // ? Image.file(
                //     image,
                //     height: 60,
                //     width: 60,
                //   )
                // :
                //   Row(
                // children: List.generate(images.length, (index) {
                //   final image1 = images[index];
                //   return Stack(
                //     children: [
                //       Image.file(
                //         image1,
                //         height: 60,
                //         width: 60,
                //       ),
                //       Positioned(
                //           child: IconButton(
                //         icon: Icon(
                //           Icons.close,
                //           color: Colors.grey[500],
                //         ),
                //         onPressed: () {
                //           setState(() {
                //             images.removeAt(index);
                //             print("${images.removeAt(index)}");
                //           });
                //         },
                //       ))
                //     ],
                //   );
                // }),
                images1 != null
                    ? Image.file(
                        images1 as File,
                        height: 60,
                        width: 60,
                      )
                    : Container(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          firstTitle("Maintenance Category", true, false),
          containers(
              "Select", "Maintenance Category", false, true, false, false),
          firstTitle("Priority", false, false),
          containers("Select", "Priority", false, false, true, false),
          firstTitle("Target Completion Date", false, true),
          containers("Select", "", true, false, false, true),
          const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text(
              "Add Photos",
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 53, 80),
                  fontSize: 15,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Row(children: [
            photoContainer("Take Photo", false),
            photoContainer("Upload Photo", true)
          ]),
          loadPhotos(),
        ],
      )),
    );
  }
}
