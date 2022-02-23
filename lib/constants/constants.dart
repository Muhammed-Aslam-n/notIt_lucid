import 'package:flutter/material.dart';


final tfRadius = BorderRadius.circular(20);
const tfBorderSide = BorderSide(
  color: Colors.white,
  width: 1,
);
const appBarGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Colors.purple, Colors.orange],
);
final tfOutlineBorder = OutlineInputBorder(
    borderRadius: tfRadius,
    borderSide: tfBorderSide
);

final Shader linearGradient = const LinearGradient(
  colors: <Color>[Color(0x00f5ec99), Color(0x00c3a660)],
).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));