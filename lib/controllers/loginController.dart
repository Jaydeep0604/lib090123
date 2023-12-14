import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:luxury_council/api_config/api_services.dart';
import 'package:luxury_council/colors.dart';
import 'package:luxury_council/config/prefrance.dart';
import 'package:luxury_council/models/login/LoginModel.dart';
import '../api_config/urls.dart';
import '../constance/firestore_constants.dart';

class LoginController extends GetxController {
  TextEditingController LoginEmailController = TextEditingController();
  TextEditingController LoginPasswordController = TextEditingController();
  var appuserid = 0.obs;
  var subscriptionid = 0.obs;
  var subscriptiontype= 0.obs;
  void login(BuildContext context, String firebaseToken) {
    POST_API({
      "email": LoginEmailController.text.toString(),
      "password": LoginPasswordController.text.toString(),
      //"LoginProvider": ""
    }, Urls.LOGIN, context)
        .then((response) {
      Map<String, dynamic> logindetails = jsonDecode(response);

      if (logindetails['status'] != true) {
        context.loaderOverlay.hide();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(logindetails['message'])));
      } else {
        LoginModel loginResponse = LoginModel.fromJson(jsonDecode(response));

        SetData("ApiToken", loginResponse.token ?? "");
        print("Token :-----> ${loginResponse.token}");
        SetData("Email", LoginEmailController.text.toString());
        SetData("Password", LoginPasswordController.text.toString());
        SetData("first_name", loginResponse.user?.firstName.toString() ?? '');
        SetData("last_name", loginResponse.user?.lastName.toString() ?? '');
        SetIntData("subscription_id", loginResponse.user?.subscriptionId ?? 0);
        SetIntData(
            "subscription_type", loginResponse.user?.subscriptionType ?? 0);
        SetIntData("app_user_id", loginResponse.user?.appUserId ?? 0);
        // print("Login Response ---> ${jsonEncode(loginResponse.loginUserDetails)}");
        final FirebaseFirestore firebaseFirestore;

        firebaseFirestore = FirebaseFirestore.instance;

        firebaseFirestore
            .collection(FirestoreConstants.pathUserCollection)
            .doc(loginResponse.user?.appUserId.toString())
            // .collection(FirestoreConstants.chatList)
            // .doc(firebaseUser.data?.uniqueId.toString())
            .set({
          FirestoreConstants.nickname:
              '${loginResponse.user?.firstName} ${loginResponse.user?.lastName}',
          FirestoreConstants.photoUrl: '',
          FirestoreConstants.id: loginResponse.user?.appUserId,
          FirestoreConstants.deviceToken: firebaseToken,
          'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
          FirestoreConstants.chattingWith: null
        });
        if (loginResponse.user!.subscriptionId == null) {
          SetIntData("subscriptionId", 0);
        } else {
          SetIntData("subscriptionId", loginResponse.user!.subscriptionId!);
        }

        appuserid.value = loginResponse.user!.appUserId ?? 0;
        print("appuserid-------- ${appuserid.value}");
        subscriptionid.value = loginResponse.user!.subscriptionId ?? 0;
        print("subscriptionid--------- ${subscriptionid.value}");
        subscriptiontype.value = loginResponse.user!.subscriptionType ?? 0;
        print("subscriptiontype---------- ${subscriptiontype.value}");
        context.loaderOverlay.hide();
        Get.back();
        if (loginResponse.user!.subscriptionId == null) {
          Get.toNamed("/HomeWithoutSignUp");
        } else {
          Get.toNamed("/HomeWithSignUp");
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          content: Text(
            'Login Successfully',
            style: TextStyle(color: AppColor.white),
          ),
        ));
        LoginEmailController.clear();
        LoginPasswordController.clear();
      }
    }, onError: (e) {
      context.loaderOverlay.hide();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    });
  }
}
