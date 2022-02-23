import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tweeter_app_lucid/constants/constants.dart';
import 'common_text.dart';

class AuthenticationButton extends StatelessWidget {
  final void Function()? onTap;
  final AlignmentGeometry? alignment;
  final double? height,width;
  final String? imageURL;
  final String? buttonText;
  final Color? color;
  final double? fontSize;
  const AuthenticationButton({Key? key, this.onTap, this.height, this.width, this.imageURL, this.buttonText, this.color, this.fontSize, this.alignment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment??Alignment.centerRight,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height??40.h,
          width: width??120.w,
          decoration: BoxDecoration(
            borderRadius: tfRadius,
            image: DecorationImage(
                opacity: 0.6,
                image: ExactAssetImage(
                  imageURL??"assets/images/bgImages/bgButton1.jpg",
                ),
                fit: BoxFit.cover),
          ),
          child: Center(
            child: CommonText(
              text: buttonText??"Login",
              color: color??Colors.white,
              size: fontSize??22.0,
            ),
          ),
        ),
      ),
    );
  }
}
