
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../api_config/api_services.dart';
import '../api_config/urls.dart';
import '../colors.dart';
import '../models/spotlight_listing_model.dart';

class SpotlightListingController extends GetxController{
  RxBool spotlightListResponse = true.obs;
  RxList<SpotlightData> spotlightListing= <SpotlightData>[].obs;
  RxBool isLoading = false.obs;
  RxBool isLastPage = false.obs;

  void getSpotlightListing(BuildContext context, int page) {
    if(page==1){
      context.loaderOverlay.show();
    }
    POST_API({
      "page": page,
      "limit": 20,
    }, Urls.SpotlightListing, context)
        .then((response) {
      Map<String, dynamic> spotlightResponse = jsonDecode(response);

      if (spotlightResponse["data"].isEmpty) {
        context.loaderOverlay.hide();
        spotlightListing.clear();
        isLoading = false.obs;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'No Data Found',
            style: TextStyle(color: AppColor.white),
          ),
        ));
      } else {
        if (spotlightResponse['status'] != true) {
          spotlightListResponse= false.obs;
        } else {
          SpotlightListingModel spotlightListingModel = SpotlightListingModel.fromJson(jsonDecode(response));
          spotlightListing.addAll(spotlightListingModel.data?.items ?? []);
          isLastPage = (page >= spotlightListingModel.data!.totalPage!).obs;
        }
        isLoading = false.obs;
        context.loaderOverlay.hide();
      }

    }, onError: (e) {
      context.loaderOverlay.hide();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    });
  }
}