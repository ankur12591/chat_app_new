import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FormError extends StatelessWidget {
 FormError({

    required this.errors,
  });

  final List<String> errors;
  late double height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Column(
      children: List.generate(
          errors.length, (index) => formErrorText(error: errors[index])),
    );
  }

  Row formErrorText({required String error}) {


    return Row(
      children: [
        SvgPicture.asset(
          "assets/icons/Error.svg",
          height: width * 0.040,
          width: width * 0.040,
        ),
        SizedBox(
          width: width * 0.030,
        ),
        Text(error),
      ],
    );
  }
}
