import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luxury_council/api_config/api_services.dart';
import 'package:luxury_council/colors.dart';
import 'package:luxury_council/controllers/editprofileController.dart';
import 'package:luxury_council/controllers/filterController.dart';
import 'package:luxury_council/controllers/homeController.dart';
import 'package:luxury_council/widgets/appbars.dart';
import 'package:luxury_council/widgets/drawer.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  final HomeController homeController = Get.put(HomeController());
  final FilterController filterController = Get.put(FilterController());
  final EditProfileController editProfileController =
      Get.put(EditProfileController());
  TextEditingController searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  int _selectedIndex = -1;
  late ScrollController _scrollController;
  int _pageNumber = 10;
  String categorys = '';
  String interests = '';
  String mediatypes = '';

  @override
  void initState() {
    homeController.getArticleList(
      context,
      0,
      10,
      searchController.text.toString(),
      categorys,
      mediatypes,
      interests,
    );
    filterController.getCategoriesList(context, null, 0, 100);
    filterController.getIntersetList(context, null, 0, 100);
    filterController.getMediaTypeList(
      context,
      null,
    );
    editProfileController.getprofile(context);
    // homeController.Favourite(context);
    _scrollController = ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() async {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          setState(() {
            _pageNumber = _pageNumber + 10;
          });
          if (homeController.articlelistresponce.isTrue) {
            print('object = ' + _pageNumber.toString());
            homeController.getArticleList(
              context,
              0,
              _pageNumber,
              searchController.text,
              categorys,
              mediatypes,
              interests,
            );
          }
        }
      }
    });
    return Scaffold(
      backgroundColor: AppColor.loginappbar,
      key: _key,
      appBar: AppBarDetails(appBar: AppBar(), text: 'FAVOURITE LIST'),
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Container(
              height: 40,
              margin: EdgeInsets.only(top: 15),
              child: TextFormField(
                controller: searchController,
                style: TextStyle(fontSize: 14, color: AppColor.white),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.black,
                    contentPadding: EdgeInsets.all(8),
                    hintText: 'Search....',
                    prefixIcon: Image.asset(
                      'assets/search.png',
                      scale: 2.9,
                    ),
                    hintStyle: TextStyle(color: Colors.white, fontSize: 14),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                onFieldSubmitted: (value) {
                  if (searchController.text.toString() != '') {
                    homeController.getArticleList(
                      context,
                      0,
                      10,
                      searchController.text.toString(),
                      categorys,
                      mediatypes,
                      interests,
                    );
                  } else {
                    homeController.getArticleList(
                      context,
                      0,
                      10,
                      searchController.text.toString(),
                      categorys,
                      mediatypes,
                      interests,
                    );
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => filterController.categorieList.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            _showCategorySelect(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(color: AppColor.primarycolor)),
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(
                                  () => Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      child: Text(
                                        filterController
                                                .selectedCategoryValuesToDisplay
                                                .value
                                                .isEmpty
                                            ? "Category"
                                            : filterController
                                                .selectedCategoryValuesToDisplay
                                                .value,
                                        // softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: AppColor.white,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                                Image.asset(
                                  'assets/dropdown.png',
                                  scale: 2.9,
                                ),
                                SizedBox(
                                  width: 5,
                                )
                              ],
                            )),
                          ),
                        )
                      : Center(child: Text("No data found")),
                ),
                Obx(
                  () => filterController.interestList.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            _showInterestSelect(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(color: AppColor.primarycolor)),
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(
                                  () => Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      child: Text(
                                        filterController
                                                .selectedIntersetValuesToDisplay
                                                .value
                                                .isEmpty
                                            ? "Interest"
                                            : filterController
                                                .selectedIntersetValuesToDisplay
                                                .value,
                                        // softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: AppColor.white,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                                Image.asset(
                                  'assets/dropdown.png',
                                  scale: 2.9,
                                ),
                                SizedBox(
                                  width: 5,
                                )
                              ],
                            )),
                          ),
                        )
                      : Center(child: Text("No data found")),
                ),
                Obx(
                  () => filterController.mediatList.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            _showMediaSelect(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(color: AppColor.primarycolor)),
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(
                                  () => Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      child: Text(
                                        filterController
                                                .selectedMediaValuesToDisplay
                                                .value
                                                .isEmpty
                                            ? "Media"
                                            : filterController
                                                .selectedMediaValuesToDisplay
                                                .value,
                                        // softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: AppColor.white,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                                Image.asset(
                                  'assets/dropdown.png',
                                  scale: 2.9,
                                ),
                                SizedBox(
                                  width: 5,
                                )
                              ],
                            )),
                          ),
                        )
                      : Center(child: Text("No data found")),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    Obx(
                      () => Container(
                        margin: EdgeInsets.only(top: 15),
                        child: homeController.articleList.isNotEmpty
                            ? ListView.separated(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                primary: false,
                                itemCount: homeController.articleList.length,
                                itemBuilder: (context, index) {
                                  return homeController
                                              .articleList[index].is_favorite ==
                                          1
                                      ? GestureDetector(
                                          onTap: () {
                                            homeController
                                                .getArticleDetailsList(
                                                    context,
                                                    homeController
                                                        .articleList[index]
                                                        .articleId as int);
                                            Get.toNamed(
                                                "/ArticleVideoAudioDetails");
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              color: AppColor.black,
                                            ),
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 5),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: homeController
                                                                .articleList[
                                                                    index]
                                                                .image!
                                                                .isNotEmpty
                                                            ? 200
                                                            : 310,
                                                        child: Text(
                                                          "${homeController.articleList[index].articleName}",
                                                          style: TextStyle(
                                                              color: AppColor
                                                                  .white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                      // HtmlWidget(
                                                      //     //to show HTML as widget.
                                                      //     htmlcode!,textStyle: TextStyle(color: AppColor.white),
                                                      //     ),
                                                      Container(
                                                        height: 60,
                                                        width: homeController
                                                                .articleList[
                                                                    index]
                                                                .image!
                                                                .isNotEmpty
                                                            ? 200
                                                            : 310,
                                                        child: Text(
                                                          "${homeController.articleList[index].articalShortDesc}",
                                                          style: TextStyle(
                                                              color: AppColor
                                                                  .textlight,
                                                              fontSize: 14),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 3,
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {
                                                            showDialog(
                                                                barrierDismissible:
                                                                    false,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (dialogContex) {
                                                                  return AlertDialog(
                                                                    content:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        
                                                                        Text(
                                                                          "Are you sure you want to remove favourite article?",
                                                                          style: TextStyle(
                                                                              fontSize: 18,
                                                                              color: AppColor.black),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              20,
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceAround,
                                                                          children: [
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: Container(
                                                                                height: 30,
                                                                                width: 80,
                                                                                decoration: BoxDecoration(color: AppColor.primarycolor, borderRadius: BorderRadius.circular(3)),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    'NO',
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                Get.back();
                                                                                if (homeController.articleList[index].is_favorite == 0) {
                                                                                  // homeController
                                                                                  // .articleList[index]
                                                                                  // .is_favorite =1;
                                                                                  homeController.Favourite(context, int.parse(homeController.articleList[index].articleId.toString()), int.parse(loginController.appuserid.toString()), 1, index);
                                                                                } else if (homeController.articleList[index].is_favorite == 1) {
                                                                                  //   homeController
                                                                                  // .articleList[index]
                                                                                  // .is_favorite = 0;
                                                                                  homeController.Favourite(context, int.parse(homeController.articleList[index].articleId.toString()), int.parse(loginController.appuserid.toString()), 0, index);
                                                                                }
                                                                              },
                                                                              child: Container(
                                                                                height: 30,
                                                                                width: 80,
                                                                                decoration: BoxDecoration(color: AppColor.primarycolor, borderRadius: BorderRadius.circular(3)),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    'YES',
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  );
                                                                });
                                                            // if (homeController
                                                            //         .articleList[
                                                            //             index]
                                                            //         .is_favorite ==
                                                            //     0) {
                                                            //   // homeController
                                                            //   // .articleList[index]
                                                            //   // .is_favorite =1;
                                                            //   homeController.Favourite(
                                                            //       context,
                                                            //       int.parse(homeController
                                                            //           .articleList[
                                                            //               index]
                                                            //           .articleId
                                                            //           .toString()),
                                                            //       int.parse(loginController
                                                            //           .appuserid
                                                            //           .toString()),
                                                            //       1,
                                                            //       index);
                                                            // } else if (homeController
                                                            //         .articleList[
                                                            //             index]
                                                            //         .is_favorite ==
                                                            //     1) {
                                                            //   //   homeController
                                                            //   // .articleList[index]
                                                            //   // .is_favorite = 0;
                                                            //   homeController.Favourite(
                                                            //       context,
                                                            //       int.parse(homeController
                                                            //           .articleList[
                                                            //               index]
                                                            //           .articleId
                                                            //           .toString()),
                                                            //       int.parse(loginController
                                                            //           .appuserid
                                                            //           .toString()),
                                                            //       0,
                                                            //       index);
                                                            // }
                                                          },
                                                          child: Icon(
                                                            Icons.remove_circle,
                                                            color: AppColor
                                                                .primarycolor,
                                                          ))
                                                    ],
                                                  ),
                                                  if (homeController
                                                          .articleList[index]
                                                          .mediaSelection
                                                          .toString() ==
                                                      'Video')
                                                    ...[]
                                                  else if ("" == "")
                                                    ...[],
                                                  if (homeController
                                                      .articleList[index]
                                                      .image!
                                                      .isNotEmpty)
                                                    Stack(
                                                      children: [
                                                        Container(
                                                          height: 90,
                                                          width: 90,
                                                          color: AppColor.grey,
                                                          // decoration: BoxDecoration(
                                                          //     border: Border.all(color: AppColor.grey)),
                                                          child: Stack(
                                                            children: [
                                                              if (homeController
                                                                      .articleList[
                                                                          index]
                                                                      .mediaSelection ==
                                                                  "Article")
                                                                Center(
                                                                  child: Image
                                                                      .network(
                                                                    "${homeController.articleList[index].image![0].imageurl}",
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    height: 90,
                                                                    width: 90,
                                                                  ),
                                                                ),
                                                              if (homeController
                                                                      .articleList[
                                                                          index]
                                                                      .mediaSelection ==
                                                                  "Video")
                                                                Center(
                                                                  child: Icon(
                                                                    Icons
                                                                        .video_settings,
                                                                    color: AppColor
                                                                        .primarycolor,
                                                                    size: 30,
                                                                  ),
                                                                ),
                                                              if (homeController
                                                                      .articleList[
                                                                          index]
                                                                      .mediaSelection ==
                                                                  "Audio")
                                                                Center(
                                                                  child: Image
                                                                      .asset(
                                                                    "assets/audio.png",
                                                                    scale: 2.9,
                                                                  ),
                                                                ),
                                                              if (homeController
                                                                      .articleList[
                                                                          index]
                                                                      .mediaSelection ==
                                                                  "Resource")
                                                                Center(
                                                                  child: Image
                                                                      .asset(
                                                                    "assets/docs.png",
                                                                    scale: 20,
                                                                    color: AppColor
                                                                        .primarycolor,
                                                                  ),
                                                                ),
                                                              // Center(
                                                              //     child: homeController
                                                              //             .articleList[
                                                              //                 index]
                                                              //             .image!
                                                              //             .isNotEmpty
                                                              //         ? Image.network(
                                                              //             "${homeController.articleList[index].image![0].imageurl}",
                                                              //             fit: BoxFit.cover,
                                                              //             height: 90,
                                                              //             width: 90,
                                                              //           )
                                                              //         : homeController
                                                              //                     .articleList[
                                                              //                         index]
                                                              //                     .image!
                                                              //                     .length ==
                                                              //                 2
                                                              //             ? Image.network(
                                                              //                 "${homeController.articleList[index].image![1].imageurl}",
                                                              //                 fit: BoxFit
                                                              //                     .cover,
                                                              //                 height: 90,
                                                              //                 width: 90,
                                                              //               )
                                                              //             : SizedBox()),
                                                              // homeController
                                                              //             .articleList[
                                                              //                 index]
                                                              //             .mediaSelection ==
                                                              //         'Video'
                                                              //     ? Center(
                                                              //         child: Image.asset(
                                                              //           "assets/circularplay.png",
                                                              //           scale: 2.9,
                                                              //         ),
                                                              //       )
                                                              //     : SizedBox(),
                                                              // homeController
                                                              //             .articleList[
                                                              //                 index]
                                                              //             .mediaSelection ==
                                                              //         'Video'
                                                              //     ? Center(
                                                              //         child: Image.asset(
                                                              //           "assets/circularplay2.png",
                                                              //           scale: 2.9,
                                                              //         ),
                                                              //       )
                                                              //     : SizedBox(),
                                                              // homeController
                                                              //             .articleList[
                                                              //                 index]
                                                              //             .mediaSelection ==
                                                              //         'Video'
                                                              //     ? Container(
                                                              //         margin:
                                                              //             EdgeInsets.only(
                                                              //                 top: 2,
                                                              //                 left: 2),
                                                              //         child: Center(
                                                              //           child: Image.asset(
                                                              //             "assets/play.png",
                                                              //             scale: 2.9,
                                                              //           ),
                                                              //         ),
                                                              //       )
                                                              //     : homeController
                                                              //                 .articleList[
                                                              //                     index]
                                                              //                 .mediaSelection ==
                                                              //             'Audio'
                                                              //         ? Container(
                                                              //             margin: EdgeInsets
                                                              //                 .only(
                                                              //                     top: 2,
                                                              //                     left: 2),
                                                              //             child: Center(
                                                              //               child:
                                                              //                   Image.asset(
                                                              //                 "assets/audio.png",
                                                              //                 scale: 2.9,
                                                              //               ),
                                                              //             ),
                                                              //           ):homeController
                                                              //                 .articleList[
                                                              //                     index]
                                                              //                 .mediaSelection ==
                                                              //             'Resource'?Container(
                                                              //             margin: EdgeInsets
                                                              //                 .only(
                                                              //                     top: 2,
                                                              //                     left: 2),
                                                              //             child: Center(
                                                              //               child:
                                                              //                   Image.asset(
                                                              //                 "assets/docs.png",
                                                              //                 scale: 30,color: AppColor.white,
                                                              //               ),
                                                              //             ),
                                                              //           )
                                                              //         : SizedBox()
                                                            ],
                                                          ),
                                                        ),
                                                        if (homeController
                                                                    .articleList[
                                                                        index]
                                                                    .mediaSelection ==
                                                                'Video' ||
                                                            homeController
                                                                    .articleList[
                                                                        index]
                                                                    .mediaSelection ==
                                                                'Audio')
                                                          Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 45,
                                                                      top: 10),
                                                              width: 40,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15),
                                                                  color: AppColor
                                                                      .black),
                                                              child: Center(
                                                                  child: Text(
                                                                '5:00',
                                                                style: TextStyle(
                                                                    color: AppColor
                                                                        .white,
                                                                    fontSize:
                                                                        9),
                                                              ))),
                                                      ],
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox();
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    height: 8,
                                  );
                                },
                              )
                            : Center(child: Text("No data found")),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
  // Future<void> FilterDialog(BuildContext context) {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context1) {
  //       return StatefulBuilder(// You need this, notice the parameters below:
  //           builder: (BuildContext context, StateSetter setState) {
  //         return AlertDialog(
  //           // title: Text('Filter',style: TextStyle(color: AppColor.black),),
  //           actions: <Widget>[
  //             Container(
  //               margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
  //               child: Column(
  //                 children: [
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.end,
  //                     children: [
  //                       Container(
  //                           margin: EdgeInsets.only(right: 80),
  //                           child: Text(
  //                             'Filter',
  //                             style: TextStyle(
  //                                 color: AppColor.black, fontSize: 20),
  //                           )),
  //                       GestureDetector(
  //                           onTap: () {
  //                             Get.back();
  //                           },
  //                           child: Icon(Icons.close))
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     height: 15,
  //                   ),
  //                   GestureDetector(
  //                     onTap: () => _showCategorySelect(context),
  //                     child: Container(
  //                       height: 38,
  //                       width: Get.width,
  //                       alignment: Alignment.centerLeft,
  //                       padding: EdgeInsets.all(5),
  //                       decoration: BoxDecoration(
  //                           color: AppColor.grey.withOpacity(0.1),
  //                           borderRadius: BorderRadius.circular(10),
  //                           border: Border.all(color: Color(0xFF757575))),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Obx(
  //                             () => Expanded(
  //                               child: Text(
  //                                 homeController
  //                                         .selectedJobCategoryValuesToDisplay
  //                                         .value
  //                                         .isEmpty
  //                                     ? "Select category"
  //                                     : homeController
  //                                         .selectedJobCategoryValuesToDisplay
  //                                         .value,
  //                                 softWrap: true,
  //                                 overflow: TextOverflow.ellipsis,
  //                               ),
  //                             ),
  //                           ),
  //                           Icon(Icons.keyboard_arrow_down, color: Colors.black)
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 15,
  //                   ),

  //                 ],
  //               ),
  //             ),
  //           ],
  //         );
  //       });
  //     },
  //   );
  // }
  void _showCategorySelect(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return Container(
          margin: EdgeInsets.only(right: 40, top: 130, bottom: 15),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          alignment: Alignment.topRight,
          child: MultiSelectDialog(
            title: Text(''),
            backgroundColor: AppColor.black,
            // separateSelectedItems: true,
            checkColor: AppColor.black,
            selectedColor: AppColor.primarycolor,
            unselectedColor: AppColor.primarycolor,
            itemsTextStyle: TextStyle(color: AppColor.white),
            selectedItemsTextStyle: TextStyle(color: AppColor.primarycolor),
            items: filterController.CategoryTextList.map(
                (element) => MultiSelectItem(element, element)).toList(),
            initialValue: filterController.CategorySelectedServices.value,
            onConfirm: (values) {
              filterController.CategorySelectedServices.value = values;
              filterController.selectedCategoryValuesToDisplay.value = "";
              values.forEach((element) {
                print("selected category : $element");
                filterController.selectedCategoryValuesToDisplay.value +=
                    element + ", ";
              });
              print('object${filterController.CategorySelectedServices.value}');

              if (filterController
                  .selectedCategoryValuesToDisplay.value.isNotEmpty) {
                filterController.selectedCategoryValuesToDisplay.value =
                    filterController.selectedCategoryValuesToDisplay.value
                        .replaceRange(
                  filterController
                          .selectedCategoryValuesToDisplay.value.length -
                      2,
                  filterController.selectedCategoryValuesToDisplay.value.length,
                  "",
                );

                List<String> ids = [];
                filterController.categorieList.forEach((element) {
                  filterController.CategorySelectedServices.forEach(
                      (ownerJobType) {
                    if (ownerJobType == element.categoryName) {
                      ids.add(element.categoryId.toString());
                    }
                  });
                });
                setState(() {
                  categorys = ids.join(',');
                });
                filterController.selectedCategoryValuesToDisplay.value;
                homeController.getArticleList(
                  context,
                  0,
                  10,
                  searchController.text.toString(),
                  categorys,
                  mediatypes,
                  interests,
                );
                print(
                    'object${filterController.CategorySelectedServices.value}');
              } else {
                setState(() {
                  categorys = '';
                });
                filterController.selectedCategoryValuesToDisplay.value;
                homeController.getArticleList(
                  context,
                  0,
                  10,
                  searchController.text.toString(),
                  categorys,
                  mediatypes,
                  interests,
                );
                print(
                    'object${filterController.IntersetSelectedServices.value}');
              }
            },
          ),
        );
      },
    );
  }

  void _showInterestSelect(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return Container(
          margin: EdgeInsets.only(right: 40, top: 130, bottom: 15),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          alignment: Alignment.topRight,
          child: MultiSelectDialog(
            title: Text(''),
            backgroundColor: AppColor.black,
            //separateSelectedItems: true,
            checkColor: AppColor.black,
            selectedColor: AppColor.primarycolor,
            unselectedColor: AppColor.primarycolor,
            itemsTextStyle: TextStyle(color: AppColor.white),
            selectedItemsTextStyle: TextStyle(color: AppColor.primarycolor),
            items: filterController.IntersetTextList.map(
                (element) => MultiSelectItem(element, element)).toList(),
            initialValue: filterController.IntersetSelectedServices.value,
            onConfirm: (values) {
              filterController.IntersetSelectedServices.value = values;
              filterController.selectedIntersetValuesToDisplay.value = "";
              values.forEach((element) {
                print("selected interest : $element");
                filterController.selectedIntersetValuesToDisplay.value +=
                    element + ", ";
              });
              print('object${filterController.IntersetSelectedServices.value}');
              // filterController.selectedIntersetValuesToDisplay.value =
              //     filterController.selectedIntersetValuesToDisplay.value
              //         .replaceRange(
              //   filterController.selectedIntersetValuesToDisplay.value.length -
              //       2,
              //   filterController.selectedIntersetValuesToDisplay.value.length,
              //   "",
              // );
              if (filterController
                  .selectedIntersetValuesToDisplay.value.isNotEmpty) {
                filterController.selectedIntersetValuesToDisplay.value =
                    filterController.selectedIntersetValuesToDisplay.value
                        .replaceRange(
                  filterController
                          .selectedIntersetValuesToDisplay.value.length -
                      2,
                  filterController.selectedIntersetValuesToDisplay.value.length,
                  "",
                );

                List<String> ids = [];
                filterController.interestList.forEach((element) {
                  filterController.IntersetSelectedServices.forEach(
                      (ownerJobType) {
                    if (ownerJobType == element.interestName) {
                      ids.add(element.interestId.toString());
                    }
                  });
                });
                setState(() {
                  interests = ids.join(',');
                });
                filterController.selectedIntersetValuesToDisplay.value;
                homeController.getArticleList(
                  context,
                  0,
                  10,
                  searchController.text.toString(),
                  categorys,
                  mediatypes,
                  interests,
                );
                print(
                    'object${filterController.IntersetSelectedServices.value}');
              } else {
                setState(() {
                  interests = '';
                });
                filterController.selectedIntersetValuesToDisplay.value;
                homeController.getArticleList(
                  context,
                  0,
                  10,
                  searchController.text.toString(),
                  categorys,
                  mediatypes,
                  interests,
                );
                print(
                    'object${filterController.IntersetSelectedServices.value}');
              }
            },
          ),
        );
      },
    );
  }

  void _showMediaSelect(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return Container(
          margin: EdgeInsets.only(right: 40, top: 130, bottom: 15),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          alignment: Alignment.topRight,
          child: MultiSelectDialog(
            title: Text(''),
            backgroundColor: AppColor.black,
            //separateSelectedItems: true,
            checkColor: AppColor.black,
            selectedColor: AppColor.primarycolor,
            unselectedColor: AppColor.primarycolor,
            itemsTextStyle: TextStyle(color: AppColor.white),
            selectedItemsTextStyle: TextStyle(color: AppColor.primarycolor),
            items: filterController.MediaTextList.map(
                (element) => MultiSelectItem(element, element)).toList(),
            initialValue: filterController.MediaSelectedServices.value,
            onConfirm: (values) {
              filterController.MediaSelectedServices.value = values;
              filterController.selectedMediaValuesToDisplay.value = "";
              values.forEach((element) {
                print("selected media type : $element");
                filterController.selectedMediaValuesToDisplay.value +=
                    element + ", ";
              });
              print('object${filterController.MediaSelectedServices.value}');
              if (filterController
                  .selectedMediaValuesToDisplay.value.isNotEmpty) {
                filterController.selectedMediaValuesToDisplay.value =
                    filterController.selectedMediaValuesToDisplay.value
                        .replaceRange(
                  filterController.selectedMediaValuesToDisplay.value.length -
                      2,
                  filterController.selectedMediaValuesToDisplay.value.length,
                  "",
                );

                List<String> ids = [];
                filterController.mediatList.forEach((element) {
                  filterController.MediaSelectedServices.forEach(
                      (ownerJobType) {
                    if (ownerJobType == element.mediaName) {
                      ids.add(element.mediaId.toString());
                    }
                  });
                });
                setState(() {
                  mediatypes = ids.join(',');
                });
                filterController.selectedMediaValuesToDisplay.value;
                homeController.getArticleList(
                  context,
                  0,
                  10,
                  searchController.text.toString(),
                  categorys,
                  mediatypes,
                  interests,
                );
                print('object${filterController.MediaSelectedServices.value}');
              } else {
                setState(() {
                  mediatypes = '';
                });
                filterController.selectedMediaValuesToDisplay.value;
                homeController.getArticleList(
                  context,
                  0,
                  10,
                  searchController.text.toString(),
                  categorys,
                  mediatypes,
                  interests,
                );
                print('object${filterController.MediaSelectedServices.value}');
              }
            },
          ),
        );
      },
    );
  }
}
