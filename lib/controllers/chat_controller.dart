

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../api_config/api_services.dart';
import '../api_config/urls.dart';
import '../colors.dart';
import '../models/chat/chat_listing_model.dart';

class ChatController extends GetxController{
  RxBool chatListingResponse = true.obs;
  RxList<ChatData> chatListing= <ChatData>[].obs;
  RxBool isLoading = false.obs;
  RxBool isLastPage = false.obs;

  void getUserChatList(BuildContext context, int page, int subscriptionId) {
    if(page==1){
      context.loaderOverlay.show();
    }
    POST_API({
      "page": page,
      "limit": 20,
      "subscription_id": subscriptionId,
    }, Urls.userChatListing, context)
        .then((response) {
      Map<String, dynamic> chatResponse = jsonDecode(response);

      if (chatResponse["data"].isEmpty) {
        context.loaderOverlay.hide();
        chatListing.clear();
        isLoading = false.obs;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'No Data Found',
            style: TextStyle(color: AppColor.white),
          ),
        ));
      } else {
        if (chatResponse['status'] != true) {
          chatListingResponse= false.obs;
        } else {
          ChatListingModel chatListingModel = ChatListingModel.fromJson(jsonDecode(response));
          chatListing.addAll(chatListingModel.data ?? []);
          // isLastPage = (page >= spotlightListingModel.data!.totalPage!).obs;
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