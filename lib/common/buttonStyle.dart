import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'textStyle.dart';

Widget centerButton(double height,double width,Color buttonColor,Color textColor, String buttonText,VoidCallback pressEvent)
{
  return Container(
              width: width/2.2,
              height: height/15,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    ),
                onPressed: pressEvent,
                padding: EdgeInsets.all(10.0),
                color: buttonColor,
                textColor: textColor,
                child: Text(buttonText,
                    style: CustomTextStyle.buttonText(size: 14,height: height,width: width)),
              ),
            );
}


