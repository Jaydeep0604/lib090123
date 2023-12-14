import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:luxury_council/colors.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:luxury_council/config/prefrance.dart';
import 'package:luxury_council/controllers/homeController.dart';
import 'package:luxury_council/controllers/loginController.dart';
import 'package:luxury_council/controllers/paymentController.dart';
import 'package:luxury_council/widgets/appbars.dart';

import '../widgets/edittext.dart';

class PayScreen extends StatefulWidget {
  final String plan;
  const PayScreen({
    super.key,
    required this.plan
  });

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  final PaymentController paymentController = Get.put(PaymentController());
  final LoginController loginController = Get.put(LoginController());

  final cardnumbercontroller = TextEditingController();
  final expiredatecontroller = TextEditingController();
  final cvvcontroller = TextEditingController();
  final nameController = TextEditingController();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  HomeController homeController = Get.put(HomeController());
  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.grey,
      appBar: AppBarDetails(appBar: AppBar(), text: 'PAYMENT'),
      // appBar: AppBar(
      //   leading: Container(
      //     margin: EdgeInsets.only(left: 18),
      //     child: GestureDetector(
      //         onTap: () {
      //           Get.back();
      //         },
      //         child: Icon(
      //           Icons.arrow_back_ios,
      //           color: AppColor.white,
      //           size: 20,
      //         )),
      //   ),
      //   leadingWidth: 30,
      //   title: Text(
      //     'PAYMENT',
      //     style: TextStyle(
      //         color: AppColor.white, fontWeight: FontWeight.bold, fontSize: 12),
      //     textAlign: TextAlign.left,
      //   ),
      //   actions: [
      //     Row(
      //       children: [
      //         // GestureDetector(
      //         //   onTap: () {
      //         //     Get.toNamed("/Profile");
      //         //   },
      //         //   child: Container(
      //         //     margin: EdgeInsets.only(right: 0),
      //         //     child: Padding(
      //         //       padding: const EdgeInsets.all(4.0),
      //         //       child: Image.asset(
      //         //         "assets/profile.png",
      //         //         scale: 2.9,
      //         //       ),
      //         //     ),
      //         //   ),
      //         // ),
      //         Container(
      //           margin: EdgeInsets.only(right: 16),
      //           child: Padding(
      //             padding: const EdgeInsets.all(4.0),
      //             child: Image.asset(
      //               "assets/notification.png",
      //               scale: 2.9,
      //             ),
      //           ),
      //         ),
      //         // Container(
      //         //   margin: EdgeInsets.only(right: 8),
      //         //   child: Padding(
      //         //     padding: const EdgeInsets.all(4.0),
      //         //     child: Image.asset(
      //         //       "assets/message.png",
      //         //       scale: 2.9,
      //         //     ),
      //         //   ),
      //         // ),
      //       ],
      //     ),
      //   ],
      //   backgroundColor: Colors.black.withOpacity(0.7),
      //   centerTitle: false,
      //   bottomOpacity: 1.0,
      //   elevation: 4,
      // ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "assets/background.png",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "assets/registerbottom.png",
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  ),

                  CreditCardWidget(labelCardHolder: '',
                    glassmorphismConfig:
                        useGlassMorphism ? Glassmorphism.defaultConfig() : null,
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardHolderName: '',
                    cvvCode: cvvCode,

                    //bankName: 'Axis Bank',
                    frontCardBorder: !useGlassMorphism
                        ? Border.all(color: Colors.grey)
                        : null,
                    backCardBorder: !useGlassMorphism
                        ? Border.all(color: Colors.grey)
                        : null,
                    showBackView: isCvvFocused,
                    obscureCardNumber: true,
                    obscureCardCvv: true,
                    isHolderNameVisible: true,
                    cardBgColor: AppColor.grey,
                    // backgroundImage:
                    //     useBackgroundImage ? 'assets/card_bg.png' : null,
                    isSwipeGestureEnabled: true,
                    onCreditCardWidgetChange:
                        (CreditCardBrand creditCardBrand) {},
                    customCardTypeIcons: <CustomCardTypeIcon>[
                      // CustomCardTypeIcon(
                      //   cardType: CardType.mastercard,
                      //   cardImage: Image.asset(
                      //     'assets/mastercard.png',
                      //     height: 48,
                      //     width: 48,
                      //   ),
                      // ),
                    ],
                  ),
                  // EditText3(
                  //   hint: "Card Number",
                  //   controller: cardnumbercontroller,
                  //   textInputType: TextInputType.number,
                  //   inputformtters: [
                  //     LengthLimitingTextInputFormatter(16),
                  //   ],
                  //   validator: (name) {
                  //     if (name == null || name.isEmpty) {
                  //       return 'Please enter card number';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // EditText3(
                  //   hint: "Expiry Date",
                  //   controller: expiredatecontroller,
                  //   textInputType: TextInputType.number,
                  //   inputformtters: [
                  //     LengthLimitingTextInputFormatter(6),
                  //   ],
                  //   validator: (name) {
                  //     if (name == null || name.isEmpty) {
                  //       return 'Please enter expiry date';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // EditText3(
                  //   hint: "CVV",
                  //   controller: cvvcontroller,
                  //   textInputType: TextInputType.number,
                  //   inputformtters: [
                  //     LengthLimitingTextInputFormatter(3),
                  //   ],
                  //   validator: (name) {
                  //     if (name == null || name.isEmpty) {
                  //       return 'Please enter cvv';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // EditText3(
                  //   hint: "Card Holder Name",
                  //   controller: nameController,
                  //   textInputType: TextInputType.name,
                  //   inputformtters: [
                  //     LengthLimitingTextInputFormatter(50),
                  //   ],
                  //   validator: (name) {
                  //     if (name == null || name.isEmpty) {
                  //       return 'Please enter card holder name';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  SizedBox(
                    height: 15,
                  ),

                  CreditCardForm(
                    formKey: formKey,
                    obscureCvv: true,
                    obscureNumber: true,
                    cardNumber: paymentController.cardNumber.value.toString(),
                    cvvCode: paymentController.cvvCode.value.toString(),
                    isHolderNameVisible: false,
                    isCardNumberVisible: true,
                    isExpiryDateVisible: true,
                    
                   cardHolderName: '',
                    expiryDate: paymentController.expiryDate.value.toString(),
                    themeColor: Colors.blue,
                    textColor: Colors.white,
                    cardNumberDecoration: InputDecoration(
                      labelText: 'Number',
                      hintText: 'XXXX XXXX XXXX XXXX',
                      hintStyle: const TextStyle(color: Colors.white),
                      labelStyle: const TextStyle(color: Colors.white),
                      focusedBorder: border,
                      enabledBorder: border,
                    ),
                    expiryDateDecoration: InputDecoration(
                      hintStyle: const TextStyle(color: Colors.white),
                      labelStyle: const TextStyle(color: Colors.white),
                      focusedBorder: border,
                      enabledBorder: border,
                      labelText: 'Expired Date',
                      hintText: 'XX/XX',
                    ),
                    cvvCodeDecoration: InputDecoration(
                      hintStyle: const TextStyle(color: Colors.white),
                      labelStyle: const TextStyle(color: Colors.white),
                      focusedBorder: border,
                      enabledBorder: border,
                      labelText: 'CVV',
                      hintText: 'XXX',
                    ),
                   
                    onCreditCardModelChange: onCreditCardModelChange,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                 Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey.withOpacity(0.7),)),
                  child: Text(widget.plan,style: TextStyle(color: AppColor.white),)),

                  SizedBox(
                    height: 20,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: <Widget>[
                  //       const Text(
                  //         'Glassmorphism',
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 18,
                  //         ),
                  //       ),
                  //       const Spacer(),
                  //       Switch(
                  //         value: useGlassMorphism,
                  //         inactiveTrackColor: Colors.grey,
                  //         activeColor: Colors.white,
                  //         activeTrackColor: AppColor.primarycolor,
                  //         onChanged: (bool value) => setState(() {
                  //           useGlassMorphism = value;
                  //         }),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: <Widget>[
                  //       const Text(
                  //         'Card Image',
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 18,
                  //         ),
                  //       ),
                  //       const Spacer(),
                  //       Switch(
                  //         value: useBackgroundImage,
                  //         inactiveTrackColor: Colors.grey,
                  //         activeColor: Colors.white,
                  //         activeTrackColor: AppColor.primarycolor,
                  //         onChanged: (bool value) => setState(() {
                  //           useBackgroundImage = value;
                  //         }),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        var cnumber = cardNumber.replaceAll(' ', '');
                        var exp = expiryDate.replaceAll(' ', '');
                        var cv = cvvCode.replaceAll(' ', '');
                        print('cardNumber-----${cnumber}');
                        print('expiryDate-----${exp}');
                        print('cvvCode-----${cv}');
                        print(
                            'subscriptionid-----${loginController.subscriptionid.toString()}');
                        print(
                            'subscriptiontype------${loginController.subscriptiontype.toString()}');

                        paymentController.getPayment(
                          context,
                          cnumber,
                         exp,
                         cv,
                         '10',
                          int.parse(loginController.subscriptionid.toString()),
                          int.parse(
                              loginController.subscriptiontype.toString()),
                        );
                      } else {
                        print('invalid!');
                      }
                      // Get.toNamed("/Payment");
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 350, bottom: 10),
                      height: 45,
                      decoration: BoxDecoration(
                          color: AppColor.black,
                          border: Border.all(
                              color: AppColor.primarycolor, width: 2),
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: Text('Payment',
                            style: TextStyle(
                                color: AppColor.primarycolor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // void _onValidate() {
  //   if (formKey.currentState!.validate()) {

  //   } else {
  //     print('invalid!');
  //   }
  // }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
