import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:luxury_council/colors.dart';
import 'package:luxury_council/controllers/contact_us_controller.dart';
import 'package:luxury_council/widgets/edittext.dart';

import '../widgets/appbars.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final ContactUsController contactUsController = Get.put(ContactUsController());
  TextEditingController nameCtr = TextEditingController();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController addressCtr = TextEditingController();
  TextEditingController phoneCtr = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool onSubmitTap = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
        extendBodyBehindAppBar: true,
      backgroundColor: AppColor.grey,
      appBar: AppBarDetails(appBar: AppBar(), text: 'CONTACT US'),
      // appBar: AppBar(
        
      //   leading: Container(
      //     margin: EdgeInsets.only(left: 18),
      //     child: GestureDetector( 
      //         onTap: () {Get.back();},
      //         child: Icon(
      //           Icons.arrow_back_ios,
      //           color: AppColor.white,
      //           size: 20,
      //         )),
      //   ),
      //   leadingWidth: 30,
      //   title: Text(
      //     'CONTACT US',
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
          SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Column(
                    children: [
                      SizedBox(height: 80,),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                            color: AppColor.black,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            EditText1(
                              hint: "Name",
                              controller: contactUsController.nameController,
                              inputformtters: [
                                LengthLimitingTextInputFormatter(60),
                                FilteringTextInputFormatter.deny(" "),
                                FilteringTextInputFormatter.deny("[]"),
                                FilteringTextInputFormatter.deny("["),
                                FilteringTextInputFormatter.deny("]"),
                                FilteringTextInputFormatter.deny("^"),
                                FilteringTextInputFormatter.deny(""),
                                FilteringTextInputFormatter.deny("`"),
                                FilteringTextInputFormatter.deny("/"),
                                // FilteringTextInputFormatter.deny("\"),
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9a-zA-z._@]')),
                                FilteringTextInputFormatter.deny(RegExp(r"/"))
                              ],
                              validator: (name) {
                                if (name == null || name.isEmpty) {
                                  return 'Please enter first name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            //email

                            EditText1(
                              hint: "Email",
                              controller: contactUsController.emailController,
                              inputformtters: [
                                LengthLimitingTextInputFormatter(60),
                                FilteringTextInputFormatter.deny(" "),
                                FilteringTextInputFormatter.deny("[]"),
                                FilteringTextInputFormatter.deny("["),
                                FilteringTextInputFormatter.deny("]"),
                                FilteringTextInputFormatter.deny("^"),
                                FilteringTextInputFormatter.deny(""),
                                FilteringTextInputFormatter.deny("`"),
                                FilteringTextInputFormatter.deny("/"),
                                // FilteringTextInputFormatter.deny("\"),
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9a-zA-z._@]')),
                                FilteringTextInputFormatter.deny(RegExp(r"/"))
                              ],
                              validator: (email) {
                                if (email?.trim().isEmpty ?? true) {
                                  return "Please enter email address";
                                } else if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(email ?? "")) {
                                  return "Enter valid email address";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: AppColor.primarycolor, width: 1),
                              ),
                              child: IntlPhoneField(
                                controller: contactUsController.phoneNumberController,
                                style: TextStyle(
                                    fontSize: 14, color: AppColor.white),
                                cursorColor: AppColor.black,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(color: AppColor.hintcolor),
                                  hintText: 'Phone number',
                                ),
                                validator: (phonenum) {
                                  if (phonenum == null) {
                                    return 'Please enter Number';
                                  }
                                  return null;
                                },
                                disableLengthCheck: true,
                                dropdownTextStyle:
                                    TextStyle(color: AppColor.white),
                                initialCountryCode: 'IN',
                                dropdownIconPosition: IconPosition.trailing,
                                showDropdownIcon: false,
                                onChanged: (phone) {
                                  print(phone.completeNumber);
                                },
                                showCountryFlag: false,
                              ),
                            ),
                            Visibility(
                              visible: contactUsController.phoneNumberController.text.isEmpty && onSubmitTap,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 7),
                                  child: Text('Please enter Number',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                    color:Colors.red,
                                      fontSize: 12.5
                                  ),),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            TextFormField(
                              controller: contactUsController.messageController,
                              maxLines: 5,
                              validator: (address) {
                                if (address == '') {
                                  return "Please enter message";
                                }
                              },
                              style:
                                  TextStyle(fontSize: 14, color: AppColor.white),
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(8),
                                  hintText: 'Write Message',
                                  hintStyle: TextStyle(color: AppColor.white),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: AppColor.primarycolor),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: AppColor.primarycolor),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: AppColor.primarycolor),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: AppColor.primarycolor),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: AppColor.primarycolor),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: AppColor.primarycolor),
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          FocusNode? focusNode =
                              FocusManager.instance.primaryFocus;
                          if (focusNode != null) {
                            if (focusNode.hasPrimaryFocus) {
                              focusNode.unfocus();
                            }
                          }
                          setState(() {
                            onSubmitTap = true;
                            bool isValidState = _formKey.currentState?.validate() ?? false;

                            if (isValidState && contactUsController.phoneNumberController.text.isNotEmpty) {
                              context.loaderOverlay.show();
                              contactUsController.contactUs(context);
                              // Get.toNamed("/Login");
                            }
                            // Get.toNamed("/HomeWithSignUp");
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 35, bottom: 10),
                          height: 45,
                          decoration: BoxDecoration(
                              color: AppColor.primarycolor,
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: Text('Submit',
                                style: TextStyle(
                                    color: AppColor.black,
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
            ),
          ),
        ],
      ),
    );
  }
}
