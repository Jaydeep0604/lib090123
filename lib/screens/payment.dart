import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luxury_council/colors.dart';
import 'package:luxury_council/config/utils.dart';
import 'package:luxury_council/controllers/paymentController.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
 final PaymentController paymentController = Get.put(PaymentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "assets/background.png",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Image.asset(
                  'assets/paymentlogo.png',
                  scale: 2.9,
                ),
                SizedBox(
                  height: 55,
                ),
                Text(
                  "You have done the payment successfully",
                  style: TextStyle(
                      color: AppColor.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      height: 1.2),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "A confirmation has also been sent to your email for your records.",
                    style: TextStyle(
                        fontSize: 15, color: AppColor.white, height: 1.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Transaction id: ${paymentController.transactionid}",
                    style: TextStyle(
                        fontSize: 15, color: AppColor.white, height: 1.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Date: ${Utils.dateFormate(paymentController.datetime.toString())}",
                    style: TextStyle(
                        fontSize: 15, color: AppColor.white, height: 1.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Time: ${Utils.timeFormate(paymentController.datetime.toString())}",
                    style: TextStyle(
                        fontSize: 15, color: AppColor.white, height: 1.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Get.offAndToNamed("/HomeWithSignUp");
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 70),
                    height: 45,
                    width: 120,
                    decoration: BoxDecoration(
                      color: AppColor.primarycolor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/leftarrow.png',
                          scale: 2.9,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Back",
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColor.black,
                              height: 1.0,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
