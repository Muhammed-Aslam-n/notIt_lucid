import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tweeter_app_lucid/model/tweet_model.dart';
import 'package:tweeter_app_lucid/model/user_model.dart';
import 'package:tweeter_app_lucid/screen/authentication_actions/login/screen_login.dart';
import 'package:tweeter_app_lucid/screen/home/screen_home.dart';

class AuthController extends GetxController {
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
    super.onReady();
  }

  callToNavigate() {
    // our user will be notified whenever a change is made
    _user.bindStream(firebaseAuth.userChanges());
    ever(_user, _initialScreen);
  }

  String? domainName; // String to hold the username extracted from the email ( domain of email ), used to store profile pictures and collection using this value

  _initialScreen(User? user) {
    // function which listens changes to current state of user (logged or not ) and navigates to respective pages
    if (user == null) {
      Get.offAll(() => const ScreenLogin());
    } else {
      Get.offAll(() => const ScreenHome());
      userName = user.email;
      domainName = userName!.substring(
          0, userName?.lastIndexOf("@"));
      userName = user.email;
      readUsers();
      getProfilePic();
    }
  }

  void register() async {
    // Function to Register to firebase using their email and Password as Credentials
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      disposeLoginTextField();
    } catch (error) {
      snackBar(error,
          title: "Account Creation failed"); // snackbar to show error occurred
    }
  }

  void userLogin() async {
    // Function to Login to Tweet with already registered credentials
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      disposeLoginTextField();
    } catch (error) {
      snackBar(error, title: "Login Failed"); // snackbar to show error occurred
    }
  }
