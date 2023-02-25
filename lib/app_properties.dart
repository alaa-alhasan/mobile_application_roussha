import 'package:flutter/material.dart';


const Color lightGrey = Color(0xffF9F9F9);
const Color grey = Color(0xffcccccc);
const Color mediumGrey = Color(0xffa5a5a5);
const Color darkGrey = Color(0xff7f7f7f);
const Color transparentGrey = Color.fromRGBO(127, 127, 127, 0.3);
const Color deepGrey = Color(0xff202020);

const LinearGradient mainButton = LinearGradient(colors: [
  Color.fromRGBO(90, 90, 90, 1),
  Color.fromRGBO(66, 65, 60, 1),
  Color.fromRGBO(65, 60, 55, 1),
], begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter);

const List<BoxShadow> shadow = [
  BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
];

screenAwareSize(int size, BuildContext context) {
  double baseHeight = 640.0;
  return size * MediaQuery.of(context).size.height / baseHeight;
}

// const String apipath = 'http://10.0.2.2:8000/api/';
// const String imagepath = 'http://10.0.2.2:8000/assets/images/';

const String apipath = 'https://roussha.com/api/';
const String imagepath = 'https://roussha.com/assets/images/';
