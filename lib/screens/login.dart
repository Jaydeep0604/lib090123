import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:luxury_council/colors.dart';
import 'package:luxury_council/controllers/loginController.dart';
import 'package:luxury_council/widgets/appbars.dart';
import 'package:luxury_council/widgets/edittext.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LoginController loginController = Get.put(LoginController());
  late TextEditingController emailCtr = TextEditingController();
  late TextEditingController passwordCtr = TextEditingController();
  final _firebaseMessaging = FirebaseMessaging.instance;
  String firebaseToken ='';
  bool _obsecureText = true;
  bool validate = false;
  void _toggleObscured() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    print('init');
    _firebaseMessaging.getToken().then((value) {
      setState(() {
        firebaseToken = value ?? '';
        print('fffff $firebaseToken');
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.loginappbar,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.7),
        //   shadowColor: AppColor.loginappbar,
        centerTitle: true,
        bottomOpacity: 1.0,
        elevation: 4,
        title: Text(
          'LOGIN',
          style: TextStyle(
              color: AppColor.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        leading: Container(
          margin: EdgeInsets.only(left: 8),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(
              "assets/logo-img.png",
              scale: 2.9,
            ),
          ),
        ),
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
                    padding: EdgeInsets.only(top: 15, right: 30, left: 30),
                    child: Column(
                      children: [
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
                          controller: loginController.LoginEmailController,
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
                              return "Please enter email address";
                            } else if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value ?? "")) {
                              return "Enter valid email address";
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
                            "Password",
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.start,
                          )),
                        ),
                        EditText(
                          controller: loginController.LoginPasswordController,
                          hint: "Enter Your Password",
                          obsecureText: _obsecureText,
                          textInputType: TextInputType.visiblePassword,
                          inputformtters: [
                            FilteringTextInputFormatter.deny(' '),
                            LengthLimitingTextInputFormatter(16)
                          ],
                          validator: (value) {
                            if (value == "" ||
                                (value?.trim().isEmpty ?? true)) {
                              return "Please enter password";
                            }
                            return null;
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
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: (() {}),
                                  child: Container(
                                    padding: EdgeInsets.only(top: 0.2),
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'Forget Password?',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              // fontFamily: KSMFontFamily.robotoRgular,
                                              color: AppColor.white,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor: AppColor.white,
                                              decorationThickness: 2),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                            if (_formKey.currentState?.validate() ?? false) {
                              context.loaderOverlay.show();
                              loginController.login(context, firebaseToken);
                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Login Successfully',style: TextStyle(color: AppColor.white),),
                          ));
                            } else {
                              //  Get.toNamed("HomeWithoutSignUp");
                            }
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: AppColor.primarycolor,
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: Text('Login',
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
                          height: 75,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don’t have an Account?",
                              style: TextStyle(
                                  color: AppColor.white, fontSize: 12),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed("/Register");
                              },
                              child: Text(
                                " Register Instead",
                                style: TextStyle(
                                    color: AppColor.primarycolor, fontSize: 12),
                              ),
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
}
