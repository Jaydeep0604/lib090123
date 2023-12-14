class LoginModel {
  bool? status;
  String? message;
  User? user;
  String? token;

  LoginModel({this.status, this.message, this.user, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class User {
  int? appUserId;
  int? groupSubscriptionId;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  // int? company;
  Company? company;
  String? title;
  String? phoneNo;
  String? mailingAddress;
  String? assistantName;
  String? assistantEmail;
  String? assistantPhoneNo;
  int? subscriptionId;
  int? subscriptionType;
  String? subscriptionStartDate;
  int? appUserStatus;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  User(
      {this.appUserId,
      this.groupSubscriptionId,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.company,
      this.title,
      this.phoneNo,
      this.mailingAddress,
      this.assistantName,
      this.assistantEmail,
      this.assistantPhoneNo,
      this.subscriptionId,
      this.subscriptionType,
      this.subscriptionStartDate,
      this.appUserStatus,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  User.fromJson(Map<String, dynamic> json) {
    appUserId = json['app_user_id'];
    groupSubscriptionId = json['group_subscription_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    password = json['password'];
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;

    title = json['title'];
    phoneNo = json['phone_no'];
    mailingAddress = json['mailing_address'];
    assistantName = json['assistant_name'];
    assistantEmail = json['assistant_email'];
    assistantPhoneNo = json['assistant_phone_no'];
    subscriptionId = json['subscription_id'];
    subscriptionType = json['subscription_type'];
    subscriptionStartDate = json['subscription_start_date'];
    appUserStatus = json['app_user_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app_user_id'] = this.appUserId;
    data['group_subscription_id'] = this.groupSubscriptionId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
   if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    data['title'] = this.title;
    data['phone_no'] = this.phoneNo;
    data['mailing_address'] = this.mailingAddress;
    data['assistant_name'] = this.assistantName;
    data['assistant_email'] = this.assistantEmail;
    data['assistant_phone_no'] = this.assistantPhoneNo;
    data['subscription_id'] = this.subscriptionId;
    data['subscription_type'] = this.subscriptionType;
    data['subscription_start_date'] = this.subscriptionStartDate;
    data['app_user_status'] = this.appUserStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
class Company {
  int? companyId;
  String? companyName;

  Company({this.companyId, this.companyName});

  Company.fromJson(Map<String, dynamic> json) {
    companyId = json['company_id'];
    companyName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company_id'] = this.companyId;
    data['company_name'] = this.companyName;
    return data;
  }
}

