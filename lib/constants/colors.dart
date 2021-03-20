import 'package:flutter/material.dart';

Color mainColor = Color.fromRGBO(15, 81, 30, 1);//rgb(15,81,30)
var roundedRectangle = RoundedRectangleBorder(
  borderRadius: BorderRadiusDirectional.circular(12),
  side: BorderSide(width: 0.1, color: mainColor),
);
var roundedRectangle32 = RoundedRectangleBorder(
  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
);
