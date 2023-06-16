import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fyxt/Fyxt/DashboardSettings/notifications.dart';
import 'package:fyxt/Fyxt/DashboardSettings/photo.dart';

import '../Dasboard.dart';
import 'Pagesnavigator.dart';
import 'chat.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      automaticallyImplyLeading: false,
      title: Text("More"),
    ));
  }
}
