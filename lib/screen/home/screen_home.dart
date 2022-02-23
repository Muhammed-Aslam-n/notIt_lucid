import 'dart:math';
import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:get/get.dart';
import 'package:tweeter_app_lucid/constants/constants.dart';
import 'package:tweeter_app_lucid/controllers/auth_controller.dart';
import 'package:tweeter_app_lucid/model/tweet_model.dart';
import 'package:tweeter_app_lucid/widgets/common_text.dart';
import 'package:tweeter_app_lucid/widgets/data_text_field.dart';
import 'package:tweeter_app_lucid/widgets/default_profiledisplay_widget.dart';
import 'package:tweeter_app_lucid/widgets/home_instruction_widget.dart';
import 'package:tweeter_app_lucid/widgets/profile_display_widget.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: appBarGradient),
      child: BackdropScaffold(
        backgroundColor: Colors.transparent,
        appBar: BackdropAppBar(
          backgroundColor: Colors.transparent,
          actions: [
            popupMenus(),
          ],
        ),
        backLayerBackgroundColor: Colors.transparent,
        backLayer: Center(
          child: Column(
            children: [
              SizedBox(
                height: 15.h,
              ),
              GetBuilder<AuthController>(
                id: "profileArea",
                builder: (controller) => Stack(
                  children: [
                    controller.currentProfilePicture != null
                        ? UserProfileDisplayWidget(
                            networkImageURl:
                                controller.currentProfilePicture ?? '',
                          )
                        :
                    const DefaultProfileDisplayWidget(),
                    Positioned(
                      bottom: 8,
                      right: 1,
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Center(
                          child: IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              debugPrint("Edit Icon Pressed");
                              controller.chooseFile();
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              GetBuilder<AuthController>(
                id: "user-profile",
                builder: (controller) {
                  return Text(
                    controller.registeredUserName ?? 'Name not Found',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              GetBuilder<AuthController>(
                id: "user-profile",
                builder: (controller) {
                  return Text(
                    controller.registeredPhone ?? 'Phone number not Found',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: () {
                        updateUserDetails(context);
                      },
                      icon: const Icon(
                        Icons.edit_outlined,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.h,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(onPressed: (){
                      Get.snackbar(
                        "Share",
                        "Can't share App in this Stage",
                        snackPosition: SnackPosition.BOTTOM,
                        padding: const EdgeInsets.all(18),
                        margin: const EdgeInsets.all(18),
                        colorText: Colors.green,
                      );
                    }, icon: const Icon(Icons.share_outlined)),
                  ),
                ],
              )
            ],
          ),
        ),
        headerHeight: 300,
        frontLayer: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              debugPrint("Create new Tweet button Clicked");
              Get.toNamed('/createTweet');
            },
            child: const Icon(Icons.add),
            backgroundColor: Colors.redAccent,
          ),
          body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: CommonText(
                        text: "Your Tweets",
                        size: 18.sp,
                        weight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Flexible(
                      child: StreamBuilder<List<UserTweetModel>>(
                        stream: AuthController.authController.fetchTweets(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                                child: Text("Something went wrong!"));
                          } else if (snapshot.hasData) {
                            final tweets = snapshot.data;
                            return ListView(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              children: tweets!.isEmpty
                                  ? [const HomeInstructionWidget()]
                                  : tweets.map(buildTweets).toList(),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.redAccent,
                                strokeWidth: 0.3,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),),
        ),
      ),
    );
  }

  Widget buildTweets(UserTweetModel tweet) {
    int randomNumber = 1 + Random().nextInt(100 - 1);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () {
          showDeleteConfirmation();
        },
        child: Slidable(
          closeOnScroll: true,
          key: UniqueKey(),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (f) {
                  confirmDeletion(studentId: tweet.id);
                },
                backgroundColor: const Color(0xFF424b5e),
                foregroundColor: Colors.redAccent,
                icon: Icons.delete,
              ),
              SlidableAction(
                onPressed: (f) {
                  AuthController.authController.setTextEditingControllers(
                      tweet: tweet.tweet, dateTime: tweet.dateTime);
                  AuthController.authController.isUpdating = true;
                  AuthController.authController.updatingTweetId = tweet.id;
                  Get.toNamed('/createTweet');
                },
                backgroundColor: const Color(0xFF424b5e),
                foregroundColor: Colors.green,
                icon: Icons.edit,
              ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 10.0,
                  offset: const Offset(2, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: tweet.tweet,
                  color: Colors.grey.shade700,
                  weight: FontWeight.w600,
                ),
                SizedBox(
                  height: 25.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Linecons.comment),
                    SizedBox(
                      width: 5.w,
                    ),
                    CommonText(
                      text: randomNumber.toString(),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: CommonText(
                          text: tweet.dateTime?.split(" ")[0],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  confirmDeletion({required studentId}) async {
    await Get.defaultDialog(
      title: "Delete",
      middleText: "Do you really want to delete ?",
      radius: 15,
      textCancel: "No",
      textConfirm: "Yes",
      onCancel: () {},
      onConfirm: () {
        AuthController.authController.deleteTweet(tweetId: studentId);
        Future.delayed(const Duration(seconds: 1))
            .whenComplete(() => showDeleteConfirmation());
        Get.back();
      },
      barrierDismissible: true,
    );
  }

  showDeleteConfirmation() {
    Get.snackbar(
      "Delete",
      "Deleted Successfully ✓",
      snackPosition: SnackPosition.BOTTOM,
      padding: const EdgeInsets.all(18),
      margin: const EdgeInsets.all(18),
      colorText: Colors.green,
    );
  }

  updateUserDetails(BuildContext context) {
    AuthController.authController.readUsers();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    Get.bottomSheet(
      GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Form(
          key: formKey,
          child: SizedBox(
            height: 350.h,
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  const Icon(
                    Icons.person_add_alt_1,
                    color: Color(0xFF252942),
                    size: 43,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  AuthTextField(
                    minLength: 2,
                    controller:
                        AuthController.authController.userNameController,
                    textInputType: TextInputType.name,
                    prefixIcon: Icons.person,
                    validator: (name) {
                      if (name!.isEmpty || name.length < 3) {
                        return "Name Required";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  AuthTextField(
                    minLength: 2,
                    controller:
                        AuthController.authController.userPhoneController,
                    textInputType: TextInputType.phone,
                    obscureText: true,
                    prefixIcon: Icons.phone,
                    validator: (phone) {
                      if (phone!.isEmpty || phone.length < 10) {
                        return "Phone number Required";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await AuthController.authController.addUserDetails();
                        Get.back();
                        await AuthController.authController.snackBar(
                          "Updated Successfully",
                          color: Colors.green,
                        );
                        AuthController.authController.disposeUserControllers();
                      }
                    },
                    child: const Text("Save"),
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF252942),
                      fixedSize: const Size(80, 40),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      enableDrag: true,
      isDismissible: true,
      isScrollControlled: true,
    );
  }

  popupMenus() {
    return PopupMenuButton(
      color: Colors.white.withOpacity(0.5),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: TextButton(
            onPressed: () {
              Get.back();
              AuthController.authController.signOut();
            },
            child: const Text(
              "Logout",
              style: TextStyle(color: Colors.black),
            ),
          ),
          value: 1,
        ),
      ],
    );
  }
}
