import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:luxury_council/api_config/api_services.dart';
import 'package:luxury_council/api_config/urls.dart';
import 'package:luxury_council/config/colors.dart';
import 'package:luxury_council/config/prefrance.dart';
import 'package:luxury_council/models/articledetailslist/articledetailslistrequest.dart';
import 'package:luxury_council/models/articledetailslist/articledetailslistresponce.dart';
import 'package:luxury_council/models/articlelist/articlelistrequest.dart';
import 'package:luxury_council/models/articlelist/articlelistresponce.dart';
import 'package:luxury_council/models/categories/categorymodel.dart';
import 'package:luxury_council/models/categories/categoryrequest.dart';
import 'package:luxury_council/models/categories/categoryresponce.dart';
import 'package:luxury_council/models/nonsubscriberartilcle/nonsubscriberesponce.dart';
import 'package:luxury_council/models/nonsubscriberartilcle/nonsubscribermodel.dart';

import '../models/OwnerJobCategories.dart';
import '../models/articledetailslist/articledetailslistmodel.dart';
import '../models/articlelist/articlelistmodel.dart';

class HomeController extends GetxController {
  RxList<ArticleListModel> articleList = <ArticleListModel>[].obs;
  RxList<Video> nosubsvideoList = <Video>[].obs;
  RxList<Article> nosubsarticleList = <Article>[].obs;

  RxBool articlelistresponce = true.obs;
  RxBool noarticlelistresponce = true.obs;
  RxBool novideolistresponce = true.obs;
  RxBool articledetailslistresponce = true.obs;
  var article_id = 0.obs;
  var fav = 0.obs;
  var article_name = ''.obs;
  //var image = .obs;
  RxList<String> image = <String>[].obs;
  var media_selection = ''.obs;
  var artical_short_desc = ''.obs;
  var youtube_url = ''.obs;
  var audio = ''.obs;
  var resource = ''.obs;
  var publisher = ''.obs;
  var publish_date = ''.obs;
  var artical_long_desc = ''.obs;
  var appuseriddetails = 0.obs;
  var articleid1 = 0.obs;
  var appuserid1 = 0.obs;
  var favourites1 = 1.obs;

