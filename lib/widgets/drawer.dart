import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luxury_council/colors.dart';
import 'package:luxury_council/config/prefrance.dart';
import 'package:luxury_council/controllers/editprofileController.dart';
import 'package:luxury_council/controllers/loginController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatefulWidget {
  
  final bool? isChat;
  const DrawerWidget({
    super.key,
     this.isChat
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
    LoginController loginController = Get.put(LoginController());
  EditProfileController editProfileController =
      Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColor.black,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          DrawerHeader(
              child: Row(
            children: [
              CircleAvatar(
                  backgroundColor: Colors.greenAccent[400],
                  radius: 50,
                  child: Image.asset(
                    'assets/drawerprofile.png',
                    fit: BoxFit.cover,
                  )),
              SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${editProfileController.firstname.toString()} ${editProfileController.lastname.toString()}",
                    style: TextStyle(
                        color: AppColor.primarycolor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${editProfileController.title.toString()}",
                    style: TextStyle(color: AppColor.white, fontSize: 13),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Get.toNamed("/Profile");
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      height: 30,
                      width: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColor.primarycolor,
                      ),
                      child: Center(
                        child: Text(
                          'View Profile',
                          style: TextStyle(color: AppColor.black, fontSize: 13),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          )),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15,),
            child: Column(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);

                      Get.toNamed("/HomeWithSignUp");
                    },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                
                        Get.toNamed("/HomeWithSignUp");
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/articles.png',
                            scale: 2.9,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Article',
                            style: TextStyle(fontSize: 18, color: AppColor.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Get.toNamed("/Events");
                    },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/events.png',
                          scale: 2.9,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Event',
                          style: TextStyle(fontSize: 18, color: AppColor.white),
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.isChat ?? false,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Get.toNamed("/Chats");
                      },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/chats.png',
                            scale: 2.9,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Chat',
                            style: TextStyle(fontSize: 18, color: AppColor.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Get.toNamed("/Subscription");
                    },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/subscriptions.png',
                          scale: 2.9,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Subscription',
                          style: TextStyle(fontSize: 18, color: AppColor.white),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Get.toNamed("/GroupSubscription");
                    },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/groupsubscription.png',
                          scale: 2.9,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Group Subscription',
                          style: TextStyle(fontSize: 18, color: AppColor.white),
                        )
                      ],
                    ),
                  ),
                ),
                // Container(
                  //width: MediaQuery.of(context).size.width,
                //   margin: EdgeInsets.only(top: 20),
                //   child: GestureDetector(
                //     onTap: () {
                //       Navigator.pop(context);
                //       Get.toNamed("/Digest");
                //     },
                //     child: Row(
                //       children: [
                //         Image.asset(
                //           'assets/digest.png',
                //           scale: 2.9,
                //         ),
                //         SizedBox(
                //           width: 15,
                //         ),
                //         Text(
                //           'My Digest',
                //           style: TextStyle(fontSize: 18, color: AppColor.white),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                 GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Get.toNamed("/SpotlightListing");
                    },
                  child: Container(
                    margin: EdgeInsets.only(top: 20,left: 5),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/spotlightmember.png',
                          scale: 2.7,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Spotlight Member',
                          style: TextStyle(fontSize: 18, color: AppColor.white),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Get.toNamed("/FavouritePage");
                    },
                  child: Container(width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 20,left: 5),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/favourites.png',
                          scale: 2.9,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Favourite',
                          style: TextStyle(fontSize: 18, color: AppColor.white),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Get.toNamed("/AboutUs");
                    },
                  child: Container(width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppColor.primarycolor,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'About Us',
                          style: TextStyle(fontSize: 18, color: AppColor.white),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Get.toNamed("/ContactUs");
                    },
                  child: Container(width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.contact_emergency_outlined,
                          color: AppColor.primarycolor,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Contact Us',
                          style: TextStyle(fontSize: 18, color: AppColor.white),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: GestureDetector(
                    onTap: () {
                      RemoveData("Email");
                  RemoveData("Password");
                  Navigator.pop(context);
                  Get.offAllNamed("/Login");
                    //  Get.toNamed("/Login");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/logout.png',
                          scale: 2.9,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Logout',
                          style: TextStyle(
                              color: AppColor.primarycolor, fontSize: 18),
                        )
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

class DrawerWidget2 extends StatefulWidget {
  const DrawerWidget2({
    super.key,
  });

  @override
  State<DrawerWidget2> createState() => _DrawerWidget2State();
}

class _DrawerWidget2State extends State<DrawerWidget2> {
  LoginController loginController = Get.put(LoginController());
  EditProfileController editProfileController =
      Get.put(EditProfileController());
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColor.black,
      child: ListView(
          children: [
            DrawerHeader(
                child: Row(
              children: [
                CircleAvatar(
                    backgroundColor: Colors.greenAccent[400],
                    radius: 50,
                    child: Image.asset(
                      'assets/drawerprofile.png',
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${editProfileController.firstname.toString()} ${editProfileController.lastname.toString()}",
                      style: TextStyle(
                          color: AppColor.primarycolor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${editProfileController.title.toString()}",
                      style: TextStyle(color: AppColor.white, fontSize: 13),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Get.toNamed("/Profile");
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 5),
                        height: 30,
                        width: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColor.primarycolor,
                        ),
                        child: Center(
                          child: Text(
                            'View Profile',
                            style:
                                TextStyle(color: AppColor.black, fontSize: 13),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed("/Subscription");
                },
              child: Container(width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/subscription.png',
                      scale: 2.9,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Subscription',
                      style: TextStyle(fontSize: 18, color: AppColor.white),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: GestureDetector(
                      onTap: () {
                        RemoveData("Email");
                        RemoveData("Password");
                        Navigator.pop(context);
                        Get.offAllNamed("/Login");
                        //  Get.toNamed("/Login");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/logout.png',
                            scale: 2.9,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Logout',
                            style: TextStyle(
                                color: AppColor.primarycolor, fontSize: 18),
                          )
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
