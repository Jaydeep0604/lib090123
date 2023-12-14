import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:luxury_council/colors.dart';
import 'package:luxury_council/controllers/homeController.dart';
import 'package:luxury_council/controllers/loginController.dart';
import 'package:luxury_council/widgets/drawer.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/src/webview_flutter_legacy.dart';
import 'package:open_file/open_file.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class ArticleVideoAudioDetails extends StatefulWidget {
  const ArticleVideoAudioDetails({super.key});

  @override
  State<ArticleVideoAudioDetails> createState() =>
      _ArticleVideoAudioDetailsState();
}

class _ArticleVideoAudioDetailsState extends State<ArticleVideoAudioDetails> {
  final HomeController homeController = Get.put(HomeController());
  final LoginController loginController = Get.put(LoginController());
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final _key1 = UniqueKey();
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  late ScrollController _scrollController;
  int _pageNumber = 10;

  bool like = false;
  void _toggleView() {
    setState(() {
      like = !like;
    });
  }

  num _stackToView = 1;
  String downloadFolderPath = "";

  @override
  void initState() {
    askPermission();
    initPlatformState();
    _scrollController = ScrollController();
    super.initState();
  }

  void initPlatformState() async {
    downloadFolderPath = await getDownloadPath() ?? "";
    print("folder path :::::: $downloadFolderPath");
    if (!mounted) return;
  }

  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists())
          directory = await getExternalStorageDirectory();
      }
    } catch (err, stack) {
      print("Cannot get download folder path");
    }
    return directory?.path;
  }

  Future<void> _startDownload(
      BuildContext context, String fileUrl, String savePath) async {
    context.loaderOverlay.show();
    final filename = fileUrl.substring(fileUrl.lastIndexOf("/") + 1);
    print("file url ::: $fileUrl");
    print("savePath ::: $savePath");
    print("file name ::: $filename");
    print("file download url ::: ${savePath + "/" + filename}");
    try {
      await Dio().download(fileUrl, savePath + "/" + filename);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Download completed'),),
      // );
      context.loaderOverlay.hide();
      OpenFile.open(savePath + "/" + filename);
    } catch (e) {
      context.loaderOverlay.hide();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Download failed: $e')),
      );
      print("Download failed: $e");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _ArticleVideoAudioDetailsState();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey,
      key: _key,
      appBar: AppBar(
        leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(color: AppColor.appbar.withOpacity(0.001),
          padding: EdgeInsets.only(left: 8),
          width: 50,
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColor.white,
            size: 20,
          ),
        ),
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
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        child: Obx(
          () => Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: homeController.article_id != null
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppColor.grey,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          primary: false,
                          itemCount: homeController.image.length,
                          itemBuilder: (context, index) {
                            if (homeController.image[index] != null)
                              return Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                child: Image.network(
                                  "${homeController.image[index]}",
                                  fit: BoxFit.cover,
                                  // scale: 2.9,
                                ),
                              );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 8,
                            );
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 300,
                              child: Text(
                                "${homeController.article_name}",
                                style: TextStyle(
                                  color: AppColor.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // _toggleView();
                                if (homeController.fav.value == 0) {
                                  homeController.Favourite1(
                                    context,
                                    int.parse(
                                        homeController.article_id.toString()),
                                    // int.parse(
                                    // loginController.appuserid.toString()),
                                    1,
                                  );
                                } else if (homeController.fav.value == 1) {
                                  homeController.Favourite1(
                                    context,
                                    int.parse(
                                        homeController.article_id.toString()),
                                    //  int.parse(
                                    // loginController.appuserid.toString()),
                                    0,
                                  );
                                }
                              },
                              child: Obx(
                                () => Container(
                                  margin: EdgeInsets.only(top: 0),
                                  child: Image.asset(
                                    homeController.fav.value == 1
                                        ? 'assets/heart.png'
                                        : 'assets/heart1.png',
                                    scale: homeController.fav.value == 1
                                        ? 1.4
                                        : 1.2,
                                    color: AppColor.primarycolor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(top: 3),
                                child: Icon(
                                  Icons.circle,
                                  size: 10,
                                  color: AppColor.white,
                                )),
                            Text(
                              "  Authore name:- ${homeController.publisher} ",
                              style: TextStyle(
                                  color: AppColor.white, fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(top: 3),
                                child: Icon(
                                  Icons.circle,
                                  size: 10,
                                  color: AppColor.white,
                                )),
                            Text(
                              "  Date:- ${homeController.publish_date} ",
                              style: TextStyle(
                                  color: AppColor.white, fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        homeController.youtube_url.isNotEmpty
                            ? Container(
                                alignment: Alignment.topLeft,
                                // width: 330,
                                width: MediaQuery.of(context).size.width,
                                height: 300,
                                child: WebView(
                                  // onWebViewCreated:
                                  //     (WebViewController webViewController) {
                                  //   _controller.complete(webViewController);
                                  // },
                                  key: _key1,
                                  javascriptMode: JavascriptMode.unrestricted,
                                  initialUrl: '${homeController.youtube_url}',
                                ))
                            : SizedBox(),
                        homeController.audio.isNotEmpty
                            ? Container(
                                alignment: Alignment.topLeft,
                                // width: 330,
                                width: MediaQuery.of(context).size.width,
                                height: 300,
                                child: WebView(
                                  onPageFinished: (url) {
                                    setState(() {
                                      _stackToView = 0;
                                    });
                                  },
                                  // onWebViewCreated:
                                  //     (WebViewController webViewController) {
                                  //   _controller.complete(webViewController);
                                  // },
                                  key: _key1,
                                  javascriptMode: JavascriptMode.unrestricted,
                                  initialUrl: '${homeController.audio}',
                                ))
                            : SizedBox(),
                        homeController.resource.isNotEmpty
                            ? Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          // color: AppColor.black,
                                          border:
                                              Border.all(color: AppColor.black),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      alignment: Alignment.topLeft,
                                      // width: 330,
                                      width: MediaQuery.of(context).size.width,
                                      height: 100,
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/docs.png",
                                              scale: 15,
                                              color: AppColor.primarycolor,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                _startDownload(
                                                  context,
                                                  '${homeController.resource}',
                                                  downloadFolderPath,
                                                );
                                              },
                                              child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 3,
                                                      vertical: 3),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: AppColor
                                                              .primarycolor),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Text(
                                                    'Download',
                                                    style: TextStyle(
                                                        color: AppColor
                                                            .primarycolor),
                                                  )),
                                            )
                                          ],
                                        ),
                                      )),
                                ],
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 6,
                        ),
                        Container(
                          child: Html(
                              style: {
                                "body": Style(
                                  color: AppColor.white,
                                  fontSize: FontSize(14.0),
                                ),
                              },
                              data:
                                  "${homeController.artical_long_desc.toString()}"),
                        ),
                      ],
                    ))
                : Center(
                    child: Text(
                    "No data found",
                    style: TextStyle(color: AppColor.primarycolor),
                  )),
          ),
        ),
      ),
    );
  }

  Future<void> askPermission() async {
    print("ask permission called---------------------------------");
    //storage permission
    var isStoragePermissionDenied = await Permission.storage.isDenied;
    print("Storage permission status : $isStoragePermissionDenied");
    if (isStoragePermissionDenied) {
      var status = await Permission.storage.request();
    }

    // photo permission
    var isPhotoPermissionDenied = await Permission.photos.isDenied;
    print("Photo permission status : $isPhotoPermissionDenied");
    if (isPhotoPermissionDenied) {
      var status = await Permission.photos.request();
    }

    // video permission
    var isVideoPermissionDenied = await Permission.videos.isDenied;
    print("Video permission status : $isVideoPermissionDenied");
    if (isVideoPermissionDenied) {
      var status = await Permission.videos.request();
    }

    //manage external storage permission
    var isExtStoragePermissionDenied =
        await Permission.manageExternalStorage.isDenied;
    print("External Storage permission status : $isExtStoragePermissionDenied");
    if (isExtStoragePermissionDenied) {
      var status = await Permission.manageExternalStorage.request();
    }
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
              ? const SizedBox.shrink()
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
