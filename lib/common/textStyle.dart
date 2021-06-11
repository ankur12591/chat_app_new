import 'dart:ui';

import 'package:flutter/material.dart';

class CustomTextStyle
{

 static TextStyle splashWelcome({required double size,required double height,required double width})
  {
    return TextStyle(
    fontFamily: 'DM Sans',
    fontSize: (size==null && size=='') ? 36 : (width*size)/375,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    // lineHeight: 47px,
    letterSpacing: -0.01,
  );
  }


  static TextStyle heading(double size,double height,double width)
  {
    return TextStyle(
    fontFamily: 'DM Sans',
    fontSize: (size==null && size=='')? 48 : (width*size)/375,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    // lineHeight: 47px,
    letterSpacing: -0.01,
  );
  }

  
 static TextStyle buttonText({required double size,required double height,required double width})
  {
    return TextStyle(
    fontFamily: 'DM Sans',
    fontSize: (size==null && size=='')? 14 : (width*size)/375,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    // lineHeight: 47px,
    letterSpacing: -0.01,
  );
  }


  static TextStyle mediumText(double size,double height,double width)
  {
    return TextStyle(
    fontFamily: 'DM Sans',
    fontSize: (size==null && size=='')? 24 : (width*size)/375,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    // lineHeight: 47px,
    letterSpacing: -0.01,
  );
  }





}
 