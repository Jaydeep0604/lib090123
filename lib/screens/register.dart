import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:luxury_council/colors.dart';
import 'package:luxury_council/controllers/registerController.dart';
import 'package:luxury_council/widgets/appbars.dart';
import 'package:luxury_council/widgets/edittext.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:toast/toast.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  RegisterController registerController = Get.put(RegisterController());
  TextEditingController nameCtr = TextEditingController();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController companyCtr = TextEditingController();
  TextEditingController titleCtr = TextEditingController();
  TextEditingController phoneCtr = TextEditingController();
  TextEditingController addressCtr = TextEditingController();
  TextEditingController assistantnameCtr = TextEditingController();
  TextEditingController assistantemailCtr = TextEditingController();
  TextEditingController assistantphoneCtr = TextEditingController();

  bool _obsecureText = true;
  bool _obsecureTextMobile = false;
  bool validate = false;
  void _toggleObscured() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

  void _toggleObscured2() {
    setState(() {
      _obsecureTextMobile = !_obsecureTextMobile;
    });
  }

  FocusNode focusNode = FocusNode();

  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  final _formKey = GlobalKey<FormState>();
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
          'REGISTER',
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
                          controller: registerController.lastnameController,
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
                          controller: registerController.firstnameController,
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
                          controller: registerController.emailController,
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
                        //password
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                              child: Text(
                            "Password",
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.start,
                          )),
                        ),
                        EditText(
                          controller: registerController.passwordController,
                          hint: "Enter Your Password",
                          obsecureText: _obsecureText,
                          textInputType: TextInputType.visiblePassword,
                          //maxLength: 6,
                          inputformtters: [
                            FilteringTextInputFormatter.deny(' '),
                            LengthLimitingTextInputFormatter(8)
                          ],
                          validator: (value) {
                            RegExp regex = RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

                            if (value!.isEmpty) {
                              return "Please enter password";
                            } else if (value!.length < 6) {
                              return "Please enter atleast 6 character password";
                            } else {
                              // if (!regex.hasMatch(value)) {
                              //   return 'Please enter valid password';
                              // } else {
                              //   return null;
                              // }
                            }
                            //return null;
                          },
                          suffixIcon: GestureDetector(
                            onTap: _toggleObscured,
                            child: Transform.scale(
                              scale: 0.5,
                              child: ImageIcon(
                                _obsecureText
                                    ? AssetImage(
                                        "assets/hide.png",
                                      )
                                    : AssetImage(
                                        "assets/view.png",
                                      ),
                                color: AppColor.white,
                                size: 12,
                                // color: AppColors.button_color,
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 25,
                        // ),
                        // //confirm password
                        // Align(
                        //   alignment: Alignment.topLeft,
                        //   child: Container(
                        //       child: Text(
                        //     "Confirm Password",
                        //     style: TextStyle(
                        //       color: AppColor.white,
                        //       fontSize: 16,
                        //     ),
                        //     textAlign: TextAlign.start,
                        //   )),
                        // ),
                        // EditText(
                        //   controller: _confirmPass,
                        //   hint: "Enter Your Confirm Password",
                        //   obsecureText: _obsecureText,
                        //   textInputType: TextInputType.visiblePassword,
                        //   inputformtters: [
                        //     FilteringTextInputFormatter.deny(' '),
                        //     LengthLimitingTextInputFormatter(6)
                        //   ],
                        //   validator: (confirmpassword) {
                        //     if (confirmpassword!.isEmpty)
                        //       return 'Please enter your confirm password';
                        //     if (confirmpassword != _pass.text)
                        //       return 'Password Not Match';
                        //     return null;
                        //   },
                        //   suffixIcon: GestureDetector(
                        //     onTap: _toggleObscured,
                        //     child: Transform.scale(
                        //       scale: 0.5,
                        //       child: ImageIcon(
                        //         _obsecureText
                        //             ? AssetImage(
                        //                 "assets/hide.png",
                        //               )
                        //             : AssetImage(
                        //                 "assets/view.png",
                        //               ),
                        //         color: AppColor.white,
                        //         size: 12,
                        //         // color: AppColors.button_color,
                        //       ),
                        //     ),
                        //   ),
                        // ),
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
                          controller: registerController.companyontroller,
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
                          controller: registerController.titleController,
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
                          controller: registerController.phonenoController,
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
                              registerController.mailingaddressController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          maxLines: 5,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(60),
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9a-zA-z._@]')),
                            FilteringTextInputFormatter.deny(RegExp(r"/"))
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
                          controller: registerController.assistantnameController,
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
                              registerController.assistantemailController,
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
                          validator: (value) {
                            if (value?.trim().isEmpty ?? true) {
                              return "Please enter assistant email";
                            } else if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value ?? "")) {
                              return "Enter valid assistant email";
                            }
                            return null;
                          },
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
                              registerController.assistantphonenoController,
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
                                registerController.Register(context);
                              

                                //  Get.toNamed("/Login");
                              }
                              // Get.toNamed("/Login");
                            });
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: AppColor.primarycolor,
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: Text('Register',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an Account?",
                              style: TextStyle(
                                  color: AppColor.white, fontSize: 12),
                            ),
                            Text(
                              " Login",
                              style: TextStyle(
                                  color: AppColor.primarycolor,
                                  fontSize: 12,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColor.white,
                                  decorationThickness: 2),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                                child: Text(
                              "or",
                              style: TextStyle(
                                  color: AppColor.white, fontSize: 12),
                            )),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                                child: Text(
                              "Login With",
                              style: TextStyle(
                                  color: AppColor.white, fontSize: 12),
                            )),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/google.png",
                              scale: 2.5,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Image.asset(
                              "assets/apple.png",
                              scale: 2.5,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Image.asset(
                              "assets/facebook.png",
                              scale: 2.5,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
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
