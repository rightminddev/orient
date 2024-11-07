import 'package:orient/models/general/points_model.dart';

import '../info/country_key_model.dart';
import '../stores/location_type_model.dart';
import '../teams/pivot_model.dart';

class MemberModel {
  var id;
  var avatar;
  var name;
  var username;
  var email;
  var birthDay;
  var countryKey;
  var phone;
  var roles;
  var defaultLanguage;
  var status;
  var tags;
  var active;
  var emailVerifiedAt;
  var createdBy;
  var createdAt;
  var updatedAt;
  var deletedAt;
  var forgetPasswordCode;
  bool? tfa;
  var googleTfaSecret;
  var updatedBy;
  var lastLogin;
  var phoneVerifiedAt;
  var socialId;
  var googleTfaSecretVerifiedAt;
  var timezone;
  List<PointsModel>? points;
  PivotModel? pivot;

  MemberModel({
    this.id,
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
    this.tags,
    this.active,
    this.emailVerifiedAt,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.forgetPasswordCode,
    this.tfa,
    this.googleTfaSecret,
    this.updatedBy,
    this.lastLogin,
    this.phoneVerifiedAt,
    this.socialId,
    this.googleTfaSecretVerifiedAt,
    this.timezone,
    this.points,
  });

  MemberModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatar = json['avatar'];
    active = json['active'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    forgetPasswordCode = json['forget_password_code'];
    tfa = json['tfa'];
    emailVerifiedAt = json['email_verified_at'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    birthDay = json['birth_day'];
    countryKey = json['country_key'];
    phone = json['phone'];
    roles = json['roles'];
    defaultLanguage = json['default_language'];
    status = json['status'];
    tags = json['tags'];
    googleTfaSecret = json['google_tfa_secret'];
    updatedBy = json['updated_by'];
    lastLogin = json['last_login'];
    phoneVerifiedAt = json['phone_verified_at'];
    socialId = json['social_id'];
    googleTfaSecretVerifiedAt = json['google_tfa_secret_verified_at'];
    timezone = json['timezone'];
    pivot = json['pivot'] != null ? PivotModel.fromJson(json['pivot']) : null;
    if (json['points'] != null) {
      points = <PointsModel>[];
      json['points'].forEach((v) {
        points!.add(PointsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['avatar'] = avatar;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['birth_day'] = birthDay;
    data['country_key'] = countryKey;
    data['phone'] = phone;
    data['roles'] = roles;
    data['default_language'] = defaultLanguage;
    data['status'] = status;
    data['tags'] = tags;
    data['active'] = active;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['forget_password_code'] = forgetPasswordCode;
    data['tfa'] = tfa;
    data['google_tfa_secret'] = googleTfaSecret;
    data['updated_by'] = updatedBy;
    data['last_login'] = lastLogin;
    data['phone_verified_at'] = phoneVerifiedAt;
    data['social_id'] = socialId;
    data['google_tfa_secret_verified_at'] = googleTfaSecretVerifiedAt;
    data['timezone'] = timezone;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    if (points != null) {
      data['points'] = points!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
