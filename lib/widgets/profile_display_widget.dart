import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserProfileDisplayWidget extends StatelessWidget {
  final String networkImageURl;
  final double? height,width;
  final String? loadingGiphyURL;

  const UserProfileDisplayWidget({Key? key, required this.networkImageURl, this.height, this.width, this.loadingGiphyURL}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        networkImageURl,
        height: height??150.h,
        width: width??150.w,
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context,
            Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Center(
            child: Image.asset(
              loadingGiphyURL??"assets/gifs/loadingGiphy.gif",
              height: height??150.h,
              width: width??150.w,
            ),
          );
        },
      ),
    );
  }
}
