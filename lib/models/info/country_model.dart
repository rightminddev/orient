class CountryModel {
  int? id;
  String? title;
  int? phoneCode;
  int? status;
  String? iso2;
  String? iso3;
  String? region;
  String? subregion;
  String? emoji;
  String? timezone;

  CountryModel(
      {this.id,
      this.title,
      this.phoneCode,
      this.status,
      this.iso2,
      this.iso3,
      this.region,
      this.subregion,
      this.emoji,
      this.timezone});

  CountryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    phoneCode = json['phone_code'];
    status = json['status'];
    iso2 = json['iso2'];
    iso3 = json['iso3'];
    region = json['region'];
    subregion = json['subregion'];
    emoji = json['emoji'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['phone_code'] = phoneCode;
    data['status'] = status;
    data['iso2'] = iso2;
    data['iso3'] = iso3;
    data['region'] = region;
    data['subregion'] = subregion;
    data['emoji'] = emoji;
    data['timezone'] = timezone;
    return data;
  }
}
