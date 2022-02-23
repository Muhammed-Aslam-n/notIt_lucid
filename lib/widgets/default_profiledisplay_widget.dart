import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultProfileDisplayWidget extends StatelessWidget {
  final String? defaultImageURL;
  final double? height, width;

  const DefaultProfileDisplayWidget(
      {Key? key, this.defaultImageURL, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 150.h,
      width: width ?? 150.w,
      child: CircleAvatar(
        backgroundImage: AssetImage(
          defaultImageURL ?? "assets/images/profile/noProfilePictureImage.png",
        ),
      ),
    );
  }
}
