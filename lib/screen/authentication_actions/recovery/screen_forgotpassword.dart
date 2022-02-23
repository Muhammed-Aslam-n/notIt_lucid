import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tweeter_app_lucid/controllers/auth_controller.dart';
import 'package:tweeter_app_lucid/widgets/auth_button.dart';
import 'package:tweeter_app_lucid/widgets/common_headers.dart';
import 'package:tweeter_app_lucid/widgets/common_text.dart';
import 'package:tweeter_app_lucid/widgets/common_textfield.dart';

class ScreenForgotPassword extends StatelessWidget {
  const ScreenForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage(
                "assets/images/bgImages/bg82.jpg",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 150.h,
                    ),
                    const CommonHeaders(
                      text: "Reset Password",
                      color: Colors.black,
                      size: 35.0,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    CommonText(
                      text: " Recover using email",
                      size: 13.0.sp,
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                    CommonTextField(
                      controller: AuthController.authController.emailController,
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.deepOrangeAccent,
                      ),
                      label: "Email",
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const CommonText(text: "\t\t\t\t\t\t\t\t\t\t* Reset link will be sent to your email",color: Colors.black,),
                    SizedBox(
                      height: 40.h,
                    ),
                    AuthenticationButton(
                      onTap: (){
                        debugPrint("Reset Button Clicked");
                        AuthController.authController.resetPasswordUsingEmail();
                      },
                      height: 45.h,
                      width: 150.w,
                      color: Colors.black,
                      buttonText: "Reset",
                      fontSize: 25.0,

                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
