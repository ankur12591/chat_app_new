import 'package:flutter/material.dart';

// Widget appBarMain(BuildContext context) {
//   Size get preferredSize => const Size.fromHeight(100);
//   return AppBar(
//     title: Image.asset(
//       "assets/images/logo.png",
//       height: 40,
//     ),
//     elevation: 0.0,
//     centerTitle: false,
//   );
// }

class appBarMain extends StatelessWidget with PreferredSizeWidget {

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      title: Image.asset(
        "assets/images/logo.png",
        height: 40,
      ),
      elevation: 0.0,
      centerTitle: false,
    );
  }
}


InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white54),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
}

TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.black, fontSize: 16);
}

TextStyle biggerTextStyle() {
  return TextStyle(color: Colors.black, fontSize: 17);
}
