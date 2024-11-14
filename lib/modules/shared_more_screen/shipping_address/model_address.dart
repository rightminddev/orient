class AddressModel {
  bool? status;
  String? message;
  String? create;
  int? count;
  List<Data>? data;

  AddressModel(
      {this.status, this.message, this.create, this.count, this.data});

  AddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    create = json['create'];
    count = json['count'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['create'] = this.create;
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? address;
  int? countryKey;
  int? phone;
  String? country;
  int? countryId;
  String? state;
  int? stateId;
  String? city;
  int? cityId;
  String? user;
  int? userId;

  Data(
      {this.id,
        this.address,
        this.countryKey,
        this.phone,
        this.country,
        this.countryId,
        this.state,
        this.stateId,
        this.city,
        this.cityId,
        this.user,
        this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    countryKey = json['country_key'];
    phone = json['phone'];
    country = json['country'];
    countryId = json['country_id'];
    state = json['state'];
    stateId = json['state_id'];
    city = json['city'];
    cityId = json['city_id'];
    user = json['user'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    data['country_key'] = this.countryKey;
    data['phone'] = this.phone;
    data['country'] = this.country;
    data['country_id'] = this.countryId;
    data['state'] = this.state;
    data['state_id'] = this.stateId;
    data['city'] = this.city;
    data['city_id'] = this.cityId;
    data['user'] = this.user;
    data['user_id'] = this.userId;
    return data;
  }
}
