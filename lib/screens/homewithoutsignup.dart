import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luxury_council/colors.dart';
import 'package:luxury_council/controllers/editprofileController.dart';
import 'package:luxury_council/controllers/homeController.dart';
import 'package:luxury_council/controllers/loginController.dart';
import 'package:luxury_council/widgets/drawer.dart';
import 'package:luxury_council/widgets/multi_select.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

import '../config/prefrance.dart';

class HomeWithoutSignUp extends StatefulWidget {
  const HomeWithoutSignUp({super.key});

  @override
  State<HomeWithoutSignUp> createState() => _HomeWithoutSignUpState();
}

class _HomeWithoutSignUpState extends State<HomeWithoutSignUp> {
  final HomeController homeController = Get.put(HomeController());
  final LoginController loginController = Get.put(LoginController());
  final EditProfileController editProfileController =
      Get.put(EditProfileController());
  late ScrollController _scrollController;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final _key1 = UniqueKey();
  List<String> _selectedItems = [];
  
  int _pageNumber = 10;
  

  @override
  void initState() {
    homeController.getNonSubscribeArticleList(context, 0, 10, "", "", "", "");
    editProfileController.getprofile(context);
    super.initState();

    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
  }

  bool startedPlaying = false;

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() async {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          setState(() {
            _pageNumber = _pageNumber + 10;
          });

          if (homeController.noarticlelistresponce.isTrue) {
            print('object = ' + _pageNumber.toString());
            homeController.getNonSubscribeArticleList(
                context, 0, _pageNumber, "", "", "", "");
          }
          
        }
      }
    });
    return Scaffold(
      backgroundColor: AppColor.loginappbar,
      key: _key,
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.only(left: 8),
          child: GestureDetector(
              onTap: () {
                _key.currentState!.openDrawer();
              },
              child: Icon(
                Icons.menu,
                color: AppColor.white,
                size: 30,
              )),
        ),
        title: Container(
          margin: EdgeInsets.only(right: 8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/logo-img.png",
              scale: 2.9,
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
        backgroundColor: AppColor.appbar,
        //   shadowColor: AppColor.loginappbar,
        centerTitle: true,
        bottomOpacity: 1.0,
        elevation: 4,
      ),
      drawer: DrawerWidget2(),
      body: SafeArea(
          child: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              // Container(
              //   height: 40,
              //   margin: EdgeInsets.only(top: 15),
              //   child: TextFormField(
              //     style: TextStyle(fontSize: 14, color: AppColor.white),
              //     decoration: InputDecoration(
              //         filled: true,
              //         fillColor: AppColor.black,
              //         contentPadding: EdgeInsets.all(8),
              //         hintText: 'Search....',
              //         prefixIcon: Image.asset(
              //           'assets/search.png',
              //           scale: 2.9,
              //         ),
              //         hintStyle: TextStyle(color: Colors.white, fontSize: 12),
              //         disabledBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //         border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //         enabledBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //         focusedBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //         focusedErrorBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //         errorBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(10),
              //         )),
              //   ),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     GestureDetector(
              //       onTap: () {
              //         // _showCategorySelect();
              //       },
              //       child: Container(
              //         margin: EdgeInsets.only(top: 10),
              //         height: 30,
              //         width: 100,
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(10),
              //             border: Border.all(color: AppColor.primarycolor)),
              //         child: Center(
              //             child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //           children: [
              //             Text(
              //               'Categories',
              //               style:
              //                   TextStyle(color: AppColor.white, fontSize: 10),
              //             ),
              //             Image.asset(
              //               'assets/dropdown.png',
              //               scale: 2.9,
              //             )
              //           ],
              //         )),
              //       ),
              //     ),
              //     GestureDetector(
              //       onTap: () {
              //         // _showMediatypeSelect();
              //       },
              //       child: Container(
              //         margin: EdgeInsets.only(top: 10),
              //         height: 30,
              //         width: 100,
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(10),
              //             border: Border.all(color: AppColor.primarycolor)),
              //         child: Center(
              //             child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //           children: [
              //             Text(
              //               'Media Type',
              //               style:
              //                   TextStyle(color: AppColor.white, fontSize: 10),
              //             ),
              //             Image.asset(
              //               'assets/dropdown.png',
              //               scale: 2.9,
              //             )
              //           ],
              //         )),
              //       ),
              //     )
              //   ],
              // ),

              Obx(
                 () => Container(
                    margin: EdgeInsets.only(top: 15),
                    child: homeController.nosubsvideoList.isNotEmpty
                        ? ListView.separated(
                            // controller: _scrollController,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            primary: false,
                            itemCount: homeController.nosubsvideoList.length,
                            itemBuilder: (context, index) {
                              ChewieController _chewieController =
                                  ChewieController(
                                videoPlayerController:
                                    VideoPlayerController.network(
                                        '${homeController.nosubsvideoList[index].video}',
                                        videoPlayerOptions: VideoPlayerOptions(
                                            allowBackgroundPlayback: false,
                                            mixWithOthers: true)),
                                aspectRatio: 16 / 9,
                                allowMuting: true,
                                progressIndicatorDelay: null,
                              );

                              return Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColor.grey, width: 1),
                                  color: AppColor.black,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(20),
                                      child: AspectRatio(
                                        aspectRatio: 16 / 9,
                                        child: Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: <Widget>[
                                            Chewie(
                                              controller: _chewieController,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'VIDEO',
                                              style: TextStyle(
                                                  color: AppColor.primarycolor,
                                                  fontSize: 12),
                                            ),
                                            Text(
                                              "ABASPOR,SHAWN",
                                              style: TextStyle(
                                                  color: AppColor.white,
                                                  fontSize: 14),
                                            ),
                                            Text(
                                              "${homeController.nosubsvideoList[index].content}",
                                              style: TextStyle(
                                                  color: AppColor.textlight,
                                                  fontSize: 14),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: 8,
                              );
                            },
                          )
                        : Center(
                            child: Text(
                            'no data found',
                            style: TextStyle(color: AppColor.white),
                          ))),
              ),

              Obx(() => homeController.nosubsarticleList.isNotEmpty
                  ? Container(
                      margin: EdgeInsets.only(top: 15),
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: homeController.nosubsarticleList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppColor.grey, width: 1),
                              color: AppColor.grey,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 3.0, color: AppColor.black),
                              ],
                            ),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 200,
                                        child: Text(
                                          "${homeController.nosubsarticleList[index].articleName}",
                                          style: TextStyle(
                                              color: AppColor.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                      ),
                                      Container(
                                        width: 200,
                                        child: Text(
                                          "${homeController.nosubsarticleList[index].articalShortDesc}",
                                          style: TextStyle(
                                              color: AppColor.textlight,
                                              fontSize: 14),
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (homeController.nosubsarticleList[index]
                                      .image!.isNotEmpty)
                                    Stack(
                                      children: [
                                        Container(
                                          height: 90,
                                          width: 90,
                                          decoration: BoxDecoration(
                                              color: AppColor.primarycolor,
                                              border: Border.all(
                                                  color: AppColor.grey)),
                                          child: Stack(
                                            children: [
                                              Center(
                                                  child: homeController
                                                          .nosubsarticleList[
                                                              index]
                                                          .image!
                                                          .isNotEmpty
                                                      ? Image.network(
                                                          "${homeController.nosubsarticleList[index].image![0].imageurl}",
                                                          fit: BoxFit.cover,
                                                          height: 90,
                                                          width: 90,
                                                        )
                                                      : homeController
                                                                  .nosubsarticleList[
                                                                      index]
                                                                  .image!
                                                                  .length ==
                                                              2
                                                          ? Image.network(
                                                              "${homeController.nosubsarticleList[index].image![1].imageurl}",
                                                              fit: BoxFit.cover,
                                                              height: 90,
                                                              width: 90,
                                                            )
                                                          : SizedBox()),
                                              homeController
                                                          .nosubsarticleList[
                                                              index]
                                                          .mediaSelection ==
                                                      'Video'
                                                  ? Center(
                                                      child: Image.asset(
                                                        "assets/circularplay.png",
                                                        scale: 2.9,
                                                      ),
                                                    )
                                                  : SizedBox(),
                                              homeController
                                                          .nosubsarticleList[
                                                              index]
                                                          .mediaSelection ==
                                                      'Video'
                                                  ? Center(
                                                      child: Image.asset(
                                                        "assets/circularplay2.png",
                                                        scale: 2.9,
                                                      ),
                                                    )
                                                  : SizedBox(),
                                              homeController
                                                          .nosubsarticleList[
                                                              index]
                                                          .mediaSelection ==
                                                      'Video'
                                                  ? Container(
                                                      margin: EdgeInsets.only(
                                                          top: 2, left: 2),
                                                      child: Center(
                                                        child: Image.asset(
                                                          "assets/play.png",
                                                          scale: 2.9,
                                                        ),
                                                      ),
                                                    )
                                                  : homeController
                                                              .nosubsarticleList[
                                                                  index]
                                                              .mediaSelection ==
                                                          'Audio'
                                                      ? Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 2,
                                                                  left: 2),
                                                          child: Center(
                                                            child: Image.asset(
                                                              "assets/audio.png",
                                                              scale: 2.9,
                                                            ),
                                                          ),
                                                        )
                                                      : homeController
                                                                  .nosubsarticleList[
                                                                      index]
                                                                  .mediaSelection ==
                                                              'Resource'
                                                          ? Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 2,
                                                                      left: 2),
                                                              child: Center(
                                                                child:
                                                                    Image.asset(
                                                                  "assets/docs.png",
                                                                  scale: 30,
                                                                  color: AppColor
                                                                      .white,
                                                                ),
                                                              ),
                                                            )
                                                          : SizedBox()
                                            ],
                                          ),
                                        ),
                                        if (homeController
                                                    .nosubsarticleList[index]
                                                    .mediaSelection ==
                                                'Video' ||
                                            homeController
                                                    .nosubsarticleList[index]
                                                    .mediaSelection ==
                                                'Audio')
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: 45, top: 10),
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: AppColor.black),
                                              child: Center(
                                                  child: Text(
                                                '5:00',
                                                style: TextStyle(
                                                    color: AppColor.white,
                                                    fontSize: 9),
                                              ))),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 8,
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Text(
                      'no data found',
                      style: TextStyle(color: AppColor.white),
                    ))),

              // Container(
              //   margin: EdgeInsets.only(top: 15),
              //   child: ListView.separated(
              //     scrollDirection: Axis.vertical,
              //     shrinkWrap: true,
              //     primary: false,
              //     itemCount: 1,
              //     itemBuilder: (context, index) {
              //       return Container(
              //         width: MediaQuery.of(context).size.width,
              //         decoration: BoxDecoration(
              //           color: AppColor.black,
              //           boxShadow: [
              //             BoxShadow(blurRadius: 3.0, color: AppColor.black),
              //           ],
              //         ),
              //         child: Container(
              //           margin:
              //               EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Column(
              //                 mainAxisAlignment: MainAxisAlignment.start,
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Container(
              //                     width: 200,
              //                     child: Text(
              //                       '3 KEY TAKE-AWAYS ABOUT DIGITAL MARKETING FROM TOP BRANDS',
              //                       style: TextStyle(
              //                           color: AppColor.white,
              //                           fontWeight: FontWeight.bold,
              //                           fontSize: 10),
              //                     ),
              //                   ),
              //                   Container(
              //                     width: 200,
              //                     child: Text(
              //                       'Top-performing marketers — those ranked “Genius” on the Gartner Digital IQ index — offer critical lessons to use in email, on social, in advertising and on other channels. Contributor: Jackie Wiles',
              //                       style: TextStyle(
              //                           color: AppColor.textlight,
              //                           fontSize: 9),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //               Container(
              //                 height: 90,
              //                 width: 90,
              //                 child: Center(
              //                   child: Image.asset(
              //                     "assets/homeimage2.png",
              //                     fit: BoxFit.fitWidth,
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       );
              //     },
              //     separatorBuilder: (BuildContext context, int index) {
              //       return SizedBox(
              //         height: 8,
              //       );
              //     },
              //   ),
              // ),
              // Container(
              //   margin: EdgeInsets.only(top: 15),
              //   child: ListView.separated(
              //     scrollDirection: Axis.vertical,
              //     shrinkWrap: true,
              //     primary: false,
              //     itemCount: 1,
              //     itemBuilder: (context, index) {
              //       return Container(
              //         width: MediaQuery.of(context).size.width,
              //         decoration: BoxDecoration(
              //           border: Border.all(color: AppColor.grey, width: 1),
              //           color: AppColor.grey,
              //           boxShadow: [
              //             BoxShadow(blurRadius: 3.0, color: AppColor.black),
              //           ],
              //         ),
              //         child: Container(
              //           margin:
              //               EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.start,
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Container(
              //                 child: Text(
              //                   '3 KEY TAKE-AWAYS ABOUT DIGITAL MARKETING FROM TOP BRANDS',
              //                   style: TextStyle(
              //                       color: AppColor.white,
              //                       fontWeight: FontWeight.bold,
              //                       fontSize: 10),
              //                 ),
              //               ),
              //               Container(
              //                 child: Text(
              //                   'Top-performing marketers — those ranked “Genius” on the Gartner Digital IQ index — offer critical lessons to use in email, on social, in advertising and on other channels. Contributor: Jackie Wiles',
              //                   style: TextStyle(
              //                       color: AppColor.textlight,
              //                       fontSize: 9),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       );
              //     },
              //     separatorBuilder: (BuildContext context, int index) {
              //       return SizedBox(
              //         height: 8,
              //       );
              //     },
              //   ),
              // ),
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed("/Subscription");
                },
                child: Container(
                  height: 35,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColor.primarycolor),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Subscribe to view more',
                          style: TextStyle(color: AppColor.black, fontSize: 14),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          'assets/doublegreater.png',
                          scale: 2.9,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({required this.controller});

  static const List<Duration> _exampleCaptionOffsets = <Duration>[
    Duration(seconds: -10),
    Duration(seconds: -3),
    Duration(seconds: -1, milliseconds: -500),
    Duration(milliseconds: -250),
    Duration.zero,
    Duration(milliseconds: 250),
    Duration(seconds: 1, milliseconds: 500),
    Duration(seconds: 3),
    Duration(seconds: 10),
  ];
  static const List<double> _examplePlaybackRates = <double>[
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        Align(
          alignment: Alignment.topLeft,
          child: PopupMenuButton<Duration>(
            initialValue: controller.value.captionOffset,
            tooltip: 'Caption Offset',
            onSelected: (Duration delay) {
              controller.setCaptionOffset(delay);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<Duration>>[
                for (final Duration offsetDuration in _exampleCaptionOffsets)
                  PopupMenuItem<Duration>(
                    value: offsetDuration,
                    child: Text('${offsetDuration.inMilliseconds}ms'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.captionOffset.inMilliseconds}ms'),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (double speed) {
              controller.setPlaybackSpeed(speed);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<double>>[
                for (final double speed in _examplePlaybackRates)
                  PopupMenuItem<double>(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.playbackSpeed}x'),
            ),
          ),
        ),
      ],
    );
  }
}

