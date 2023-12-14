import 'nonsubscribermodel.dart';

class NonSubscriberArticleResponce {
  NonSubscribeModel? nonSubscribeModel;
  bool? status;
  String? message;

  NonSubscriberArticleResponce({this.nonSubscribeModel, this.status, this.message});

  NonSubscriberArticleResponce.fromJson(Map<String, dynamic> json) {
    nonSubscribeModel = json['data'] != null ? new NonSubscribeModel.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nonSubscribeModel != null) {
      data['data'] = this.nonSubscribeModel!.toJson();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
class NonSubscribeModel {
  List<Video>? video;
  List<Article>? article;

  NonSubscribeModel({this.video, this.article});

  NonSubscribeModel.fromJson(Map<String, dynamic> json) {
    if (json['video'] != null) {
      video = <Video>[];
      json['video'].forEach((v) {
        video!.add(new Video.fromJson(v));
      });
    }
    if (json['article'] != null) {
      article = <Article>[];
      json['article'].forEach((v) {
        article!.add(new Article.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.video != null) {
      data['video'] = this.video!.map((v) => v.toJson()).toList();
    }
    if (this.article != null) {
      data['article'] = this.article!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
