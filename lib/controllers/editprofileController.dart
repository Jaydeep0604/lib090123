import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:luxury_council/api_config/api_services.dart';
import 'package:luxury_council/colors.dart';
import 'package:luxury_council/config/prefrance.dart';
import 'package:luxury_council/controllers/loginController.dart';
import 'package:luxury_council/controllers/registerController.dart';
import '../api_config/urls.dart';

class EditProfileController extends GetxController {
  final registercontroller = Get.put(RegisterController());
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController phonenoController = TextEditingController();
  TextEditingController mailingaddressController = TextEditingController();
  TextEditingController assistantnameController = TextEditingController();
  TextEditingController assistantemailController = TextEditingController();
  TextEditingController assistantphonenoController = TextEditingController();
  var firstname = ''.obs;
  var lastname = ''.obs;
  var title = ''.obs;
  var subscriptionyear = ''.obs;
  var subscriptionmonth = ''.obs;
  var startdate = ''.obs;
  var enddate = ''.obs;
  Future<void> checkdata() async {
    int subsId = await GetIntData("subscriptionId");
    print("objectobjectobjectobject------${subsId}");

    if (subsId == 0) {
      Get.toNamed("/HomeWithoutSignUp");
    } else {
      Get.toNamed("/HomeWithSignUp");
    }
  }

  LoginController loginController = Get.put(LoginController());

  void editprofile(BuildContext context) {
    POST_API({
      "first_name": firstnameController.text.toString(),
      "last_name": lastnameController.text.toString(),
      "email": emailController.text.toString(),
      "company": companyController.text.toString(),
      "title": titleController.text.toString(),
      "phone_no": phonenoController.text.toString(),
      "mailing_address": mailingaddressController.text.toString(),
      "assistant_name": assistantnameController.text.toString(),
      "assistant_email": assistantemailController.text.toString(),
      "assistant_phone_no": assistantphonenoController.text.toString(),
    }, Urls.Edit_Profile, context)
        .then((response) {
      Map<String, dynamic> editprofileResponse = jsonDecode(response);

      if (editprofileResponse['status'] != true) {
        context.loaderOverlay.hide();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(editprofileResponse['message'])));
      } else {
        context.loaderOverlay.hide();
        getprofile(context);
        checkdata();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          content: Text(
            'Profile Updated Successfully',
            style: TextStyle(color: AppColor.white),
          ),
        ));
        // registercontroller.Register(context);

        firstnameController.clear();
        lastnameController.clear();
        emailController.clear();
        companyController.clear();
        titleController.clear();
        phonenoController.clear();
        mailingaddressController.clear();
        assistantnameController.clear();
        assistantemailController.clear();
        assistantphonenoController.clear();
      }
    }, onError: (e) {
      context.loaderOverlay.hide();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    });
  }

  void getprofile(BuildContext context) {
    GET_API(Urls.GET_Profile, context).then((response) {
      Map<String, dynamic> getprofileResponse = jsonDecode(response);
      print("=========================${getprofileResponse}");
      if (getprofileResponse['status'] != true) {
        context.loaderOverlay.hide();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(getprofileResponse['message'])));
      } else {
        context.loaderOverlay.hide();
        firstnameController.text =
            getprofileResponse["data"]["first_name"].toString();
        lastnameController.text =
            getprofileResponse["data"]["last_name"].toString();
        emailController.text = getprofileResponse["data"]["email"].toString();
        companyController.text =
            getprofileResponse["data"]["company"]["company_name"].toString();
        titleController.text = getprofileResponse["data"]["title"].toString();
        phonenoController.text =
            getprofileResponse["data"]["phone_no"].toString();
        mailingaddressController.text =
            getprofileResponse["data"]["mailing_address"].toString();
        if (getprofileResponse["data"]["assistant_name"] != null) {
          assistantnameController.text =
              getprofileResponse["data"]["assistant_name"].toString();
        } else {
          assistantnameController.text = "";
        }

        if (getprofileResponse["data"]["assistant_email"] != null) {
          assistantemailController.text =
              getprofileResponse["data"]["assistant_email"].toString();
        } else {
          assistantemailController.text = "";
        }
        if (getprofileResponse["data"]["assistant_phone_no"] != null) {
          assistantphonenoController.text =
              getprofileResponse["data"]["assistant_phone_no"].toString();
        } else {
          assistantphonenoController.text = "";
        }

        firstname.value = getprofileResponse["data"]["first_name"].toString();
        lastname.value = getprofileResponse["data"]["last_name"].toString();
        title.value = getprofileResponse["data"]["title"].toString();
        if(getprofileResponse["data"]["subscription"].isNotEmpty){
            subscriptionyear.value = getprofileResponse["data"]["subscription"]
                ["subscription_price_per_year"]
            .toString();
        subscriptionmonth.value = getprofileResponse["data"]["subscription"]
                ["subscription_price_per_month"]
            .toString();
        }
        if(getprofileResponse["data"]["subscription_start_date"]!=null){
          startdate.value =
            getprofileResponse["data"]["subscription_start_date"].toString();
        enddate.value =
            getprofileResponse["data"]["subscription_end_date"].toString();
        }
        
        //  registercontroller.Register(context);

        // firstnameController.clear();
        // lastnameController.clear();
        // emailController.clear();
        // companyController.clear();
        // titleController.clear();
        // phonenoController.clear();
        // mailingaddressController.clear();
        // assistantnameController.clear();
        // assistantemailController.clear();
        // assistantphonenoController.clear();
      }
    }, onError: (e) {
      context.loaderOverlay.hide();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    });
  }
}
