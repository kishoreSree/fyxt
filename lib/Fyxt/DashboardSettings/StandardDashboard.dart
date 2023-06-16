import 'package:flutter/material.dart';
import 'package:fyxt/Fyxt/DashboardSettings/chat.dart';
import 'package:fyxt/Fyxt/DashboardSettings/more.dart';
import 'package:fyxt/Fyxt/DashboardSettings/notifications.dart';
import 'package:fyxt/Fyxt/DashboardSettings/photo.dart';
import 'package:fyxt/variables/Variables.dart';

import '../Dasboard.dart';

class StandardDashboard extends StatefulWidget {
  const StandardDashboard({super.key});

  @override
  State<StandardDashboard> createState() => _StandardDashboardState();
}

class _StandardDashboardState extends State<StandardDashboard> {
  var _selextedindex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    DashBoardlanding(),
    FyxtChats(),
    PhotoPage(),
    NotificationsPage(),
    MorePage(),
  ];
  bool _snackbar = false;
  @override
  void initState() {
    super.initState();
    dashData().getContentFordashboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _widgetOptions[_selextedindex]),
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
        currentIndex: _selextedindex,
        selectedItemColor: Colors.orangeAccent[700],
        onTap: _ontapped,
        unselectedItemColor: Color.fromARGB(255, 1, 42, 62),
        unselectedLabelStyle: TextStyle(color: Colors.black),
      ),
    );
  }

  void _ontapped(int index) {
    setState(() {
      _selextedindex = index;
      print(_selextedindex);
    });
  }
}
