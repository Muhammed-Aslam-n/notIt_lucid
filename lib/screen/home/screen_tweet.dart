import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tweeter_app_lucid/controllers/auth_controller.dart';

class ScreenTweet extends StatelessWidget {
  ScreenTweet({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(CupertinoIcons.bubble_left),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        'Tweet',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                  minHeight: 300.h
                                ),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 40,left: 20,bottom: 20,right: 20),
                                    child: Form(
                                      key: _formKey,
                                      child: TextFormField(
                                        controller: AuthController.authController.userTweets,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(280),
                                        ],
                                        validator: (tweet){
                                          if(tweet == ""){
                                            return "Tweet must not be Empty";
                                          }else{
                                            return null;
                                          }
                                        },
                                        maxLines: null,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Share what\'s on your mind',
                                          hintStyle: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      debugPrint("New Tweet Button Clicked");
                                      validateAndSave(_formKey, updateId: AuthController.authController.updatingTweetId);
                                      if(_formKey.currentState!.validate()){
                                        debugPrint("Posting New Tweet ...");
                                      }else{
                                        return;
                                      }
                                    },
                                    child: Text(
                                      "Post",
                                      style:
                                          TextStyle(color: Colors.grey.shade700),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void validateAndSave(formKey, {updateId}) async {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      AuthController.authController.isUpdating
          ? await AuthController.authController.updateTweet(updateId)
          : await AuthController.authController.addUserTweet();
      Get.back();
    }
  }
}
