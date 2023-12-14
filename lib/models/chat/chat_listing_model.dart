class ChatListingModel {
  List<ChatData>? data;
  bool? status;
  String? message;

  ChatListingModel({this.data, this.status, this.message});

  ChatListingModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ChatData>[];
      json['data'].forEach((v) {
        data!.add(new ChatData.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class ChatData {
  int? appUserId;
  String? firstName;
  String? lastName;
  String? email;
  int? subscriptionId;
  int? subscriptionExpired;

  ChatData(
      {this.appUserId,
        this.firstName,
        this.lastName,
        this.email,
        this.subscriptionId,
        this.subscriptionExpired});

  ChatData.fromJson(Map<String, dynamic> json) {
    appUserId = json['app_user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    subscriptionId = json['subscription_id'];
    subscriptionExpired = json['subscription_expired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app_user_id'] = this.appUserId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['subscription_id'] = this.subscriptionId;
    data['subscription_expired'] = this.subscriptionExpired;
    return data;
  }
}
