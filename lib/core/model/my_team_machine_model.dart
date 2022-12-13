class MyTeamMachineModel {
  int? code;
  List<Machines>? machines;

  MyTeamMachineModel({this.code, this.machines});

  MyTeamMachineModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['machines'] != null) {
      machines = <Machines>[];
      json['machines'].forEach((v) {
        machines!.add(new Machines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.machines != null) {
      data['machines'] = this.machines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Machines {
  String? id;
  String? machineName;

  Machines({this.id, this.machineName});

  Machines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    machineName = json['machine_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['machine_name'] = this.machineName;
    return data;
  }
}