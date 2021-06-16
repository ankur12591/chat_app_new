import 'package:flutter/material.dart';

class appBarMain extends StatelessWidget {
  String title;
  appBarMain({Key? key, required this.title }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      elevation: 0.0,
      centerTitle: false,
    );
  }

}


