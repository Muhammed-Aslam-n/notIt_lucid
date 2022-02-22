import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          height: height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage(
                    "assets/images/bgImages/bg82.jpg",
                  ),
                  fit: BoxFit.cover)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.08,
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
                      height: height * 0.005,
                    ),
                    const CommonText(
                      text: "\t\tSign in to your account!",
                      size: 13.0,
                    ),
                    SizedBox(
                      height: height * 0.18,
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
                      controller: AuthController.authController.passwordController,
                      label: "Password",
                      obscureText: true,
                    ),
                    sizedh1,
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: GestureDetector(
                          onTap: (){
                            Get.to(const ScreenForgotPassword());
                          },
                          child: const Text("Forgott Password?",style: TextStyle(color: Colors.redAccent,decoration: TextDecoration.underline,fontSize: 12.5),)),
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
                          height: height * 0.065,
                          width: width * 0.35,
                          decoration: BoxDecoration(
                            borderRadius: tfRadius,
                            image: const DecorationImage(
                                opacity: 0.6,
                                image: ExactAssetImage(
                                  "assets/images/bgImages/bgButton1.jpg",
                                ),
                                fit: BoxFit.cover),),
                          child: const Center(
                              child: CommonText(
                                text: "Sign In",
                                color: Colors.white,
                                size: 22.0,
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account ? ",
                          style: TextStyle(
                              fontSize: 14.3, color: Colors.grey.shade600),
                          children: [
                            TextSpan(
                              text: "Create",
                              style: const TextStyle(
                                fontSize: 14.3,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  AuthController.authController.disposeLoginTextField();
                                  Get.toNamed('SignUpPage');
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
