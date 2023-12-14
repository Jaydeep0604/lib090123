import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:luxury_council/colors.dart';
import 'package:luxury_council/controllers/eventController.dart';
import 'package:luxury_council/widgets/appbars.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({super.key});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  EventController eventController = Get.put(EventController());
  File? image;
  Future<dynamic> imagePicker(BuildContext context) {
    //if (Platform.isIOS) {
    return showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              height: 120,
              child: ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.camera_alt_sharp,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Camera",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(color: Colors.black),
                    ),
                    onTap: () async {
                      Get.back();
                      try {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.camera);

                        if (image == null) return;

                        final imageTemp = File(image.path);

                        setState(() => this.image = imageTemp);
                      } on PlatformException catch (e) {
                        print('Failed to pick image: $e');
                      }
                    },
                  ),
                  ListTile(
                    onTap: () async {
                      Get.back();
                      try {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);

                        if (image == null) return;

                        final imageTemp = File(image.path);

                        setState(() => this.image = imageTemp);
                      } on PlatformException catch (e) {
                        print('Failed to pick image: $e');
                      }
                    },
                    leading: const Icon(Icons.image, color: Colors.black),
                    title: Text(
                      "Gallery",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ));
  }

  // Future pickImage() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);

  //     if (image == null) return;

  //     final imageTemp = File(image.path);

  //     setState(() => this.image = imageTemp);
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

  // Future pickImageC() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.camera);

  //     if (image == null) return;

  //     final imageTemp = File(image.path);

  //     setState(() => this.image = imageTemp);
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey,
      appBar: AppBarDetails(appBar: AppBar(), text: 'EVENT DETAILS'),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            Obx(
              () => Container(
                margin: EdgeInsets.only(top: 30),
                child: eventController.event_id != null
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${eventController.event_name}',
                              style: TextStyle(
                                  color: AppColor.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                            Text(
                              '${eventController.event_date}',
                              style: TextStyle(
                                  color: AppColor.textlight, fontSize: 14),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Html(style: {
                                "body": Style(
                                  color: AppColor.white,
                                  fontSize: FontSize(14.0),
                                ),
                              },
                              data:
                                  "${eventController.event_detail.toString()}",
                            ),
                            // Text(
                            //    '${eventController.event_detail}',
                            //    style: TextStyle(
                            //       color: AppColor.white,
                            //       fontSize: 11),
                            // ),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              color: AppColor.black,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          imagePicker(context);
                                        },
                                        child: Container(
                                          height: 110,
                                          width: 140,
                                          decoration: BoxDecoration(
                                              color: AppColor.grey),
                                          child: image != null
                                              ? Image.file(
                                                  image!,
                                                  fit: BoxFit.fitWidth,
                                                )
                                              : Text("No image selected"),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Share.shareFiles([image!.path],
                                          text:
                                              '${eventController.hash_tags}');
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: AppColor.primarycolor),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/upload.png',
                                              scale: 2.9,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'Upload images',
                                              style: TextStyle(
                                                  color: AppColor.black,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              width: MediaQuery.of(context).size.width,
                              color: AppColor.black,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: Text(
                                '${eventController.hash_tags}',
                                style: TextStyle(
                                    color: AppColor.white, fontSize: 14),
                              ),
                            )
                          ],
                        ))
                    : Center(
                        child: Text(
                        "No data found",
                        style: TextStyle(color: AppColor.primarycolor),
                      )),
              ),
            ),

            // Container(
            //   margin: EdgeInsets.only(top: 30),
            //   child: ListView.separated(
            //     scrollDirection: Axis.vertical,
            //     shrinkWrap: true,
            //     primary: false,
            //     itemCount: 1,
            //     itemBuilder: (context, index) {
            //       return Container(
            //           width: MediaQuery.of(context).size.width,
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.start,
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text(
            //                 'VIRTUAL INFLUENCER ROUNDTABLE LUNCHEON',
            //                 style: TextStyle(
            //                     color: AppColor.white,
            //                     fontWeight: FontWeight.bold,
            //                     fontSize: 12),
            //               ),
            //               Text(
            //                 'Date: 29  sept',
            //                 style: TextStyle(
            //                     color: AppColor.textlight,
            //                     fontSize: 11),
            //               ),
            //               SizedBox(
            //                 height: 15,
            //               ),
            //               Text(
            //                 'founded in 1994, the luxury marketing council worldwide is an exclusiv, "by invitation only" collaborative organization of more than 5,000 top ceos and cmos from more than 1,000 major luxury goods and service companies in 41 cities worldwide,the council serves primarily as a catalyyst in bringing  the smartest, most imaginative  marketers of luxury product and services together to explore best practice and critical issues, and share intellgences on best customer and  marketing trends.',
            //                 style: TextStyle(
            //                     color: AppColor.white,
            //                     fontSize: 11),
            //               ),
            //               SizedBox(
            //                 height: 25,
            //               ),
            //               Container(
            //                 color: AppColor.black,
            //                 padding: EdgeInsets.symmetric(
            //                     horizontal: 15, vertical: 10),
            //                 child: Column(
            //                   mainAxisAlignment: MainAxisAlignment.start,
            //                   crossAxisAlignment: CrossAxisAlignment.center,
            //                   children: [
            //                     Row(
            //                       mainAxisAlignment:
            //                           MainAxisAlignment.spaceBetween,
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         Container(
            //                             height: 110,
            //                             width: 140,
            //                             child: Image.asset(
            //                               'assets/evnet2.png',
            //                               fit: BoxFit.cover,
            //                             )),
            //                         SizedBox(
            //                           width: 10,
            //                         ),
            //                         Container(
            //                             height: 110,
            //                             width: 140,
            //                             child: Image.asset(
            //                               'assets/evnet1.png',
            //                               fit: BoxFit.cover,
            //                             )),
            //                       ],
            //                     ),
            //                     SizedBox(
            //                       height: 10,
            //                     ),
            //                     Container(
            //                       height: 30,
            //                       width: 120,
            //                       decoration: BoxDecoration(
            //                           borderRadius: BorderRadius.circular(15),
            //                           color: AppColor.primarycolor),
            //                       child: Center(
            //                         child: Row(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.center,
            //                           children: [
            //                             Image.asset(
            //                               'assets/upload.png',
            //                               scale: 2.9,
            //                             ),
            //                             SizedBox(
            //                               width: 5,
            //                             ),
            //                             Text(
            //                               'Upload images',
            //                               style: TextStyle(
            //                                   color: AppColor.black,
            //                                   fontSize: 10),
            //                             ),
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                     SizedBox(
            //                       height: 5,
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               Container(
            //                 margin: EdgeInsets.only(top: 15),
            //                 width: MediaQuery.of(context).size.width,
            //                 color: AppColor.black,
            //                 padding: EdgeInsets.symmetric(
            //                     horizontal: 8, vertical: 8),
            //                     child: Text('#Articles, #Virtualinfluencer',style: TextStyle(color: AppColor.white,fontSize: 10),),
            //               )
            //             ],
            //           ));
            //     },
            //     separatorBuilder: (BuildContext context, int index) {
            //       return SizedBox(
            //         height: 8,
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