class videowidget extends StatefulWidget {
  final bool play;
  final String url;

  const videowidget({Key? key, required this.url, required this.play})
      : super(key: key);

  @override
  _videowidgetstate createstate() => _videowidgetstate();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class _videowidgetstate extends State<videowidget> {
  late VideoPlayerController videoplayercontroller;
  late Future<void> _initializevideoplayerfuture;

  @override
  void initState() {
    super.initState();
    videoplayercontroller = new VideoPlayerController.network(widget.url);

    _initializevideoplayerfuture = videoplayercontroller.initialize().then((_) {
      //       ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});
    });
  } // this closing tag was missing

  @override
  void dispose() {
    videoplayercontroller.dispose();
    //    widget.videoplayercontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializevideoplayerfuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return new Container(
            child: Card(
              //  key: new pagestoragekey(widget.url),
              elevation: 5.0,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Chewie(
                      key: new PageStorageKey(widget.url),
                      controller: ChewieController(
                        videoPlayerController: videoplayercontroller,
                        aspectRatio: 3 / 2,
                        // prepare the video to be played and display the first frame
                        autoInitialize: true,
                        looping: false,
                        autoPlay: false,
                        // errors can occur for example when trying to play a video
                        // from a non-existent url
                        errorBuilder: (context, errormessage) {
                          return Center(
                            child: Text(
                              errormessage,
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
