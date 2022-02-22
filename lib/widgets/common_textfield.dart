import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Color? bgColor;
  final Icon? prefixIcon;
  final String? label;
  final bool obscureText;
  final TextInputType? textInputType;
  final double? blurRadius, spreadRadius;

  const CommonTextField(
      {Key? key,
        this.controller,
        this.prefixIcon,
        this.label,
        this.obscureText = false,
        this.bgColor,
        this.blurRadius,
        this.spreadRadius, this.textInputType = TextInputType.emailAddress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.065,
      width: width * 0.85,
      margin: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        borderRadius: tfRadius,
        color: bgColor ?? Colors.white,
        boxShadow: [
          BoxShadow(
              blurRadius: blurRadius ?? 10,
              spreadRadius: spreadRadius ?? 7,
              offset: const Offset(1, 1),
              color: Colors.grey.withOpacity(0.2)),
        ],
      ),
      child: TextFormField(
        style: TextStyle(color: Colors.grey.withOpacity(0.7)),
        controller: controller,
        textInputAction: TextInputAction.next,
        obscureText: obscureText,
        keyboardType: textInputType,
        decoration: InputDecoration(
          fillColor: Colors.white,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          focusedBorder: tfOutlineBorder,
          enabledBorder: tfOutlineBorder,
          prefixIcon: prefixIcon,
          label: Text(label ?? '',style: TextStyle(color: Colors.grey.withOpacity(0.2)),),
        ),
      ),
    );
  }
}
