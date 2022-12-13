class NotificationsModel {
  int? code;
  int? totalRecords;
  int? limitPerPage;
  List<NotificationData>? data;

  NotificationsModel(
      {this.code, this.totalRecords, this.limitPerPage, this.data});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    totalRecords = json['total_records'];
    limitPerPage = json['limit_per_page'];
    if (json['data'] != null) {
      data = <NotificationData>[];
      json['data'].forEach((v) {
        data!.add(NotificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['total_records'] = totalRecords;
    data['limit_per_page'] = limitPerPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  String? id;
  String? notifTitle;
  String? description;
  String? createdAt;
  String? notified;

  NotificationData(
      {this.id,
        this.notifTitle,
        this.description,
        this.createdAt,
        this.notified});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notifTitle = json['notif_title'];
    description = json['description'];
    createdAt = json['created_at'];
    notified = json['notified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['notif_title'] = notifTitle;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['notified'] = notified;
    return data;
  }
}