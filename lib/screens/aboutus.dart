
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:luxury_council/colors.dart';
import 'package:luxury_council/controllers/aboutus_controller.dart';
import 'package:luxury_council/strings.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../widgets/app_loader.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final AboutUsController aboutUsController = Get.put(AboutUsController());
  WebViewController? webViewController;
  CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  void initState() {
    aboutUsController.getAboutUsAPI(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey,
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.only(left: 18),
          child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColor.white,
                size: 20,
              )),
        ),
        leadingWidth: 30,
        title: Text(
          'ABOUT US',
          style: TextStyle(
              color: AppColor.white, fontWeight: FontWeight.bold, fontSize: 16),
          textAlign: TextAlign.left,
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
        backgroundColor: AppColor.appbar,
        //   shadowColor: AppColor.loginappbar,
        centerTitle: false,
        bottomOpacity: 1.0,
        elevation: 4,
      ),
      body:
      Obx(()=>
          aboutUsController.aboutUs.value?.header != null ?
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    aboutUsController.aboutUs.value?.header ?? '',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.white, fontSize: 15)),
                SizedBox(height: 10,),
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    child:
                    CachedNetworkImage(
                      imageUrl:aboutUsController.aboutUs.value?.image ?? '',
                      placeholder: (context, url) =>
                      const AppLoader(type: LoaderType.activityIndicator),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                HtmlWidget(aboutUsController.aboutUs.value?.headerLongDesc ?? ''),
               /* WebViewWidget(controller:WebViewController()
                  ..setJavaScriptMode(JavaScriptMode.unrestricted)
                  ..setNavigationDelegate(NavigationDelegate(
                    onProgress: (int progress) {
                      // Update loading bar.
                      if (mounted) {
                        setState(() {
                          // _progressValue = progress / 100;
                        });
                      }
                    },
                  ))
                  ..loadRequest(Uri.dataFromString(aboutUsController.description.value, mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))) ,),*/
                SizedBox(
                  height: 15,
                ),
                Container(
                  color: AppColor.black,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(
                      horizontal: 15, vertical: 7),
                  child: Text(
                    testmonials,
                    style: TextStyle(
                        color: AppColor.primarycolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                CarouselSlider.builder(
                  carouselController: carouselController,
                    itemCount: (aboutUsController.aboutUs.value?.testimonials ?? []).length,
                    itemBuilder: (context, index, pageIndex){
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 17),
                        padding: EdgeInsets.symmetric(
                            horizontal: 15, vertical: 7),
                        decoration: BoxDecoration(
                            color: AppColor.black,
                            borderRadius: BorderRadius.circular(5)),
                        child:  Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${aboutUsController.aboutUs.value?.testimonials?[index].testimonialsName} (${aboutUsController.aboutUs.value?.testimonials?[index].testimonialsTitle})',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.white, fontSize: 15),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width /
                                  1.9,
                              child: Text(aboutUsController.aboutUs.value?.testimonials?[index].testimonialsDesc??'',
                                maxLines: 5,
                                style: TextStyle(
                                    color:
                                    AppColor.white,
                                    fontSize: 14),
                              ),
                            ),
                          ],
                        )
                        /*Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                padding: EdgeInsets.only(top: 8),
                                child: Image.asset(
                                  'assets/aboutprofile.png',
                                  scale: 2.9,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  aboutUsController.testimonialsList[index].testimonialsName??'',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.white, fontSize: 15),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width /
                                      1.9,
                                  child: Text(
                                    'Duis erat eros, dignissim nec erat at, sodales fringilla nisi. Aliquam convallis lacus eget tortor placerat, sed tincidunt mauris rhoncus.',
                                    style: TextStyle(
                                        color:
                                        AppColor.white,
                                        fontSize: 12),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )*/,
                      );
                    },
                    options: CarouselOptions(
                        aspectRatio: 16/6,
                      viewportFraction: 1.0,
                      reverse: false,
                      autoPlay: false,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason){
                          setState(() {
                            currentIndex = index;
                          });
                      }
                    )
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        carouselController.previousPage();
                      },
                      child: Image.asset(
                        'assets/leftarrow.png',
                        scale: 2.5,
                        color: currentIndex == 0 ?AppColor.white : AppColor.primarycolor,
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    GestureDetector(
                      onTap: (){
                        carouselController.nextPage();
                      },
                      child: Image.asset(
                        'assets/rightarrow.png',
                        scale: 1.4,
                        color: currentIndex == ((aboutUsController.aboutUs.value?.testimonials?.length ?? 0)-1) ?AppColor.white : AppColor.primarycolor,
                      ),
                    )
                  ],
                ),
                /* Container(
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
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              child: Image.asset(
                                'assets/homeimage.png',
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Luxury Limitless leverages The Luxury Marketing Council brand into a global powerhouse of luxury marketing, becoming the global thought-leader. This is done in three phrases: building the infrastructure in terms of personnel and procedures, secondarily by creating new products and services that offer monetary benefits to all parties, and thirdly by continuing to grow the network of chapters both domestically and internationally.',
                            style: TextStyle(
                                color: AppColor.white,
                                fontSize: 9),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Objectives of Luxury Limitless',
                            style: TextStyle(
                                color: AppColor.white,
                                fontSize: 9),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '- ',
                                style: TextStyle(
                                    color: AppColor.white,
                                    fontSize: 9),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 1.115,
                                child: Text(
                                  'To knit The Luxury Marketing Council brand, individual chapters, contacts and affiliations and venture ideas into a sum bigger than its parts… becoming Luxury Limitess.',
                                  style: TextStyle(
                                      color: AppColor.white,
                                      fontSize: 9),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '- ',
                                style: TextStyle(
                                    color: AppColor.white,
                                    fontSize: 9),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 1.115,
                                child: Text(
                                  'To leverage and share the knowledge base within The Luxury Marketing',
                                  style: TextStyle(
                                      color: AppColor.white,
                                      fontSize: 9),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '- ',
                                style: TextStyle(
                                    color: AppColor.white,
                                    fontSize: 9),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 1.115,
                                child: Text(
                                  'Council To create value-add opportunities for all players',
                                  style: TextStyle(
                                      color: AppColor.white,
                                      fontSize: 9),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '- ',
                                style: TextStyle(
                                    color: AppColor.white,
                                    fontSize: 9),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 1.115,
                                child: Text(
                                  'To expand The Luxury Marketing Council membership, reach, and brand awareness globally',
                                  style: TextStyle(
                                      color: AppColor.white,
                                      fontSize: 9),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '- ',
                                style: TextStyle(
                                    color: AppColor.white,
                                    fontSize: 9),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 1.115,
                                child: Text(
                                  'To increase the ROI and/or ROIC (Return on Investment Capital) of all parties involved: Founder, Investors and Licensee/Partners (L/Ps)',
                                  style: TextStyle(
                                      color: AppColor.white,
                                      fontSize: 9),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '- ',
                                style: TextStyle(
                                    color: AppColor.white,
                                    fontSize: 9),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 1.115,
                                child: Text(
                                  'To continue building an organization that is strong, sustaining and allows for an exit strategy with financial benefit for the Founder, Investors and Licensee/Partners',
                                  style: TextStyle(
                                      color: AppColor.white,
                                      fontSize: 9),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            color: AppColor.black,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 7),
                            child: Text(
                              'Testimonials',
                              style: TextStyle(
                                  color: AppColor.primarycolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 17),
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 7),
                            decoration: BoxDecoration(
                                color: AppColor.black,
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Image.asset(
                                      'assets/aboutprofile.png',
                                      scale: 2.9,
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Lorem ipsum',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                          color: AppColor.white, fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.9,
                                      child: Text(
                                        'Duis erat eros, dignissim nec erat at, sodales fringilla nisi. Aliquam convallis lacus eget tortor placerat, sed tincidunt mauris rhoncus.',
                                        style: TextStyle(
                                            color:
                                                AppColor.white,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/leftarrow.png',
                                scale: 2.5,
                                color: AppColor.white,
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Image.asset(
                                'assets/rightarrow.png',
                                scale: 1.4,
                              )
                            ],
                          )
                        ],
                      ));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 8,
                  );
                },
              ),
            ),*/
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ) : Container()
      ),
    );
  }

}
