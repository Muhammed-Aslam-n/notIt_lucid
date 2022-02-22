import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tweeter_app_lucid/screen/authentication_actions/login/screen_login.dart';
import 'package:tweeter_app_lucid/screen/profile_screens/update_profile.dart';
import 'package:tweeter_app_lucid/screen/splash_screen/splashscreen.dart';

import 'controllers/auth_controller.dart';
import 'screen/authentication_actions/registration/screen_signup.dart';
import 'screen/home/screen_home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NoteIt - Make Yourself',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
        getPages: [
          GetPage(name: '/', page: () => const ScreenLogin()),
          GetPage(name: '/SignUpPage', page: () => const ScreenSignup()),
          GetPage(name: '/home', page: () => const ScreenHome()),
          GetPage(
              name: '/updateProfile', page: () => const ScreenUpdateProfile()),
          GetPage(
              name: '/forgotPassword', page: () => const ScreenUpdateProfile()),
        ],
      ),
    );
  }
}
