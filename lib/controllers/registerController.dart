import 'dart:convert';
import 'dart:developer' as Log;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:luxury_council/api_config/api_services.dart';
import 'package:luxury_council/api_config/urls.dart';
import 'package:luxury_council/config/prefrance.dart';
import '../colors.dart';

class RegisterController extends GetxController {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController companyontroller = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController phonenoController = TextEditingController();
  TextEditingController mailingaddressController = TextEditingController();
  TextEditingController assistantnameController = TextEditingController();
  TextEditingController assistantemailController = TextEditingController();
  TextEditingController assistantphonenoController = TextEditingController();
  var appuserstatusController = 1.obs;
  var subscriptionstartdateController = ''.obs;

  void Register(BuildContext context) async {
    //  context.loaderOverlay.show();
    // RegisterModel registerRequest = RegisterModel(
    //     user: User(
    //   firstName: firstnameController.text,
    //   lastName: lastnameController.text,
    //   email: emailController.text,
    //   password: passwordController.text,
    //   company: companyontroller.text,
    //   title: titleController.text,
    //   phoneNo: phonenoController.text,
    //   mailingAddress: mailingaddressController.text,
    //   assistantEmail: assistantemailController.text,
    //   assistantPhoneNo: assistantphonenoController.text,
    //   subscriptionId: subscriptionidController.text,
    //   subscriptionType: subscriptiontypeController.text,
    //   appUserStatus: appuserstatusController.text,
    //   subscriptionStartDate: subscriptionstartdateController.text,
    // ));

    // print(" register Url ---> ${Urls.REGISTER}");

    Object registerrequest = {
      "first_name": firstnameController.value.text,
      "last_name": lastnameController.value.text,
      "email": emailController.value.text,
      "password": passwordController.value.text,
      "company": companyontroller.value.text,
      "title": titleController.value.text,
      "phone_no": phonenoController.value.text,
      "mailing_address": mailingaddressController.value.text,
       "assistant_name": assistantnameController.value.text,
      "assistant_Email": assistantemailController.value.text,
      "assistant_phone_no": assistantphonenoController.value.text,
      // "subscription_id":subscriptionidController.value,
      // "subscription_type": subscriptiontypeController.value,
      "app_user_status": appuserstatusController.value,
      "subscription_start_date": subscriptionstartdateController.value,
    };
    print("register Body Request ---> ${jsonEncode(registerrequest)}");
    POST_API(registerrequest, Urls.REGISTER, context).then((response) {
      context.loaderOverlay.hide();
      Navigator.pop(context);
      Log.log("Register response ---> $response");
      Map<String, dynamic> registerdetails = jsonDecode(response);
      if (registerdetails["status"] != true) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(registerdetails["message"]), 
        ));
      } else {
        SetData("Email", emailController.text.toString());
        SetData("Password", passwordController.text.toString());
        SetData("first_name", firstnameController.text.toString());
        SetData("last_name", lastnameController.text.toString());
        SetData("company", companyontroller.text.toString());
        SetData("title", titleController.text.toString());
        SetData("phone_no", phonenoController.text.toString());
        SetData("mailing_address", mailingaddressController.text.toString());
        SetData("assistant_name", assistantnameController.text.toString());
        SetData("assistant_email", assistantemailController.text.toString());
        SetData(
            "assistant_phone_no", assistantphonenoController.text.toString());
        // SetData("subscription_id", subscriptionidController.value.toString());
        // SetData(
        //     "subscription_type", subscriptiontypeController.value.toString());
        SetData("app_user_status", appuserstatusController.value.toString());
        SetData("subscription_start_date",
            subscriptionstartdateController.value.toString());
            

        // firstnameController.clear();
        // lastnameController.clear();
        // emailController.clear();
        // passwordController.clear();
        // companyontroller.clear();
        // titleController.clear();
        // phonenoController.clear();
        // mailingaddressController.clear();
        // assistantemailController.clear();
        // assistantphonenoController.clear();
        // subscriptionidController.clear();
        // subscriptiontypeController.clear();
        // appuserstatusController.clear();
        // subscriptionstartdateController.clear();
        context.loaderOverlay.hide();
        Get.back();
        Get.offAndToNamed(
          "/Login",
        );
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          content: Text(
            'Register Successfully',
            style: TextStyle(color: AppColor.white),
          ),
        ));
      }
    }, onError: (error) {
      Get.back();
      print("RegisterError ---> ${error}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
      ));
      context.loaderOverlay.hide();
    });
  }
}
