class StateModel {
  int? id;
  String? title;
  String? country;
  int? countryId;
  int? status;
  String? iso2;

  StateModel(
      {this.id,
      this.title,
      this.country,
      this.countryId,
      this.status,
      this.iso2});

  StateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    country = json['country'];
    countryId = json['country_id'];
    status = json['status'];
    iso2 = json['iso2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['country'] = country;
    data['country_id'] = countryId;
    data['status'] = status;
    data['iso2'] = iso2;
    return data;
  }
}
