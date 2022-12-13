class MyTeamModel {
  int? code;
  List<TeamMembers>? teamMembers;

  MyTeamModel({this.code, this.teamMembers});

  MyTeamModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['team_members'] != null) {
      teamMembers = <TeamMembers>[];
      json['team_members'].forEach((v) {
        teamMembers!.add(new TeamMembers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = code;
    if (teamMembers != null) {
      data['team_members'] = teamMembers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeamMembers {
  String? id;
  String? userRole;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? machineName;

  TeamMembers(
      {this.id,
        this.userRole,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.machineName});

  TeamMembers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userRole = json['user_role'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    machineName = json['machine_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_role'] = userRole;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['machine_name'] = machineName;
    return data;
  }
}