// Method to reset the user's password as forgott password
  Future<void> resetPasswordUsingEmail() async {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF3b4254),
          strokeWidth: 0.3,
        ),
      ),
    );
    try {
      await firebaseAuth.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      snackBar(
        "Reset link has been sent to your email",
        title: "Reset Password",
        duration: 3,
      );
      disposeLoginTextField();
      Get.offAll(const ScreenLogin());
    } on FirebaseAuthException catch (exception) {
      debugPrint(exception.toString());
      disposeLoginTextField();
    }
  }

  Future<void> signOut() async {
    // Method to Sign out user When they need to..
    await firebaseAuth.signOut();
    currentProfilePicture =
        null; //  makes null to not to display previous user profile in any case
    disposeLoginTextField();
  }

  /*
                                            Profile Picture integration
  ---------------------------------------------------------------------------------------------------------------------
  * This section is used for all the methods used to select, upload the New Profile Pictures and display updated profile
  * in realtime to UI.
  *
  * updateProfile () -> Used to notify currentProfilePicture whenever image path is changed
  *
  * getProfilePic() -> Used to Fetch Profile Picture path to club to UI
  *
  * chooseFile() -> Used to Select a profile picture from user's internal memory and saves path to
  *  imageFilePath variable and calls UpdateProfile fn to notify UI about the change
  *
  * uploadFile() -> Main objective of this method is to upload the selected file to respective firebase storage
  *                 ( putFile() method of firebase helps to upload the selected file , 'profile_picture/$domainName/$domainName'
  *                   is used to store the file in structured way like profile_picture/johnDoe/johnDoe.extension , getDownloadURL()
  *                   helps to get the network url to display in UI )
  *  */

  File? imageFilePath; // stores the file path of image from internal storage
  String? currentProfilePicture;
  String? pUrl = "".obs();

  updateProfile() {
    currentProfilePicture = pUrl;
    update(["profileArea", "homeProfileArea"]);
  }

  Future getProfilePic() async {
    final storage =
        FirebaseStorage.instance.ref("profile_picture/$domainName/$domainName");

    try {
      await storage.getDownloadURL().then((value) =>
          {value.isEmpty ? pUrl = null : pUrl = value, updateProfile()});
    } catch (error) {
      debugPrint("Object don't Exists");
    }
  }

  Future chooseFile() async {
    await ImagePicker().pickImage(source: ImageSource.gallery).then(
      (image) {
        imageFilePath = File(image!.path);
      },
    ).then((value) => uploadFile());
    updateProfile();
  }

  Future uploadFile() async {
    var storageReference = FirebaseStorage.instance
        .ref()
        .child('profile_picture/$domainName/$domainName');
    var uploadTask = storageReference.putFile(imageFilePath!);
    await uploadTask.whenComplete(
      () => storageReference.getDownloadURL().then(
        (fileUrl) {
          pUrl = fileUrl;
        },
      ),
    );
    debugPrint("Upload Image Function Completed");
  }

  /*
  *                                        FireStore Section
  * ------------------------------------------------------------------------------------------
  */

  final fireStoreDb = FirebaseFirestore.instance;

  //Controller used to hold user's new tweets to post
  TextEditingController userTweets = TextEditingController();
  TextEditingController userNameOriginal = TextEditingController();
  String? dateTime;

  setTextEditingControllers({tweet, dateTime}) {
    userTweets.text = tweet;
    this.dateTime = dateTime;
  }

  TextEditingController userNameController = TextEditingController(text: "Aslam n");
  TextEditingController userPhoneController = TextEditingController(text: "1234567891");

  String? registeredUserName,registeredPhone;

  addUserDetails() async {
    final userDetailsDocument = fireStoreDb
        .collection("NoteIt")
        .doc(userName ?? 'errorCollections')
        .collection("userDetails")
        .doc(userName ?? 'errorData');
    final userTweet = UserDetailsModel(
      id: userDetailsDocument.id,
      name: userNameController.text,
      phoneNumber: userPhoneController.text,
    );
    final userDetailsToUpload = userTweet.toJson();
    await userDetailsDocument.set(userDetailsToUpload);
    registeredUserName = userNameController.text;
    registeredPhone = userPhoneController.text;
    update(["user-profile"]);
  }
  readUsers() async {
    try {
      var userDocument = await fireStoreDb
          .collection("NoteIt")
          .doc(userName ?? 'errorCollections')
          .collection("userDetails")
          .get();
      var result = userDocument.docs.last.data();
      userNameController.text = result['userName'];
      userPhoneController.text = result['phoneNumber'];
      registeredUserName = result['userName'];
      registeredPhone = result['phoneNumber'];
    } catch (error) {
      disposeUserControllers();
      registeredUserName = "Add username";
      registeredPhone = "Add Phone number";
    }
    update(["user-profile"]);
  }
  updateUserDetails() async {
    final userDetailsDocument = fireStoreDb
        .collection("NoteIt")
        .doc(userName ?? 'errorCollections')
        .collection("userDetails")
        .doc(userName ?? 'errorData');
    final userTweet = UserDetailsModel(
      id: userDetailsDocument.id,
      name: userNameController.text,
      phoneNumber: userPhoneController.text,
    );
    final userDetailsToUpload = userTweet.toJson();
    await userDetailsDocument.update(userDetailsToUpload);
    disposeTweetTextField();
    update(["user-profile"]);
  }

  bool isUpdating = false.obs();

  addUserTweet() async {
    final dateTime = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());

    final userTweetDocument = fireStoreDb
        .collection("NoteIt")
        .doc(userName ?? 'errorCollections')
        .collection("userTweet")
        .doc(dateTime);
    final tweetData = UserTweetModel(
      id: userTweetDocument.id,
      tweet: userTweets.text,
      dateTime: dateTime,
    );
    final tweetToUpload = tweetData.toJson();
    await userTweetDocument.set(tweetToUpload);
    disposeTweetTextField();
  }

  dynamic updatingTweetId;

  updateTweet(dynamic id) {
    final dateTime = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
    final userTweetDocument = fireStoreDb
        .collection("NoteIt")
        .doc(userName ?? 'errorCollections')
        .collection("userTweet")
        .doc(id.toString());
    final tweetData = UserTweetModel(
        id: userTweetDocument.id, tweet: userTweets.text, dateTime: dateTime);
    final tweetToUpload = tweetData.toJson();
    userTweetDocument.update(tweetToUpload);
    updatingTweetId = '';
    isUpdating = false;
    disposeTweetTextField();
  }

  deleteTweet({required dynamic tweetId}) {
    final userTweetDocument = fireStoreDb
        .collection("NoteIt")
        .doc(userName ?? 'errorCollections')
        .collection("userTweet")
        .doc(tweetId);
    userTweetDocument.delete();
  }

  Stream<List<UserTweetModel>> fetchTweets() {
    return fireStoreDb
        .collection("NoteIt")
        .doc(userName ?? 'errorCollections')
        .collection("userTweet").orderBy('time',descending: true)
        .snapshots()
        .map(
      (snapShot) {
        return snapShot.docs.map(
          (doc) {
            return UserTweetModel.fromJson(doc.data());
          },
        ).toList();
      },
    );
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

  disposeTweetTextField() {
    userTweets.clear();
  }

  disposeLoginTextField() {
    emailController.clear();
    passwordController.clear();
  }

  disposeUserControllers() {
    userNameController.clear();
    userPhoneController.clear();
  }

  @override
  void dispose() {
    userTweets.dispose();
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    userPhoneController.dispose();
    super.dispose();
  }
}
