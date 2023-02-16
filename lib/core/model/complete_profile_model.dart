class CompleteProfileModel {
  int? code;
  String? msg;
  String? completeProfileLink;

  CompleteProfileModel({this.code, this.msg, this.completeProfileLink});

  CompleteProfileModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    completeProfileLink = json['complete_profile_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    data['complete_profile_link'] = this.completeProfileLink;
    return data;
  }
}