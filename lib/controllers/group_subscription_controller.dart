
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:luxury_council/api_config/api_services.dart';
import '../api_config/urls.dart';

class GroupSubscriptionController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController numOfSubscription = TextEditingController();
  TextEditingController startDate = TextEditingController();
  RxString subscriptionType = ''.obs;

  void groupSubscription(BuildContext context) {
    POST_API({
      "company_name": companyNameController.text.toString(),
      "contact_name": nameController.text.toString(),
      "email": emailController.text.toString(),
      "phone_no": phoneNumberController.text.toString(),
      "title": titleController.text.toString(),
      "number_of_subscription": numOfSubscription.text.toString(),
      "subscription_type": subscriptionType.value,
      "subscription_start_date": startDate.text.toString(),
    }, Urls.GroupSubscription, context)
        .then((response) {
      Map<String, dynamic> subscriptionResponse = jsonDecode(response);

      if (subscriptionResponse['status'] != true) {
        context.loaderOverlay.hide();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(subscriptionResponse['message'])));
      } else {

        context.loaderOverlay.hide();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Group subscription added successfully.')));
        Get.toNamed("/HomeWithSignUp");

        emailController.clear();
        nameController.clear();
        phoneNumberController.clear();
        companyNameController.clear();
        titleController.clear();
        numOfSubscription.clear();
        startDate.clear();
        subscriptionType = ''.obs;
      }
    }, onError: (e) {
      context.loaderOverlay.hide();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    });
  }
}
