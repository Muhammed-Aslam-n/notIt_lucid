import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tweeter_app_lucid/controllers/auth_controller.dart';
import 'package:tweeter_app_lucid/widgets/auth_button.dart';
import 'package:tweeter_app_lucid/widgets/common_headers.dart';
import 'package:tweeter_app_lucid/widgets/common_text.dart';
import 'package:tweeter_app_lucid/widgets/common_textfield.dart';

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
                    SizedBox(
                      height: 40.h,
                    ),
                    CommonTextField(
                      prefixIcon: const Icon(Icons.lock),
                      controller:
                          AuthController.authController.passwordController,
                      label: "Password",
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: TextButton(
                          onPressed: () {
                            Get.toNamed("/forgotPassword");
                          },
                          child: Text(
                            "Forgott Password?",
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 12.5.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    AuthenticationButton(
                      onTap: () {
                        debugPrint("Login Button Clicked");
                        AuthController.authController.userLogin();
                        AuthController.authController.disposeLoginTextField();
                      },
                      imageURL: "assets/images/bgImages/bgButton1.jpg",
                      height: 40.h,
                      width: 120.w,
                      buttonText: "Login",
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
