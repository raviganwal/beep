class MachineModel {
  int? code;
  List<Machine>? data;

  MachineModel({this.code, this.data});

  MachineModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <Machine>[];
      json['data'].forEach((v) {
        data!.add(Machine.fromJson(v));
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

class Machine {
  String? id;
  String? machineName;
  String? address;
  String? isActive;
  String? foamTank;
  String? waterTank;
  String? waterHeater;
  String? foamHeater;
  String? light;
  String? voice;
  String? cityName;
  String? cityId;
  String? timezone;
  String? rating;
  String? issues;

  Machine(
      {this.id,
        this.machineName,
        this.address,
        this.isActive,
        this.foamTank,
        this.waterTank,
        this.waterHeater,
        this.foamHeater,
        this.light,
        this.voice,
        this.cityName,
        this.cityId,
        this.timezone,
        this.rating,
        this.issues});

  Machine.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    machineName = json['machine_name'];
    address = json['address'];
    isActive = json['is_active'];
    foamTank = json['foam_tank'];
    waterTank = json['water_tank'];
    waterHeater = json['water_heater'];
    foamHeater = json['foam_heater'];
    light = json['light'];
    voice = json['voice'];
    cityName = json['city_name'];
    cityId = json['city_id'];
    timezone = json['timezone'];
    rating = json['rating'];
    issues = json['issues'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['machine_name'] = this.machineName;
    data['address'] = this.address;
    data['is_active'] = this.isActive;
    data['foam_tank'] = this.foamTank;
    data['water_tank'] = this.waterTank;
    data['water_heater'] = this.waterHeater;
    data['foam_heater'] = this.foamHeater;
    data['light'] = this.light;
    data['voice'] = this.voice;
    data['city_name'] = this.cityName;
    data['city_id'] = this.cityId;
    data['timezone'] = this.timezone;
    data['rating'] = this.rating;
    data['issues'] = this.issues;
    return data;
  }
}