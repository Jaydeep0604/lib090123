import 'package:luxury_council/models/articlelist/articlelistmodel.dart';

class ArticleListResponce {
  List<ArticleListModel>? articleListModel;
  bool? status;
  String? message;

  ArticleListResponce({this.articleListModel, this.status, this.message});

  ArticleListResponce.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      articleListModel = <ArticleListModel>[];
      json['data'].forEach((v) {
        articleListModel!.add(new ArticleListModel.fromJson(v));
      });
    } 
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.articleListModel != null) {
      data['data'] = this.articleListModel!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}