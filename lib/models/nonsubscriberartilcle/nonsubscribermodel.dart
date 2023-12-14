


class Video {
  String? video;
  String? content;

  Video({this.video, this.content});

  Video.fromJson(Map<String, dynamic> json) {
    video = json['video'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['video'] = this.video;
    data['content'] = this.content;
    return data;
  }
}

class Article {
  int? articleId;
  String? articleName;
  String? searchText;
 // String? image;
 List<Images>? image;
  String? mediaSelection;
  String? articalShortDesc;
  String? youtubeUrl;
  String? audio;
  String? resource;
  String? publisher;
  String? publishDate;

  Article(
      {this.articleId,
      this.articleName,
      this.searchText,
      this.image,
      this.mediaSelection,
      this.articalShortDesc,
      this.youtubeUrl,
      this.audio,
      this.resource,
      this.publisher,
      this.publishDate});

  Article.fromJson(Map<String, dynamic> json) {
    articleId = json['article_id'];
    articleName = json['article_name'];
    searchText = json['search_text'];
   // image = json['image'];
    if (json['image'] != null) {
      image = <Images>[];
      json['image'].forEach((v) {
        image!.add(new Images.fromJson(v));
      });
    }
    mediaSelection = json['media_selection'];
    articalShortDesc = json['artical_short_desc'];
    youtubeUrl = json['youtube_url'];
    audio = json['audio'];
    resource = json['resource'];
    publisher = json['publisher'];
    publishDate = json['publish_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['article_id'] = this.articleId;
    data['article_name'] = this.articleName;
    data['search_text'] = this.searchText;
    //data['image'] = this.image;
     if (this.image != null) {
      data['image'] = this.image!.map((v) => v.toJson()).toList();
    }
    data['media_selection'] = this.mediaSelection;
    data['artical_short_desc'] = this.articalShortDesc;
    data['youtube_url'] = this.youtubeUrl;
    data['audio'] = this.audio;
    data['resource'] = this.resource;
    data['publisher'] = this.publisher;
    data['publish_date'] = this.publishDate;
    return data;
  }
}
class Images {
  String? imageurl;

  Images({this.imageurl});

  Images.fromJson(Map<String, dynamic> json) {
    imageurl = json['imageurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageurl'] = this.imageurl;
    return data;
  }
}