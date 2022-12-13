class MachineTeamModel {
  int? code;
  List<TeamMembers>? teamMembers;

  MachineTeamModel({this.code, this.teamMembers});

  MachineTeamModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['team_members'] != null) {
      teamMembers = <TeamMembers>[];
      json['team_members'].forEach((v) {
        teamMembers!.add(TeamMembers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    if (teamMembers != null) {
      data['team_members'] = teamMembers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeamMembers {
  String? userRole;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? machineName;

  TeamMembers(
      {this.userRole,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.machineName});

  TeamMembers.fromJson(Map<String, dynamic> json) {
    userRole = json['user_role'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    machineName = json['machine_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_role'] = userRole;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['machine_name'] = machineName;
    return data;
  }
}