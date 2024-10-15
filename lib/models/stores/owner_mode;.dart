import 'country_key_model.dart';
import 'location_type_model.dart';

class OwnerModel {
  int? id;
  String? avatar;
  String? name;
  String? username;
  String? email;
  String? birthDay;
  CountryKeyModel? countryKey;
  String? phone;
  String? roles;
  LocationTypeModel? defaultLanguage;
  LocationTypeModel? status;
  String? tags;

  OwnerModel(
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

  OwnerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatar = json['avatar'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    birthDay = json['birth_day'];
    countryKey = json['country_key'] != null
        ? CountryKeyModel.fromJson(json['country_key'])
        : null;
    phone = json['phone'];
    roles = json['roles'];
    defaultLanguage = json['default_language'] != null
        ? LocationTypeModel.fromJson(json['default_language'])
        : null;
    status = json['status'] != null
        ? LocationTypeModel.fromJson(json['status'])
        : null;
    tags = json['tags'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['avatar'] = avatar;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['birth_day'] = birthDay;
    if (countryKey != null) {
      data['country_key'] = countryKey!.toJson();
    }
    data['phone'] = phone;
    data['roles'] = roles;
    if (defaultLanguage != null) {
      data['default_language'] = defaultLanguage!.toJson();
    }
    if (status != null) {
      data['status'] = status!.toJson();
    }
    data['tags'] = tags;
    return data;
  }
}
