import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tweeter_app_lucid/constants/constants.dart';
import 'package:tweeter_app_lucid/controllers/auth_controller.dart';
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
                    CommonHeaders(
                      text: "Sign Up\t",
                      size: 56.0.sp,
                      color: Colors.black,
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
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          debugPrint("SignUp Button Clicked");
                          AuthController.authController.register();
                        },
                        child: Container(
                          height: 40.h,
                          width: 120.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: tfRadius,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade500,
                                spreadRadius: 0.5,
                                blurRadius: 2
                              )
                            ]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: Center(
                              child: CommonText(
                                text: "Sign In",
                                color: Colors.grey.shade800,
                                size: 23.0.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
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
