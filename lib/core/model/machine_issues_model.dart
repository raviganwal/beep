class IssuesModel {
  int? code;
  String? attachmentUrl;
  List<Issue>? data;

  IssuesModel({this.code, this.attachmentUrl, this.data});

  IssuesModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    attachmentUrl = json['attachment_url'];
    if (json['data'] != null) {
      data = <Issue>[];
      json['data'].forEach((v) {
        data!.add(new Issue.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['attachment_url'] = this.attachmentUrl;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Issue {
  String? id;
  String? issue;
  String? attachment;
  String? comment;
  String? status;
  String? createdAt;
  String? fixedBy;

  Issue(
      {this.id,
        this.issue,
        this.attachment,
        this.comment,
        this.status,
        this.createdAt,
        this.fixedBy});

  Issue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    issue = json['issue'];
    attachment = json['attachment'];
    comment = json['comment'];
    status = json['status'];
    createdAt = json['created_at'];
    fixedBy = json['fixed_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['issue'] = this.issue;
    data['attachment'] = this.attachment;
    data['comment'] = this.comment;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['fixed_by'] = this.fixedBy;
    return data;
  }
}