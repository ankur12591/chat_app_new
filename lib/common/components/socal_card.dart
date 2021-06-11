import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocalCard extends StatelessWidget {
  SocalCard({
    required this.icon,
    required this.press,
  });

  final String icon;
  final Function press;
  late double height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return GestureDetector(
      // onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: width * 0.03),
        padding: EdgeInsets.all(width * 0.033),
        height: height * 0.12,
        width: width * 0.12,
        decoration: BoxDecoration(
          color: Color(0xFFF5F6F9),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(icon),
      ),
    );
  }
}
