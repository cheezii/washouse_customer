class CurrentUser {
  String? tokenId;
  int? accountId;
  String? email;
  String? phone;
  String? roleType;
  String? name;
  String? avatar;
  int? locationId;

  CurrentUser({this.tokenId, this.accountId, this.email, this.phone, this.roleType, this.name, this.avatar, this.locationId});

  CurrentUser.fromJson(Map<String, dynamic> json) {
    tokenId = json['tokenId'];
    accountId = json['accountId'];
    email = json['email'];
    phone = json['phone'];
    roleType = json['roleType'];
    name = json['name'];
    avatar = json['avatar'];
    locationId = json['locationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tokenId'] = this.tokenId;
    data['accountId'] = this.accountId;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['roleType'] = this.roleType;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['locationId'] = this.locationId;
    return data;
  }
}
