import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luxury_council/colors.dart';
import 'package:luxury_council/controllers/spotlight_details_controller.dart';

import '../config/prefrance.dart';
import '../widgets/app_loader.dart';
import '../widgets/appbars.dart';
import '../widgets/aspect_size.dart';

class SpotlightMember extends StatefulWidget {
  final int memberId;
  const SpotlightMember({super.key, required this.memberId});

  @override
  State<SpotlightMember> createState() => _SpotlightMemberState();
}

class _SpotlightMemberState extends State<SpotlightMember> {
  final SpotlightDetailsController spotlightDetailsController = Get.put(SpotlightDetailsController());
  String userName ='';
  TextEditingController nameCtr = TextEditingController();

  @override
  void initState() {
    spotlightDetailsController.getSpotlightDetails(context, widget.memberId);
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey,
      appBar: AppBarDetails(appBar: AppBar(), text: 'SPOTLIGHT MEMBER DETAILS'),
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
      //     'Spotlight member',
      //     style: TextStyle(
      //         color: AppColor.white, fontWeight: FontWeight.bold, fontSize: 16),
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
      //   backgroundColor: AppColor.appbar,
      //   centerTitle: false,
      //   bottomOpacity: 1.0,
      //   elevation: 4,
      // ),
      body:
      Obx(()=> spotlightDetailsController.spotlightData.value?.spotlightMemberId != null ?
          SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppColor.grey,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // height: 200,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.black),
                            child: Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl:spotlightDetailsController.spotlightData.value?.spotlightMemberCompanyLogoLink?? '',
                                  placeholder: (context, url) =>
                                  const AppLoader(type: LoaderType.activityIndicator),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                  width: AspectSize.getWidthSize(
                                      context: context, sizeConstant: 115),
                                ),
                                SizedBox(width: 10,),
                                Text(spotlightDetailsController.spotlightData.value?.spotlightMemberContactName?? '',
                                  style:  TextStyle(
                                    color: AppColor.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                                )
                              ],
                            ),
                            /*Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/21club.png',
                                  scale: 1.6,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam elementum feugiat augue, sed pharetra nunc',
                                  style: TextStyle(
                                      color: AppColor.white,
                                      fontSize: 12),
                                ),
                              ],
                            ),*/
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            spotlightDetailsController.spotlightData.value?.spotlightMemberCompanyLongDescription??'',
                            style:
                            TextStyle(color: AppColor.white, fontSize: 14),
                          ),
                         /* SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Sed a nibh eros. Morbi mattis felis erat. Vestibulum rutrum nulla at lacus dignissim, nec aliquet augue aliquet. Praesent eu tempus odio. Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut pharetra ullamcorper augue non scelerisque. Vestibulum sollicitudin velit ac ex tempus commodo. Etiam placerat elementum lobortis. Integer vel quam velit. Etiam a nunc rhoncus, ullamcorper arcu sed, convallis sem. Integer malesuada lorem ligula, vitae laoreet diam tincidunt ut. Mauris elementum consectetur diam, at viverra urna placerat pulvinar.',
                            style:
                            TextStyle(color: AppColor.white, fontSize: 12),
                          ),*/
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/email.png',
                                scale: 2.9,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                spotlightDetailsController.spotlightData.value?.spotlightMemberContactEmail?? '',
                                style: TextStyle(
                                    color: AppColor.white, fontSize: 14),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            spotlightDetailsController.spotlightData.value?.spotlightMemberContactName?? '',
                            style: TextStyle(
                                color: AppColor.primarycolor, fontSize: 16),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            controller: setController(),
                            maxLines: 8,
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
                          /*Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                                horizontal: 7, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border:
                                Border.all(color: AppColor.primarycolor)),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dear ${spotlightDetailsController.spotlightData.value?.spotlightMemberContactName}',
                                  style: TextStyle(
                                      color: AppColor.white, fontSize: 14),
                                ),SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'I found your profile on the Luxury Council app and wanted to inquire about services. I look forward to connecting soon.',
                                  style: TextStyle(
                                      color: AppColor.white, fontSize: 14),
                                ),SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Best\n$userName',
                                  style: TextStyle(
                                      color: AppColor.white, fontSize: 14),
                                ),
                              ],
                            ),
                          ),*/
                          Container(
                            margin: EdgeInsets.only(top: 35, bottom: 10),
                            height: 45,
                            decoration: BoxDecoration(
                                color: AppColor.primarycolor,
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                              child: Text('Send',
                                  style: TextStyle(
                                      color: AppColor.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                            ),
                          ),
                        ],
                      ));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 8,
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ):Container()
      ),
    );
  }

  Future<void> getData() async {
    userName = await GetData("first_name") ?? "";
  }

  setController() {
    nameCtr.text = 'Dear ${spotlightDetailsController.spotlightData.value?.spotlightMemberContactName},\n\nI found your profile on the Luxury Council app and wanted to inquire about services. I look forward to connecting soon.\n\nBest\n$userName';
   return nameCtr;
  }
}
