import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luxury_council/colors.dart';

class AppBarDetails extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final String text;
  //final GestureTapCallback ontap;
  // BuildContext buildContext;
  AppBarDetails({required this.appBar, required this.text});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.appbar,
      bottomOpacity: 1.0,
      elevation: 4,
      leadingWidth: 30,
      title: Text(
        text.toString(),
        style: TextStyle(
            color: AppColor.white, fontWeight: FontWeight.bold, fontSize: 16),
        textAlign: TextAlign.left,
      ),
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          color: AppColor.appbar.withOpacity(0.001),
          padding: EdgeInsets.only(left: 18),
          width: 50,
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColor.white,
            size: 20,
          ),
        ),
      ),
      actions: [
        Row(
          children: [
            // GestureDetector(
            //   onTap: () {
            //     Get.toNamed("/Profile");
            //   },
            //   child: Container(
            //     margin: EdgeInsets.only(right: 0),
            //     child: Padding(
            //       padding: const EdgeInsets.all(4.0),
            //       child: Image.asset(
            //         "assets/profile.png",
            //         scale: 2.9,
            //       ),
            //     ),
            //   ),
            // ),
            Container(
              margin: EdgeInsets.only(right: 16),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  "assets/notification.png",
                  scale: 2.9,
                ),
              ),
            ),
            // Container(
            //   margin: EdgeInsets.only(right: 8),
            //   child: Padding(
            //     padding: const EdgeInsets.all(4.0),
            //     child: Image.asset(
            //       "assets/message.png",
            //       scale: 2.9,
            //     ),
            //   ),
            // ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
