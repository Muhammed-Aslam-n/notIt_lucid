import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tweeter_app_lucid/screen/authentication_actions/login/screen_login.dart';
import 'package:tweeter_app_lucid/screen/home/screen_home.dart';

class  AuthController extends GetxController{
  static AuthController authController = Get.find();

  // User class is from Firebase which includes Email,password,name ....

  late Rx<User?> _user;

// TextEditing controllers which holds the data entered into respective TextForm Fields
  TextEditingController emailController = TextEditingController().obs();
  TextEditingController passwordController = TextEditingController().obs();

  // Firebase Authentication Instance used to access the Firebase console curresponding to this Project

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // String to hold the username temporarily
  String? userName;

  @override
  void onReady() {
    _user = Rx<User?>(firebaseAuth.currentUser);
    // our user will be notified whenever a change is made
    _user.bindStream(firebaseAuth.userChanges());
    ever(_user, _initialScreen);
    super.onReady();
  }

  String?
  domainName; // String to hold the username extracted from the email ( domain of email ), used to store profile pictures and collection using this value

  _initialScreen(User? user) {
    // function which listens changes to current state of user (logged or not ) and navigates to respective pages
    if (user == null) {
      Get.offAll(() => const ScreenLogin()); // login page of SchoLoger
    } else {
      Get.offAll(() => const ScreenHome()); // Home of SchoLoger
      userName = user.email;
      domainName = userName!.substring(
          0, userName?.lastIndexOf("@")); // converts domain name from email
     // getProfilePic(); // Function  to show the User's Profile picture
    }
  }

  void userLogin() async {
    // Function to Login to SchoLoger with already registered credentials
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      disposeLoginTextField();
    } catch (error) {
      snackBar(error, title: "Login Failed"); // snackbar to show error occurred
    }
  }






  snackBar(error, {title, color, duration}) {
    Get.snackbar(
      "",
      "",
      backgroundColor: color ?? Colors.redAccent,
      duration: Duration(seconds: duration ?? 1),
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      snackPosition: SnackPosition.BOTTOM,
      titleText: Text(
        title ?? '',
        style: const TextStyle(color: Colors.white),
      ),
      messageText: Text(
        error.toString(),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
  disposeLoginTextField() {
    emailController.clear();
    passwordController.clear();
  }

}