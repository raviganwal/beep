class MessagesModel {
  int? code;
  int? totalRecords;
  int? limitPerPage;
  String? notifUrl;
  List<Message>? data;

  MessagesModel(
      {this.code,
      this.totalRecords,
      this.limitPerPage,
      this.notifUrl,
      this.data});

  MessagesModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    totalRecords = json['total_records'];
    limitPerPage = json['limit_per_page'];
    notifUrl = json['notif_url'];
    if (json['data'] != null) {
      data = <Message>[];
      json['data'].forEach((v) {
        data!.add(Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = code;
    data['total_records'] = totalRecords;
    data['limit_per_page'] = limitPerPage;
    data['notif_url'] = notifUrl;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Message {
  String? notifTitle;
  String? notifBody;
  String? image;
  String? notifUrl;
  String? createdAt;

  Message(
      {this.notifTitle,
      this.notifBody,
      this.image,
      this.notifUrl,
      this.createdAt});

  Message.fromJson(Map<String, dynamic> json) {
    notifTitle = json['notif_title'];
    notifBody = json['notif_body'];
    image = json['image'];
    notifUrl = json['notif_url'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['notif_title'] = notifTitle;
    data['notif_body'] = notifBody;
    data['image'] = image;
    data['notif_url'] = notifUrl;
    data['created_at'] = createdAt;
    return data;
  }
}
