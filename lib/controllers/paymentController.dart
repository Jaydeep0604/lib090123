import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:luxury_council/api_config/api_services.dart';
import 'package:luxury_council/api_config/urls.dart';

class PaymentController extends GetxController {
  var cardNumber = ''.obs;
  var expiryDate = ''.obs;
  var cvvCode = ''.obs;
  var amount = ''.obs;
  var subscription_id = 0.obs;
  var subscription_type = 0.obs;
  var transactionid = ''.obs;
  var datetime = ''.obs;


  void getPayment(
    BuildContext context,
    String card_number,
    String exp_date,
    String code,
    String amount,
    int subscription_id,
    int subscription_type,
  ) {
    context.loaderOverlay.show();
    print("PAYMENT URL ----> ${Urls.PAYMENT}");

    POST_API({
      "card_number": card_number,
      "exp_date": exp_date,
      "code": code,
      "amount": amount,
      "subscription_id": subscription_id,
      "subscription_type": subscription_type
    }, Urls.PAYMENT, context)
        .then((response) async {
      print("PAYMENT response ----> $response");
      Map<String, dynamic> map = jsonDecode(response);
      print("subis-------${subscription_id}");
      if (map["status"] != true) {
        context.loaderOverlay.hide();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(map['message'])));
      } else {
        transactionid.value = map["data"]["transaction_id"];
        datetime.value = map["data"]["created_at"];
        print('transactionid----------${transactionid}');
        print('created_at----------${datetime}');
        Get.toNamed("/Payment");
      }
      context.loaderOverlay.hide();
    }, onError: (error) {
      print("Error ---> ${error}");
      context.loaderOverlay.hide();
    });
  }
}
