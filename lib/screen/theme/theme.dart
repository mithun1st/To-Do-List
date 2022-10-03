import 'package:flutter/material.dart';

//random color
List<Color> paperColor = [
  Colors.blue,
  Colors.brown,
  Colors.cyan,
  Colors.green,
  Colors.orange,
  Colors.pink,
  Colors.purple,
  Colors.red,
  Colors.teal,
  Colors.yellow,
];

// propeorty variable
BoxDecoration selectDecoration = BoxDecoration(
  shape: BoxShape.circle,
  border: Border.all(
    color: Colors.black,
    width: 4,
  ),
);
BoxDecoration unselectDecoration = BoxDecoration(
  shape: BoxShape.circle,
  border: Border.all(
    color: Colors.white,
    width: 4,
  ),
);
