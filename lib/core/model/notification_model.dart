class NotificationsModel {
  int? code;
  int? totalRecords;
  int? limitPerPage;
  String? notifUrl;
  List<Data>? data;

  NotificationsModel(
      {this.code,
        this.totalRecords,
        this.limitPerPage,
        this.notifUrl,
        this.data});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    totalRecords = json['total_records'];
    limitPerPage = json['limit_per_page'];
    notifUrl = json['notif_url'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['total_records'] = this.totalRecords;
    data['limit_per_page'] = this.limitPerPage;
    data['notif_url'] = this.notifUrl;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? notifTitle;
  String? notifBody;
  String? image;
  String? createdAt;

  Data({this.notifTitle, this.notifBody, this.image, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    notifTitle = json['notif_title'];
    notifBody = json['notif_body'];
    image = json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notif_title'] = this.notifTitle;
    data['notif_body'] = this.notifBody;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    return data;
  }
}