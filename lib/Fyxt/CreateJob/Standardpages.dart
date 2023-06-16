import 'package:flutter/material.dart';
import 'package:fyxt/Fyxt/CreateJob/CJpage2.dart';
import 'package:fyxt/Fyxt/CreateJob/CJpage3.dart';
import 'package:fyxt/Fyxt/CreateJob/cjpage11.dart';
import 'package:fyxt/variables/token.dart';

class StandardCjPages extends StatefulWidget {
  //final GlobalKey<FormState>? formKey;
  int? selectindex = 0;
  StandardCjPages({Key? key, this.selectindex}) : super(key: key);

  @override
  State<StandardCjPages> createState() => _StandardCjPagesState();
}

class _StandardCjPagesState extends State<StandardCjPages> {
  int _selectedindex = 0;
  int _selextedindex1 = 0;
  late cjpage11 _cjpage11;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late StandardCjPages _standardCjPages;

  static final List<Widget> _Pages = [cjpage11(), CjPage2(), Cjpage3()];

  @override
  void initState() {
    super.initState();
    ApiToken().GetToken();

    cjpage11(
      formKey: GlobalKey<FormState>(),
      // Pass the selected index to cjpage11
    );
  }

  @override
  Widget build(BuildContext context) {
    // _cjPage1 = CjPage1();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 1, 42, 62),
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    if (_selectedindex == 0) {
                      Navigator.pop(context);
                    }
                    if (_selectedindex == 1) {
                      _selectedindex = 0;
                    }
                    if (_selectedindex == 2) {
                      _selectedindex = 1;
                    }
                  });
                },
                icon: Icon(Icons.arrow_back_ios_new_sharp)),
            Padding(
              padding: const EdgeInsets.only(left: 60),
              child: Text(
                "Create Job Request",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(65, 0, 0, 0),
              child: TextButton(
                child: Text("Cancel",
                    style: TextStyle(fontSize: 10, color: Colors.white)),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 70,
            width: 500,
            color: Color.fromARGB(136, 228, 227, 227),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 90),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedindex = 0;
                        });
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: _selectedindex == 1 || _selectedindex == 2
                                ? Colors.orangeAccent[700]
                                : Colors.white,
                            border: Border.all(
                                width: _selectedindex == 0 ? 3 : 1,
                                color: _selectedindex == 1 ||
                                        _selectedindex == 2 ||
                                        _selectedindex == 0
                                    ? Colors.orangeAccent[700]!
                                    : Colors.blueGrey[200]!),
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: _selectedindex == 0
                              ? Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.blueGrey),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Text(
                                      "1",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    "1",
                                    style: TextStyle(
                                        color: _selectedindex == 1 ||
                                                _selectedindex == 2
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    width: 45,
                    color: Colors.black,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (formKey.currentState != null &&
                          formKey.currentState!.validate()) {
                        setState(() {
                          _selectedindex += 1;
                          if (_selectedindex == 3) {
                            _selectedindex = 0;
                          }
                        });
                      }
                      setState(() {
                        _selectedindex = 1;
                      });
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: _selectedindex == 2
                              ? Colors.orangeAccent[700]
                              : Colors.white,
                          border: Border.all(
                              width: _selectedindex == 1 ? 3 : 1,
                              color: _selectedindex == 1 || _selectedindex == 2
                                  ? Colors.orangeAccent[700]!
                                  : Colors.blueGrey[200]!),
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: _selectedindex == 1
                            ? Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.blueGrey),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    "2",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              )
                            : Center(
                                child: Text(
                                  "2",
                                  style: TextStyle(
                                      color: _selectedindex == 2
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    width: 45,
                    color: Colors.black,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedindex = 2;
                      });
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              width: _selectedindex == 2 ? 3 : 1,
                              color: _selectedindex == 2
                                  ? Colors.orangeAccent[700]!
                                  : Colors.blueGrey[200]!),
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: _selectedindex == 2
                            ? Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.blueGrey),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    "3",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              )
                            : Center(
                                child: Text(
                                  "3",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Form(
            key: formKey,
            child: Expanded(
              child: _Pages[_selectedindex],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 125,
        child: Column(
          children: [
            ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(380, 40)),
                  backgroundColor: MaterialStateProperty.all<Color?>(
                      Colors.orangeAccent[700]),
                ),
                onPressed: () {
                  // if (_cjpage11.getFormKey()?.currentState?.validate() ??
                  //     false) {
                  //   setState(() {
                  //     _selectedindex += 1;
                  //     if (_selectedindex == 3) {
                  //       _selectedindex = 0;
                  //     }
                  //   });
                  // }
                  //validateCjPage11Form();
                  if (formKey.currentState != null &&
                      formKey.currentState!.validate()) {
                    setState(() {
                      _selectedindex += 1;
                      if (_selectedindex == 3) {
                        _selectedindex = 0;
                      }
                    });
                  } else {
                    print("error");
                  }

                  // setState(() {
                  //   _selectedindex += 1;
                  //   if (_selectedindex == 3) {
                  //     _selectedindex = 0;
                  //   }
                  // });
                  print("${widget.selectindex}");

                  //ApiToken().GetToken();
                  // ApiHit().getLocation();
                },
                child: _selectedindex == 2 ? Text("Submit") : Text('Next')),
            Divider(
              thickness: 1,
            ),
            BottomNavigationBar(
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
              currentIndex: _selextedindex1,
              selectedItemColor: Colors.orangeAccent[700],
              onTap: _ontapped,
              unselectedItemColor: Color.fromARGB(255, 1, 42, 62),
              unselectedLabelStyle: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  void _ontapped(int index) {
    setState(() {
      _selextedindex1 = index;
      print(_selextedindex1);
    });
  }
}
