class UserAddressModel {
  UserAddress? userAddress;

  UserAddressModel({this.userAddress});

  UserAddressModel.fromJson(Map<String, dynamic> json) {
    userAddress = json['user_address'] != null
        ? new UserAddress.fromJson(json['user_address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userAddress != null) {
      data['user_address'] = this.userAddress!.toJson();
    }
    return data;
  }
}

class UserAddress {
  int? id;
  String? address;
  int? countryKey;
  int? phone;
  int? countryId;
  int? stateId;
  int? cityId;
  int? userId;
  int? createdBy;
  Null? updatedBy;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  UserAddress(
      {this.id,
        this.address,
        this.countryKey,
        this.phone,
        this.countryId,
        this.stateId,
        this.cityId,
        this.userId,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  UserAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    countryKey = json['country_key'];
    phone = json['phone'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    userId = json['user_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    data['country_key'] = this.countryKey;
    data['phone'] = this.phone;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['user_id'] = this.userId;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
