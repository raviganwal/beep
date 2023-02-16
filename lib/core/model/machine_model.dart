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
  String? err;
  String? publicAccess;
  String? maintenanceMode;
  String? foamTank;
  String? waterTank;
  String? waterHeater;
  String? foamHeater;
  String? light;
  String? voice;
  String? qrCode;
  String? machineName;
  String? address;
  String? cityId;
  String? state;
  String? country;
  String? postalCode;
  String? machineLat;
  String? machineLong;
  String? rating;
  String? issues;

  Machine(
      {this.id,
        this.err,
        this.publicAccess,
        this.maintenanceMode,
        this.foamTank,
        this.waterTank,
        this.waterHeater,
        this.foamHeater,
        this.light,
        this.voice,
        this.qrCode,
        this.machineName,
        this.address,
        this.cityId,
        this.state,
        this.country,
        this.postalCode,
        this.machineLat,
        this.machineLong,
        this.rating,
        this.issues});

  Machine.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    err = json['err'];
    publicAccess = json['public_access'];
    maintenanceMode = json['maintenance_mode'];
    foamTank = json['foam_tank'];
    waterTank = json['water_tank'];
    waterHeater = json['water_heater'];
    foamHeater = json['foam_heater'];
    light = json['light'];
    voice = json['voice'];
    qrCode = json['qr_code'];
    machineName = json['machine_name'];
    address = json['address'];
    cityId = json['city_id'];
    state = json['state'];
    country = json['country'];
    postalCode = json['postal_code'];
    machineLat = json['machine_lat'];
    machineLong = json['machine_long'];
    rating = json['rating'];
    issues = json['issues'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['err'] = this.err;
    data['public_access'] = this.publicAccess;
    data['maintenance_mode'] = this.maintenanceMode;
    data['foam_tank'] = this.foamTank;
    data['water_tank'] = this.waterTank;
    data['water_heater'] = this.waterHeater;
    data['foam_heater'] = this.foamHeater;
    data['light'] = this.light;
    data['voice'] = this.voice;
    data['qr_code'] = this.qrCode;
    data['machine_name'] = this.machineName;
    data['address'] = this.address;
    data['city_id'] = this.cityId;
    data['state'] = this.state;
    data['country'] = this.country;
    data['postal_code'] = this.postalCode;
    data['machine_lat'] = this.machineLat;
    data['machine_long'] = this.machineLong;
    data['rating'] = this.rating;
    data['issues'] = this.issues;
    return data;
  }


}