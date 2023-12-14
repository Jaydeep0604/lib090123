import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:luxury_council/colors.dart';
import 'package:luxury_council/controllers/editprofileController.dart';
import 'package:luxury_council/controllers/registerController.dart';
import 'package:luxury_council/widgets/appbars.dart';
import 'package:luxury_council/widgets/edittext.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:toast/toast.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  EditProfileController editProfileController = Get.put(EditProfileController());
  TextEditingController nameCtr = TextEditingController();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController companyCtr = TextEditingController();
  TextEditingController titleCtr = TextEditingController();
  TextEditingController phoneCtr = TextEditingController();
  TextEditingController addressCtr = TextEditingController();
  TextEditingController assistantnameCtr = TextEditingController();
  TextEditingController assistantemailCtr = TextEditingController();
  TextEditingController assistantphoneCtr = TextEditingController();

  bool validate = false;
  FocusNode focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  
  @override
  void initState() {
    editProfileController.getprofile(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.loginappbar.withOpacity(0.99),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.only(left: 8),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Image.asset(
              "assets/back.png",
              scale: 2.9,
            ),
          ),
        ),
        title: Text(
          'EDIT PROFILE',
          style: TextStyle(
              color: AppColor.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/logo-img.png",
                scale: 2.9,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.black.withOpacity(0.7),
        centerTitle: true,
        bottomOpacity: 1.0,
        elevation: 4,
      ),
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
              child: Column(
                children: [
                  SizedBox(
                    height: 45,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 0),
                    padding: EdgeInsets.only(
                        top: 15, right: 30, left: 30, bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColor.white.withOpacity(0.05)),
                    child: Column(
                      children: [
                        // name
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                              child: Text(
                            "First Name",
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.start,
                          )),
                        ),
                        EditText(
                          hint: "First Name",
                          controller: editProfileController.firstnameController,
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
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                              child: Text(
                            "Last Name",
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.start,
                          )),
                        ),
                        EditText(
                          hint: "last Name",
                          controller: editProfileController.lastnameController,
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
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                              child: Text(
                            "Email",
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.start,
                          )),
                        ),
                        EditText(
                          hint: "Enter Your Email",
                          controller: editProfileController.emailController,
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

                        //company
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                              child: Text(
                            "Company",
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.start,
                          )),
                        ),
                        EditText(
                          hint: "Enter Your Company Name",
                          controller: editProfileController.companyController,
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
                          validator: (companyname) {
                            if (companyname == null || companyname.isEmpty) {
                              return 'Please enter company name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        //title
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                              child: Text(
                            "Title",
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.start,
                          )),
                        ),
                        EditText(
                          hint: "ex: CEO (It should be Master)",
                          controller: editProfileController.titleController,
                          validator: (value) {
                            if (value?.trim().isEmpty ?? true) {
                              return "Please enter title";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        //phone
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                              child: Text(
                            "Phone",
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.start,
                          )),
                        ),
                        IntlPhoneField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: editProfileController.phonenoController,
                          style: TextStyle(fontSize: 14, color: AppColor.white),
                          cursorColor: AppColor.black,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: AppColor.hintcolor),
                            hintText: 'Enter your number',
                          ),
                          onChanged: (value) {
                            if (value.number.length < 10 &&
                                value.number.length > 10) {
                              // Run anything here
                            }
                          },
                          focusNode: focusNode,

                          validator: (phonenum) {
                            if (phonenum == null) {
                              return 'Please enter Number';
                            }
                            return null;
                          },
                          disableLengthCheck: true,
                          dropdownTextStyle: TextStyle(color: AppColor.white),
                          initialCountryCode: 'IN',
                          dropdownIconPosition: IconPosition.trailing,
                          dropdownIcon: Icon(
                            Icons.arrow_drop_down,
                            color: AppColor.white,
                          ),
                          // onChanged: (phone) {
                          //   print(phone.completeNumber);
                          // },
                          showCountryFlag: false,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        //address
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                              child: Text(
                            "Mailling Address",
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.start,
                          )),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller:
                              editProfileController.mailingaddressController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          maxLines: 5,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(60),
                            
                            // FilteringTextInputFormatter.allow(
                            //     RegExp(r'[0-9a-zA-z._@]')),
                            // FilteringTextInputFormatter.deny(RegExp(r"/"))
                          ],
                          validator: (name) {
                            if (name == null || name.isEmpty) {
                              return 'Please enter mailing address';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.multiline,
                          style: TextStyle(color: AppColor.white),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(8),
                              hintText: 'Type here...',
                              hintStyle: TextStyle(color: AppColor.hintcolor),
                              border: OutlineInputBorder()),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        //assistant name (optional)
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                              child: Text(
                            "Assistant name (optional)",
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.start,
                          )),
                        ),
                        EditText(
                          hint: "Enter Assistant Name",
                          controller: editProfileController.assistantnameController,
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
                          // validator: (assistant) {
                          //     if (assistant == null || assistant.isEmpty) {
                          //       return 'Please enter assistant name';
                          //     }
                          //     return null;
                          //   },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        //assistant email
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                              child: Text(
                            "Assistant email",
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.start,
                          )),
                        ),
                        EditText(
                          hint: "Enter Assistant Email",
                          controller:
                              editProfileController.assistantemailController,
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
                          // validator: (value) {
                          //   if (value?.trim().isEmpty ?? true) {
                          //     return "Please enter assistant email";
                          //   } else if (!RegExp(
                          //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          //       .hasMatch(value ?? "")) {
                          //     return "Enter valid assistant email";
                          //   }
                          //   return null;
                          // },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        //assistant phone
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                              child: Text(
                            "Assistant phone",
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.start,
                          )),
                        ),
                        IntlPhoneField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller:
                              editProfileController.assistantphonenoController,
                          style: TextStyle(fontSize: 14, color: AppColor.white),
                          cursorColor: AppColor.black,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: AppColor.hintcolor),
                            hintText: 'Enter your Assistant number',
                          ),
                          validator: (asistantnum) {
                            if (asistantnum == null) {
                              return 'Please enter assistant number';
                            }
                            return null;
                          },
                          disableLengthCheck: true,
                          dropdownTextStyle: TextStyle(color: AppColor.white),
                          initialCountryCode: 'IN',
                          dropdownIconPosition: IconPosition.trailing,
                          dropdownIcon: Icon(
                            Icons.arrow_drop_down,
                            color: AppColor.white,
                          ),
                          onChanged: (phone) {
                            print(phone.completeNumber);
                          },
                          showCountryFlag: false,
                        ),
                        SizedBox(
                          height: 60,
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
                              if (_formKey.currentState?.validate() ?? false) {
                                
                                editProfileController.editprofile(context);
                              }
                            });
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: AppColor.primarycolor,
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: Text('Submit',
                                  style: Theme.of(context)
                                      .textTheme
                                      .button
                                      ?.copyWith(
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  void showToast(String msg, {int? duration, int? gravity}) {
    Toast.show('msg', duration: duration, gravity: gravity);
  }
}
