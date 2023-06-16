// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:fyxt/Fyxt/Dasboard.dart';
// import 'package:fyxt/Fyxt/DashboardSettings/chat.dart';
// import 'package:fyxt/Fyxt/DashboardSettings/more.dart';
// import 'package:fyxt/Fyxt/DashboardSettings/notifications.dart';
// import 'package:fyxt/Fyxt/DashboardSettings/photo.dart';

// class Tabnavigator extends StatefulWidget {
//   final String TabItem;

//   final List<Widget> screens;

//   Tabnavigator({required this.screens,required this.TabItem});

//   @override
//   State<Tabnavigator> createState() => _TabnavigatorState();
// }

// class _TabnavigatorState extends State<Tabnavigator> {
//   int _currentIndex = 0;
//   final GlobalKey<NavigatorState> navigatorkey;
//   @override
//   Widget build(BuildContext context) {
//     Widget child;
//     if (widget.TabItem == "DashBoardlanding")
//       child = DashBoardlanding();
//     else if (widget.TabItem == "FyxtChats")
//       child = FyxtChats();
//     else if (widget.TabItem == "PhotoPage")
//       child = PhotoPage();
//     else if (widget.TabItem == "NotificationsPage")
//       child = NotificationsPage();
//     else if (widget.TabItem == "MorePage") child = MorePage();
//     // 'DashBoardlanding',
//     // 'FyxtChats',
//     // 'PhotoPage',
//     // 'NotificationsPage',
//     // 'MorePage'
//     return Navigator(
//       key: widget.navigatorkey,
//       onGenerateRoute: (routesettings) {
//         return MaterialPageRoute(builder: (context) => child);
//       },
//     );
//   }
// }
