import 'package:flutter/material.dart';

class CommonHeaders extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? size;
  final FontWeight? weight;

  const CommonHeaders({this.text, this.weight, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: TextStyle(
          color: color, fontSize: size, fontWeight: weight ?? FontWeight.w600),
    );
  }
}