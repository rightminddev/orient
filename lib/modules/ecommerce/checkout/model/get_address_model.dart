class UserAddressModel {
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
  User? user;
  int? userId;

  UserAddressModel(
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

  UserAddressModel.fromJson(Map<String, dynamic> json) {
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
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
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
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['user_id'] = this.userId;
    return data;
  }
}

class User {
  int? id;
  Null? avatar;
  String? name;
  Null? username;
  String? email;
  Null? birthDay;
  CountryKey? countryKey;
  String? phone;
  String? roles;
  DefaultLanguage? defaultLanguage;
  DefaultLanguage? status;
  String? tags;

  User(
      {this.id,
        this.avatar,
        this.name,
        this.username,
        this.email,
        this.birthDay,
        this.countryKey,
        this.phone,
        this.roles,
        this.defaultLanguage,
        this.status,
        this.tags});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatar = json['avatar'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    birthDay = json['birth_day'];
    countryKey = json['country_key'] != null
        ? new CountryKey.fromJson(json['country_key'])
        : null;
    phone = json['phone'];
    roles = json['roles'];
    defaultLanguage = json['default_language'] != null
        ? new DefaultLanguage.fromJson(json['default_language'])
        : null;
    status = json['status'] != null
        ? new DefaultLanguage.fromJson(json['status'])
        : null;
    tags = json['tags'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['avatar'] = this.avatar;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['birth_day'] = this.birthDay;
    if (this.countryKey != null) {
      data['country_key'] = this.countryKey!.toJson();
    }
    data['phone'] = this.phone;
    data['roles'] = this.roles;
    if (this.defaultLanguage != null) {
      data['default_language'] = this.defaultLanguage!.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    data['tags'] = this.tags;
    return data;
  }
}

class CountryKey {
  int? key;
  String? value;

  CountryKey({this.key, this.value});

  CountryKey.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}

class DefaultLanguage {
  String? key;
  String? value;

  DefaultLanguage({this.key, this.value});

  DefaultLanguage.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}
