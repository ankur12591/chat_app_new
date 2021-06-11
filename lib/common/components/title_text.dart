import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  late  String title;
 late double defaultSize;
 late Orientation orientation;
  late double height, width;

  TitleText({required this.title});

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    if (Orientation.landscape == true) {
      defaultSize = height * 0.024;
    } else {
      defaultSize = width * 0.024;
    }

    return Column(
      children: [
        Container(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: defaultSize * 2.2,
              //  fontSize: height * 2.2,
            //  fontSize: width  * 0.024 * 2.2,
                fontWeight: FontWeight.bold),
          ),
        ),
        //Text("data", textAlign: TextAlign.center,)
      ],
    );
  }
}
