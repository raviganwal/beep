class ProfileModel {
  int? code;
  AccountInfo? accountInfo;
  String? totalEarnings;
  BankAccount? bankAccount;
  int? teamMembers;

  ProfileModel(
      {this.code,
        this.accountInfo,
        this.totalEarnings,
        this.bankAccount,
        this.teamMembers});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    accountInfo = json['account_info'] != null
        ? AccountInfo.fromJson(json['account_info'])
        : null;
    totalEarnings = json['total_earnings'];
    bankAccount = json['bank_account'] != null
        ? BankAccount.fromJson(json['bank_account'])
        : null;
    teamMembers = json['team_members'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    if (accountInfo != null) {
      data['account_info'] = accountInfo!.toJson();
    }
    data['total_earnings'] = totalEarnings;
    if (bankAccount != null) {
      data['bank_account'] = bankAccount!.toJson();
    }
    data['team_members'] = teamMembers;
    return data;
  }
}

class AccountInfo {
  String? userRole;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? referralCode;

  AccountInfo(
      {this.userRole,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.referralCode});

  AccountInfo.fromJson(Map<String, dynamic> json) {
    userRole = json['user_role'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    referralCode = json['referral_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_role'] = userRole;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['referral_code'] = referralCode;
    return data;
  }
}

class BankAccount {
  String? bankName;
  String? accountNumber;
  String? accountTitle;

  BankAccount({this.bankName, this.accountNumber, this.accountTitle});

  BankAccount.fromJson(Map<String, dynamic> json) {
    bankName = json['bank_name'];
    accountNumber = json['account_number'];
    accountTitle = json['account_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bank_name'] = bankName;
    data['account_number'] = accountNumber;
    data['account_title'] = accountTitle;
    return data;
  }
}