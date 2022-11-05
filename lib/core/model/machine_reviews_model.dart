class MachineReviewsModel {
  int? code;
  List<Review>? data;

  MachineReviewsModel({this.code, this.data});

  MachineReviewsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <Review>[];
      json['data'].forEach((v) {
        data!.add(Review.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Review {
  String? rating;
  String? message;
  String? remarks;
  String? createdAt;

  Review({this.rating, this.message, this.remarks, this.createdAt});

  Review.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    message = json['message'];
    remarks = json['remarks'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rating'] = rating;
    data['message'] = message;
    data['remarks'] = remarks;
    data['created_at'] = createdAt;
    return data;
  }
}