import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:luxury_council/colors.dart';
import 'package:luxury_council/controllers/subscription_controller.dart';
import 'package:luxury_council/widgets/appbars.dart';

class Subscription extends StatefulWidget {
  const Subscription({super.key});

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  final SubscriptionController subscriptionController = Get.put(SubscriptionController());
  String? gender;
  String plan = '';
  String content ='';
  bool navigateToPage = false;

  @override
  void initState() {
    subscriptionController.getSubscriptionListing(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey,
      appBar: AppBarDetails(appBar: AppBar(), text: 'SUBSCRIPTION'),
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
      //     'SUBSCRIPTION',
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
      //   backgroundColor: AppColor.appbar,
      //   //   shadowColor: AppColor.loginappbar,
      //   centerTitle: false,
      //   bottomOpacity: 1.0,
      //   elevation: 4,
      // ),
     
      body:
      Obx(()=>
          subscriptionController.subscriptionData.isNotEmpty ? SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      itemCount: subscriptionController.subscriptionData.length,
                      itemBuilder: (context, index) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                                color: AppColor.black,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  subscriptionController.subscriptionData[index].subscriptionName ??'',
                                  style: TextStyle(
                                      color: AppColor.primarycolor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                RadioListTile(
                                  contentPadding: EdgeInsets.zero,
                                  visualDensity: const VisualDensity(
                                      horizontal: VisualDensity.minimumDensity,
                                      vertical: VisualDensity.minimumDensity),
                                  activeColor: AppColor.primarycolor,
                                  fillColor: MaterialStateColor.resolveWith(
                                          (states) => AppColor.primarycolor),
                                  title: Text(
                                    '\$ ${subscriptionController.subscriptionData[index].subscriptionPricePerMonth} / month',
                                    style: TextStyle(
                                        color: AppColor.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  value: "${subscriptionController.subscriptionData[index].subscriptionPricePerMonth}M",
                                  groupValue: gender,
                                  onChanged: (value) {
                                    setState(() {
                                      plan = '\$${subscriptionController.subscriptionData[index].subscriptionPricePerMonth} / Month';
                                      content= subscriptionController.subscriptionData[index].subscriptionContent ?? '';
                                      gender = value.toString();
                                    });
                                  },
                                ),
                                RadioListTile(
                                  contentPadding: EdgeInsets.zero,
                                  visualDensity: const VisualDensity(
                                      horizontal: VisualDensity.minimumDensity,
                                      vertical: VisualDensity.minimumDensity),
                                  activeColor: AppColor.primarycolor,
                                  fillColor: MaterialStateColor.resolveWith(
                                          (states) => AppColor.primarycolor),
                                  title: Text(
                                    '\$ ${subscriptionController.subscriptionData[index].subscriptionPricePerYear} / year',
                                    style: TextStyle(
                                        color: AppColor.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  value: "${subscriptionController.subscriptionData[index].subscriptionPricePerYear}Y",
                                  groupValue: gender,
                                  onChanged: (value) {
                                    setState(() {
                                      plan = '\$${subscriptionController.subscriptionData[index].subscriptionPricePerYear} / Year';
                                      content= subscriptionController.subscriptionData[index].subscriptionContent ?? '';
                                      gender = value.toString();
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: HtmlWidget(textStyle: TextStyle(color: AppColor.white,fontSize: 14),
                                    subscriptionController.subscriptionData[index].subscriptionContent ?? '',
                                  ),
                                ),
                              ],
                            ));
                      /*  if (index == 0)
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                  color: AppColor.black,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Free',
                                    style: TextStyle(
                                        color: AppColor.primarycolor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  RadioListTile(
                                    contentPadding: EdgeInsets.zero,
                                    visualDensity: const VisualDensity(
                                        horizontal: VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity),
                                    activeColor: AppColor.primarycolor,
                                    fillColor: MaterialStateColor.resolveWith(
                                            (states) => AppColor.primarycolor),
                                    title: Text(
                                      '\$ 0 / month',
                                      style: TextStyle(
                                          color: AppColor.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                    value: "0M",
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        navigateToPage = true;

                                        gender = value.toString();
                                      });
                                    },
                                  ),
                                  RadioListTile(
                                    contentPadding: EdgeInsets.zero,
                                    visualDensity: const VisualDensity(
                                        horizontal: VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity),
                                    activeColor: AppColor.primarycolor,
                                    fillColor: MaterialStateColor.resolveWith(
                                            (states) => AppColor.primarycolor),
                                    title: Text(
                                      '\$ 0 / year',
                                      style: TextStyle(
                                          color: AppColor.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                    value: "0Y",
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value.toString();
                                      });
                                    },
                                  ),
                                ],
                              ));
                        if (index == 1)
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                  color: AppColor.black,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Base Level',
                                    style: TextStyle(
                                        color: AppColor.primarycolor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  RadioListTile(
                                    contentPadding: EdgeInsets.zero,
                                    visualDensity: const VisualDensity(
                                        horizontal: VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity),
                                    activeColor: AppColor.primarycolor,
                                    fillColor: MaterialStateColor.resolveWith(
                                            (states) => AppColor.primarycolor),
                                    title: Text(
                                      '\$ 30 / month',
                                      style: TextStyle(
                                          color: AppColor.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                    value: "30M",
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value.toString();
                                      });
                                    },
                                  ),
                                  RadioListTile(
                                    contentPadding: EdgeInsets.zero,
                                    visualDensity: const VisualDensity(
                                        horizontal: VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity),
                                    activeColor: AppColor.primarycolor,
                                    fillColor: MaterialStateColor.resolveWith(
                                            (states) => AppColor.primarycolor),
                                    title: Text(
                                      '\$ 30 / year',
                                      style: TextStyle(
                                          color: AppColor.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                    value: "30Y",
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value.toString();
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      'All non-premium articles (anything noted as base level or forgotten to be checked as something else. \nNo chat capacity \nLive events will only come months after the events have happened.',
                                      style: TextStyle(
                                          color: AppColor.white, fontSize: 10),
                                    ),
                                  ),
                                ],
                              ));
                        if (index == 2)
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                  color: AppColor.black,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Premium Sans Live',
                                    style: TextStyle(
                                        color: AppColor.primarycolor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  RadioListTile(
                                    contentPadding: EdgeInsets.zero,
                                    visualDensity: const VisualDensity(
                                        horizontal: VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity),
                                    activeColor: AppColor.primarycolor,
                                    fillColor: MaterialStateColor.resolveWith(
                                            (states) => AppColor.primarycolor),
                                    title: Text(
                                      '\$ 300 / month',
                                      style: TextStyle(
                                          color: AppColor.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                    value: "300M",
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value.toString();
                                      });
                                    },
                                  ),
                                  RadioListTile(
                                    contentPadding: EdgeInsets.zero,
                                    visualDensity: const VisualDensity(
                                        horizontal: VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity),
                                    activeColor: AppColor.primarycolor,
                                    fillColor: MaterialStateColor.resolveWith(
                                            (states) => AppColor.primarycolor),
                                    title: Text(
                                      '\$ 300 / year',
                                      style: TextStyle(
                                          color: AppColor.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                    value: "300Y",
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value.toString();
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Access to all articles \nAccess to live events (video, not in-person) \nChat with other level III',
                                      style: TextStyle(
                                          color: AppColor.white, fontSize: 10),
                                    ),
                                  ),
                                ],
                              ));

                        if (index == 3)
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                  color: AppColor.black,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ultimate Access',
                                    style: TextStyle(
                                        color: AppColor.primarycolor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  RadioListTile(
                                    contentPadding: EdgeInsets.zero,
                                    visualDensity: const VisualDensity(
                                        horizontal: VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity),
                                    activeColor: AppColor.primarycolor,
                                    fillColor: MaterialStateColor.resolveWith(
                                            (states) => AppColor.primarycolor),
                                    title: Text(
                                      '\$ 500 / month',
                                      style: TextStyle(
                                          color: AppColor.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                    value: "500M",
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value.toString();
                                      });
                                    },
                                  ),
                                  RadioListTile(
                                    contentPadding: EdgeInsets.zero,
                                    visualDensity: const VisualDensity(
                                        horizontal: VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity),
                                    activeColor: AppColor.primarycolor,
                                    fillColor: MaterialStateColor.resolveWith(
                                            (states) => AppColor.primarycolor),
                                    title: Text(
                                      '\$ 500 / year',
                                      style: TextStyle(
                                          color: AppColor.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                    value: "500Y",
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value.toString();
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Live event viewing\nAll articles\nSpecific invites to specific events\nPhoto posting capacity\nChat with all III and IV users',
                                      style: TextStyle(
                                          color: AppColor.white, fontSize: 10),
                                    ),
                                  ),
                                ],
                              ));
                        if (index == 4)
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                  color: AppColor.black,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Inner Circle Membership',
                                    style: TextStyle(
                                        color: AppColor.primarycolor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  RadioListTile(
                                    contentPadding: EdgeInsets.zero,
                                    visualDensity: const VisualDensity(
                                        horizontal: VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity),
                                    activeColor: AppColor.primarycolor,
                                    fillColor: MaterialStateColor.resolveWith(
                                            (states) => AppColor.primarycolor),
                                    title: Text(
                                      '\$ 1000 / month',
                                      style: TextStyle(
                                          color: AppColor.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                    value: "1000M",
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value.toString();
                                      });
                                    },
                                  ),
                                  RadioListTile(
                                    contentPadding: EdgeInsets.zero,
                                    visualDensity: const VisualDensity(
                                        horizontal: VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity),
                                    activeColor: AppColor.primarycolor,
                                    fillColor: MaterialStateColor.resolveWith(
                                            (states) => AppColor.primarycolor),
                                    title: Text(
                                      '\$ 1000 / year',
                                      style: TextStyle(
                                          color: AppColor.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                    value: "1000Y",
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value.toString();
                                      });
                                    },
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      'All live events\nAll articles\nAll virtual events\nChat with anyone\nPhoto posting capacity ',
                                      style: TextStyle(
                                          color: AppColor.white, fontSize: 10),
                                    ),
                                  ),
                                ],
                              ));
                        if (index == 5)
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                  color: AppColor.black,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Corporate-Specific',
                                    style: TextStyle(
                                        color: AppColor.primarycolor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  RadioListTile(
                                    contentPadding: EdgeInsets.zero,
                                    visualDensity: const VisualDensity(
                                        horizontal: VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity),
                                    activeColor: AppColor.primarycolor,
                                    fillColor: MaterialStateColor.resolveWith(
                                            (states) => AppColor.primarycolor),
                                    title: Text(
                                      'Base subscription access. NOT III, IV, or V',
                                      style: TextStyle(
                                          color: AppColor.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                    value: "base",
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value.toString();
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      'All content that is company-specific. \nOnly employees of that company will see that content',
                                      style: TextStyle(
                                          color: AppColor.white, fontSize: 10),
                                    ),
                                  ),
                                ],
                              ));*/
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 8,
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (gender != null) {
                        Get.toNamed("/CheckOut",arguments :[
                          content,
                          plan
                        ]);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 30),
                      height: 45,
                      decoration: BoxDecoration(
                          color: AppColor.primarycolor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: Text('Buy now',
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
          ):Container(),
      )

    );
  }
}
