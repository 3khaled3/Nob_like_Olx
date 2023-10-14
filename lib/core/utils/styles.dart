import 'package:flutter/material.dart';

abstract class Styles {
  static Color backgroundColor = const Color(0xffFAFAFA);
  static const TextStyle style18 = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontFamily: 'Almarai',
    fontWeight: FontWeight.w700,
    height: 0,
  );
  static const TextStyle style18Black = TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontFamily: 'Almarai',
    fontWeight: FontWeight.w700,
    height: 0,
  );

  static const TextStyle style16notcolor = TextStyle(
    fontSize: 16,
    fontFamily: 'Almarai',
    fontWeight: FontWeight.w700,
    height: 0,
  );

  static TextStyle style14Black = const TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontFamily: 'Almarai',
    fontWeight: FontWeight.w700,
    height: 0,
  );
  static TextStyle style12 = const TextStyle(
    color: Colors.grey,
    fontSize: 12,
    fontFamily: 'Almarai',
    fontWeight: FontWeight.w700,
  );
  static ButtonStyle buttomStyle = const ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(Colors.transparent),
    elevation: MaterialStatePropertyAll(0),
    overlayColor: MaterialStatePropertyAll(Color.fromARGB(59, 214, 214, 214)),
  );
}
