class ReportOptionsModel {
  int? code;
  List<ReportOption>? data;

  ReportOptionsModel({this.code, this.data});

  ReportOptionsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <ReportOption>[];
      json['data'].forEach((v) {
        data!.add(new ReportOption.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReportOption {
  String? id;
  String? issue;

  ReportOption({this.id, this.issue});

  ReportOption.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    issue = json['issue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['issue'] = this.issue;
    return data;
  }
}