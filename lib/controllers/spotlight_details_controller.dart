

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../api_config/api_services.dart';
import '../api_config/urls.dart';
import '../models/spotlight_listing_model.dart';

class SpotlightDetailsController extends GetxController{
  RxBool spotlightDetailsResponse = true.obs;
  Rx<SpotlightData?> spotlightData = SpotlightData().obs;

  void getSpotlightDetails(
      BuildContext context,
      int id
      ) {
    context.loaderOverlay.show();
    POST_API(
      {
        'spotlight_member_id':id
      }
    ,Urls.SpotlightDetails, context)
        .then((response) {
      print("EVENT LIST response ----> $response");
      Map<String, dynamic> map = jsonDecode(response);
      if (map["status"] != true) {
        spotlightDetailsResponse = false.obs;
      } else {
        SpotlightData spotlightModel = SpotlightData.fromJson(map["data"]);
        spotlightData.value = spotlightModel;
        print(spotlightModel);
      }
      context.loaderOverlay.hide();
    });
  }

  void sendSpotlightMail(BuildContext context, String mail, String content) {
    context.loaderOverlay.show();
    POST_API({
      "email": mail,
      "content": content,
      //"LoginProvider": ""
    }, Urls.SendSpotlightMail, context)
        .then((response) {
      Map<String, dynamic> spotlightResponse = jsonDecode(response);

      if (spotlightResponse['status'] != true) {
        context.loaderOverlay.hide();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(spotlightResponse['message'])));
      } else {
        context.loaderOverlay.hide();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Send Spot Light Mail Successfully.')));
        Get.back();
      }
    }, onError: (e) {
      context.loaderOverlay.hide();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    });
  }
}