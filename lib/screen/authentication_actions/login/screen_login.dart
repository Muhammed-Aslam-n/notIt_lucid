import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../../../controllers/auth_controller.dart';
import '../../../widgets/common_headers.dart';
import '../../../widgets/common_text.dart';
import '../../../widgets/common_textfield.dart';
import '../recovery/screen_forgotpassword.dart';

class ScreenLogin extends StatelessWidget {
  const ScreenLogin({Key? key}) : super(key: key);

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
              SizedBox(
                height: 60.h,
              ),
              Container(
                margin: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CommonHeaders(
                      text: "Hello!",
                      color: Colors.black,
                      size: 62.0,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    CommonText(
                      text: "\t\tSign in to your account!",
                      size: 13.0.sp,
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                    CommonTextField(
                      prefixIcon: const Icon(Icons.email),
                      controller: AuthController.authController.emailController,
                      label: "Email",
                    ),
                    sizedh2,
                    sizedh2,
                    CommonTextField(
                      prefixIcon: const Icon(Icons.lock),
                      controller:
                          AuthController.authController.passwordController,
                      label: "Password",
                      obscureText: true,
                    ),
                    sizedh1,
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(const ScreenForgotPassword());
                        },
                        child: Text(
                          "Forgott Password?",
                          style: TextStyle(
                            color: Colors.redAccent,
                            decoration: TextDecoration.underline,
                            fontSize: 12.5.sp,
                          ),
                        ),
                      ),
                    ),
                    sizedh2,
                    sizedh2,
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          debugPrint("Login Button Clicked");
                          AuthController.authController.userLogin();
                          AuthController.authController.disposeLoginTextField();
                        },
                        child: Container(
                          height: 40.h,
                          width: 120.w,
                          decoration: BoxDecoration(
                            borderRadius: tfRadius,
                            image: const DecorationImage(
                                opacity: 0.6,
                                image: ExactAssetImage(
                                  "assets/images/bgImages/bgButton1.jpg",
                                ),
                                fit: BoxFit.cover),
                          ),
                          child: const Center(
                            child: CommonText(
                              text: "Sign In",
                              color: Colors.white,
                              size: 22.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 110.h,
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account ? ",
                          style: TextStyle(
                            fontSize: 14.3.sp,
                            color: Colors.grey.shade600,
                          ),
                          children: [
                            TextSpan(
                              text: "Create",
                              style: TextStyle(
                                fontSize: 14.3.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed('SignUpPage');
                                  AuthController.authController
                                      .disposeLoginTextField();
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
