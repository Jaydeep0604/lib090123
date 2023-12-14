import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luxury_council/colors.dart';
import 'package:get/get.dart';
import 'package:luxury_council/config/utils.dart';
import 'package:luxury_council/controllers/editprofileController.dart';
import 'package:luxury_council/controllers/loginController.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  LoginController loginController = Get.put(LoginController());
  EditProfileController editProfileController =
      Get.put(EditProfileController());
  @override
  void initState() {
    editProfileController.getprofile(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            SizedBox(
              height: 15,
            ),
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 18),
                  child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppColor.white,
                        size: 30,
                      )),
                ),
                Center(
                    child: Image.asset(
                  'assets/profilebg1.png',
                  scale: 2.9,
                )),
                Container(
                  margin: EdgeInsets.only(top: 25, left: 40),
                  child: Image.asset(
                    'assets/profilebg2.png',
                    scale: 2.9,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 60),
                  child: Center(
                    child: CircleAvatar(
                        backgroundColor: Colors.greenAccent[400],
                        radius: 60,
                        child: Image.asset(
                          'assets/drawerprofile.png',
                          fit: BoxFit.cover,
                        )),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              "${editProfileController.firstname} ${editProfileController.lastname}",
              style: TextStyle(
                  color: AppColor.primarycolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1.2),
              textAlign: TextAlign.center,
            ),
            Text(
              "${editProfileController.title}",
              style: TextStyle(fontSize: 15, color: AppColor.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            editProfileController.startdate.isNotEmpty
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: AppColor.black),
                    child: Column(
                      children: [
                        Text(
                          "Your Subscription Plan",
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColor.white,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "\$${editProfileController.subscriptionyear} YEAR",
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColor.primarycolor,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Start Date:  ${Utils.dateFormate(editProfileController.startdate.toString())}",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColor.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "End Date:  ${Utils.dateFormate(editProfileController.enddate.toString())}",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColor.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 40,
                          width: 160,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: AppColor.primarycolor),
                          child: Center(
                            child: Text(
                              'Cancel Subsription',
                              style: TextStyle(
                                  color: AppColor.black, fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
            GestureDetector(
              onTap: () {
                Get.toNamed("/EditProfile");
              },
              child: Container(
                margin: EdgeInsets.only(top: 20),
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.grey, width: 1),
                  color: AppColor.grey,
                  boxShadow: [
                    BoxShadow(blurRadius: 3.0, color: AppColor.black),
                  ],
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Image.asset(
                          'assets/edit.png',
                          scale: 2.9,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Edit Profile',
                        style: TextStyle(
                            color: AppColor.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed("/Subscription");
              },
              child: Container(
                margin: EdgeInsets.only(top: 10),
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColor.black,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Image.asset(
                          'assets/subscriptions.png',
                          scale: 2.2,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Subscription',
                        style: TextStyle(
                            color: AppColor.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
