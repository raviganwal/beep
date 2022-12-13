class MachineStatsModel {
  int? code;
  List<DailyStats>? dailyStats;
  List<MonthlyStats>? monthlyStats;

  MachineStatsModel({this.code, this.dailyStats, this.monthlyStats});

  MachineStatsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['daily_stats'] != null) {
      dailyStats = <DailyStats>[];
      json['daily_stats'].forEach((v) {
        dailyStats!.add(DailyStats.fromJson(v));
      });
    }
    if (json['monthly_stats'] != null) {
      monthlyStats = <MonthlyStats>[];
      json['monthly_stats'].forEach((v) {
        monthlyStats!.add(MonthlyStats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    if (dailyStats != null) {
      data['daily_stats'] = dailyStats!.map((v) => v.toJson()).toList();
    }
    if (monthlyStats != null) {
      data['monthly_stats'] =
          monthlyStats!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DailyStats {
  String? washes;
  int? minutes;
  String? rating;
  String? revenue;
  String? statDate;

  DailyStats(
      {this.washes, this.minutes, this.rating, this.revenue, this.statDate});

  DailyStats.fromJson(Map<String, dynamic> json) {
    washes = json['washes'];
    minutes = json['minutes'];
    rating = json['rating'];
    revenue = json['revenue'];
    statDate = json['stat_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['washes'] = washes;
    data['minutes'] = minutes;
    data['rating'] = rating;
    data['revenue'] = revenue;
    data['stat_date'] = statDate;
    return data;
  }
}

class MonthlyStats {
  String? washes;
  int? minutes;
  String? rating;
  String? revenue;
  String? statMonth;
  String? statYear;

  MonthlyStats(
      {this.washes,
        this.minutes,
        this.rating,
        this.revenue,
        this.statMonth,
        this.statYear});

  MonthlyStats.fromJson(Map<String, dynamic> json) {
    washes = json['washes'];
    minutes = json['minutes'];
    rating = json['rating'];
    revenue = json['revenue'];
    statMonth = json['stat_month'];
    statYear = json['stat_year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['washes'] = washes;
    data['minutes'] = minutes;
    data['rating'] = rating;
    data['revenue'] = revenue;
    data['stat_month'] = statMonth;
    data['stat_year'] = statYear;
    return data;
  }
}