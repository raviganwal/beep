class EarningsModel {
  int? code;
  String? totalEarnings;
  List<PaymentHistory>? paymentHistory;

  EarningsModel({this.code, this.totalEarnings, this.paymentHistory});

  EarningsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    totalEarnings = json['total_earnings'];
    if (json['payment_history'] != null) {
      paymentHistory = <PaymentHistory>[];
      json['payment_history'].forEach((v) {
        paymentHistory!.add(new PaymentHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['total_earnings'] = this.totalEarnings;
    if (this.paymentHistory != null) {
      data['payment_history'] =
          this.paymentHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentHistory {
  String? type;
  String? earnType;
  String? machine;
  String? amount;
  String? datetime;

  PaymentHistory(
      {this.type, this.earnType, this.machine, this.amount, this.datetime});

  PaymentHistory.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    earnType = json['earn_type'];
    machine = json['machine'];
    amount = json['amount'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['earn_type'] = this.earnType;
    data['machine'] = this.machine;
    data['amount'] = this.amount;
    data['datetime'] = this.datetime;
    return data;
  }
}