  void getArticleList(
    BuildContext context,
    int page,
    int limit,
    String searchtext,
    String searchcategory,
    String searchmedia,
    String searchinterest,
  ) {
    context.loaderOverlay.show();
    print("ARTICLE LIST URL ----> ${Urls.SUBSCRIBE_USER_ARTICLE_LIST}");
    ArticleListRequest articlelistRequest = ArticleListRequest(
        page: page,
        limit: limit,
        searchCategory: searchcategory,
        searchInterest: searchinterest,
        searchMedia: searchmedia,
        searchText: searchtext);
    print("ARTICLE LIST URL ----> ${jsonEncode(articlelistRequest)}");
    POST_API(articlelistRequest, Urls.SUBSCRIBE_USER_ARTICLE_LIST, context)
        .then((response) {
      print("ARTICLE LIST response ----> $response");
      Map<String, dynamic> map = jsonDecode(response);
      if (map["data"].isEmpty) {
        context.loaderOverlay.hide();
        articleList.clear();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'No Data Found',
            style: TextStyle(color: AppColor.white),
          ),
        ));
        articlelistresponce = false.obs;
      } else {
        if (map["status"] != true) {
          articlelistresponce = false.obs;
        } else {
          ArticleListResponce articlelistResponse =
              ArticleListResponce.fromJson(jsonDecode(response));
          articleList.clear();
          articleList.addAll((articlelistResponse.articleListModel ?? []));
        }
        context.loaderOverlay.hide();
      }
    }, onError: (error) {
      print("Error ---> ${error}");
      context.loaderOverlay.hide();
    });
  }

  void getNonSubscribeArticleList(
    BuildContext context,
    int page,
    int limit,
    String searchtext,
    String searchcategory,
    String searchmedia,
    String searchinterest,
  ) {
    context.loaderOverlay.show();
    print(
        "NON SUBSCRIBE ARTICLE LIST URL ----> ${Urls.NON_SUBSCRIBE_USER_ARTICLE_LIST}");
    ArticleListRequest articlelistRequest = ArticleListRequest(
        page: page,
        limit: limit,
        searchCategory: searchcategory,
        searchInterest: searchinterest,
        searchMedia: searchmedia,
        searchText: searchtext);
    print(
        "NON SUBSCRIBE ARTICLE LIST URL ----> ${jsonEncode(articlelistRequest)}");
    POST_API(articlelistRequest, Urls.NON_SUBSCRIBE_USER_ARTICLE_LIST, context)
        .then((response) {
      print("NON SUBSCRIBE ARTICLE LIST response ----> $response");
      Map<String, dynamic> map = jsonDecode(response);

      if (map["status"] != true) {
        noarticlelistresponce = false.obs;
        // novideolistresponce = false.obs;
      } else {
        NonSubscriberArticleResponce nonsubscribeResponse =
            NonSubscriberArticleResponce.fromJson(jsonDecode(response));
        nosubsvideoList.clear();
        nosubsvideoList
            .addAll((nonsubscribeResponse.nonSubscribeModel!.video ?? []));
        nosubsarticleList.clear();
        nosubsarticleList
            .addAll(nonsubscribeResponse.nonSubscribeModel!.article ?? []);
      }
      context.loaderOverlay.hide();
    }, onError: (error) {
      print("Error ---> ${error}");
      context.loaderOverlay.hide();
    });
  }

  void getArticleDetailsList(
    BuildContext context,
    int articleid,
  ) {
    context.loaderOverlay.show();
    print("ARTICLE DETAILS LIST URL ----> ${Urls.ARTICLE_DETAILS_LIST}");
    ArticleDetailsListRequest articledetailslistRequest =
        ArticleDetailsListRequest(articleid: articleid);
    print(
        "ARTICLE DETAILS LIST URL ----> ${jsonEncode(articledetailslistRequest)}");
    POST_API(articledetailslistRequest, Urls.ARTICLE_DETAILS_LIST, context)
        .then((response) async {
      print("ARTICLE DETAILS LIST response ----> $response");
      Map<String, dynamic> map = jsonDecode(response);

      if (map["status"] != true) {
        articledetailslistresponce = false.obs;
      } else {
        article_id.value = map['data']['article_id'];
        article_name.value = map['data']['article_name'];
        media_selection.value = map['data']['media_selection'];
        artical_short_desc.value = map['data']['artical_short_desc'];
        fav.value = map['data']['is_favorite'];
        appuseriddetails.value = await GetIntData("app_user_id");

        // image.value = map['data']['image'];
        image.clear();
        for (var list = 0; list < map['data']['image'].length; list++) {
          image.add(map['data']['image'][list]['imageurl']);
        }
        youtube_url.value = map['data']['youtube_url'] == null
            ? ''
            : map['data']['youtube_url'];

        audio.value = map['data']['audio'] == null ? '' : map['data']['audio'];
        resource.value =
            map['data']['resource'] == null ? '' : map['data']['resource'];
        publisher.value = map['data']['publisher'];
        publish_date.value = map['data']['publish_date'];
        artical_long_desc.value = map['data']['artical_long_desc'];
        print("article_id ${article_id.value}");
        print("fav ${fav.value}");
        print("youtube_url ${map['data']['youtube_url']}");
        print("=audio=== ${map['data']['audio']}");
        print("==resource====== ${map['data']['resource']}");
        // print("===========${map['data']['article_id']}");
        // print("===========${image.length}");
      }
      context.loaderOverlay.hide();
    });
  }

  Future<void> Favourite(BuildContext context, int articleid, int appuserid,
      int favourites, int position) async {
        
    int appuserids = await GetIntData("app_user_id");
    print("appuserid ${appuserids}");
    context.loaderOverlay.show();
    POST_API({
      "article_id": articleid,
      "app_user_id": appuserids,
      "is_favorite": favourites,
    }, Urls.Favourite, context)
        .then((response) {
      print("FAVOURITE response ----> $response");
      Map<String, dynamic> map = jsonDecode(response);

      if (map["status"] != true) {
        context.loaderOverlay.hide();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(map['message'])));
      } else {
        //print("articleid ${article_id.value}");
        if (favourites == 1) {
          articleList[position].is_favorite = 1;
          print("FAVOURITE response ----> 0");
        } else {
          articleList[position].is_favorite = 0;
          print("FAVOURITE response ---->1");
        }
        articleList.refresh();
        //articleList[position] == 1;
      }
      context.loaderOverlay.hide();
    });
  }

  Future<void> Favourite1(
    BuildContext context,
    int articleid,
   // int appuserid,
    int favourites,
  ) async {
    int appuserids = await GetIntData("app_user_id");
    context.loaderOverlay.show();
    POST_API({
      "article_id": article_id.value,
      "app_user_id": appuserids,
      "is_favorite": favourites,
    }, Urls.Favourite, context)
        .then((response) {
      print("FAVOURITE response ----> $response");
      Map<String, dynamic> map = jsonDecode(response);

      if (map["status"] != true) {
        context.loaderOverlay.hide();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(map['message'])));
      } else {
        //print("articleid ${article_id.value}");
        if (favourites== 1) {
          fav.value = 1;
          print("FAVOURITE response ----> 0");
        } else {
          fav.value = 0;
          print("FAVOURITE response ---->1");
        }
         articleList.refresh();
        //articleList[position] == 1;
      }
      context.loaderOverlay.hide();
    });
  }
}
