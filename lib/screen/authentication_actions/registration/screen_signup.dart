import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tweeter_app_lucid/constants/constants.dart';
import 'package:tweeter_app_lucid/controllers/auth_controller.dart';
import 'package:tweeter_app_lucid/widgets/auth_button.dart';
import 'package:tweeter_app_lucid/widgets/common_headers.dart';
import 'package:tweeter_app_lucid/widgets/common_text.dart';
import 'package:tweeter_app_lucid/widgets/common_textfield.dart';

class ScreenSignup extends StatelessWidget {
  const ScreenSignup({Key? key}) : super(key: key);

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
                      height: 100.h,
                    ),
                    const CommonHeaders(
                      text: "Hi!",
                      color: Colors.black,
                      size: 62.0,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    CommonText(
                      text: "\t\tSign up to Enjoy with us",
                      size: 13.0.sp,
                    ),
                    SizedBox(
                      height: 70.h,
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
                      height: 40.h,
                    ),
                    CommonTextField(
                      controller:
                          AuthController.authController.passwordController,
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.deepOrangeAccent,
                      ),
                      label: "Password",
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    AuthenticationButton(
                      onTap: () {
                        debugPrint("SignUp Button Clicked");
                        AuthController.authController.register();
                      },
                      imageURL: "assets/images/bgImages/bgButton1.jpg",
                      height: 40.h,
                      width: 120.w,
                      buttonText: "Sign In",
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
