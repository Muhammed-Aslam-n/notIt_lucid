import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tweeter_app_lucid/widgets/common_text.dart';

class HomeInstructionWidget extends StatelessWidget {
  const HomeInstructionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: (MediaQuery.of(context).size.height * 0.2).h,
        ),
        const CommonText(
          text: "No Tweets so far..",
          size: 16,
          weight: FontWeight.w600,
        ),
        SizedBox(
          height: 20.h,
        ),
        Row(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            const CommonText(
              text: "Create using",
              size: 16,
              weight: FontWeight.w600,
            ),
            SizedBox(width:5.w),
            Image.asset("assets/icons/faButton.png",height: 20,),
            SizedBox(width:5.w),
            const CommonText(
              text: "Button",
              size: 16,
              weight: FontWeight.w600,
            ),
          ],
        ),
      ],
    );
  }
}
