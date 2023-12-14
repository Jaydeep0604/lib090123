import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luxury_council/colors.dart';
import 'package:luxury_council/config/prefrance.dart';
import 'package:luxury_council/controllers/loginController.dart';
import 'package:luxury_council/screens/login.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const splashScreen = "splashscreen";


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _firebaseMessaging = FirebaseMessaging.instance;
  String firebaseToken ='';
  // void initState() {
  //   super.initState();
  //   Timer(
  //       Duration(seconds: 2),
  //       () =>Get.offAndToNamed("/Login"));
  // }

final LoginController loginController = Get.put(LoginController());
  late VideoPlayerController _videoPlayerController;
   @override
  void initState() {
     _firebaseMessaging.getToken().then((value) {
       setState(() {
         firebaseToken = value ?? '';
         print('fffff $firebaseToken');
       });
     });
    super.initState();

 _videoPlayerController =
        VideoPlayerController.asset('assets/splashvideo.mp4')
          ..initialize().then((_) {
            setState(() {});
            _videoPlayerController.play();
          });
    Future.delayed(
        Duration(
          seconds: 1,
        ), () {
     
      GetData("Email")
          .then((a) => a == null ? Get.offAndToNamed('/Login') : checkdata());
    });
  }
  Future<void> checkdata() async {
    int subsId = await GetIntData("subscriptionId");
    print("objectobjectobjectobject------${subsId}");

     if (subsId == 0) {
          Get.offAndToNamed("/HomeWithoutSignUp");
        } else {
          Get.offAndToNamed("/HomeWithSignUp");
        }
  }


  void call(String email) {
    loginController.LoginEmailController.text = email;
    GetData("Password").then((a) {
      loginController.LoginPasswordController.text = a;
      print("Email -->${loginController.LoginEmailController.text}");
      print("Password -->${loginController.LoginPasswordController.text}");
      loginController.login(context,firebaseToken);
    });
  }
  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 250,
              color: AppColor.white,
              child: VideoPlayer(_videoPlayerController),
            ),
          ],
        ));
  }
}
