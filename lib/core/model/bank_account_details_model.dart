class BankAccountDetailsModel {
  String? accountHolderName;
  String? accountHolderType;
  String? bankName;
  String? accountNumber;
  String? routingNumber;
  String? accountOnboarding;
  Null? onboardingLink;

  BankAccountDetailsModel(
      {this.accountHolderName,
      this.accountHolderType,
      this.bankName,
      this.accountNumber,
      this.routingNumber,
      this.accountOnboarding,
      this.onboardingLink});

  BankAccountDetailsModel.fromJson(Map<String, dynamic> json) {
    accountHolderName = json['account_holder_name'];
    accountHolderType = json['account_holder_type'];
    bankName = json['bank_name'];
    accountNumber = json['account_number'];
    routingNumber = json['routing_number'];
    accountOnboarding = json['account_onboarding'];
    onboardingLink = json['onboarding_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_holder_name'] = this.accountHolderName;
    data['account_holder_type'] = this.accountHolderType;
    data['bank_name'] = this.bankName;
    data['account_number'] = this.accountNumber;
    data['routing_number'] = this.routingNumber;
    data['account_onboarding'] = this.accountOnboarding;
    data['onboarding_link'] = this.onboardingLink;
    return data;
  }
}
