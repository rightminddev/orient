class CreateEditStoreModel {
  int? id;
  NameModel? name;
  int? countryKey;
  String? phoneNumber;
  String? countryId;
  String? stateId;
  List<String>? cities;
  String? lng;
  String? lat;
  NameModel? locationsAddress;
  String? locationType;
  String? googleMapUrl;

  CreateEditStoreModel({
    this.id,
    this.name,
    this.countryKey,
    this.phoneNumber,
    this.countryId,
    this.stateId,
    this.cities,
    this.lng,
    this.lat,
    this.locationsAddress,
    this.locationType,
    this.googleMapUrl,

    //  "location_type": "sale_point",
    // "google_map_url": "https://www.google.com/maps"
  });

  CreateEditStoreModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? NameModel.fromJson(json['name']) : null;
    countryKey = json['country_key'];
    phoneNumber = json['phone_number'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cities = json['cities'].cast<String>();
    lng = json['lng'];
    lat = json['lat'];
    locationsAddress = json['locations_address'] != null
        ? NameModel.fromJson(json['locations_address'])
        : null;
    locationType = json['location_type'];
    googleMapUrl = json['google_map_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['country_key'] = countryKey;
    data['phone_number'] = phoneNumber;
    data['country_id'] = countryId;
    data['state_id'] = stateId;
    data['cities'] = cities;
    data['lng'] = lng;
    data['lat'] = lat;
    if (locationsAddress != null) {
      data['locations_address'] = locationsAddress!.toJson();
    }
    data['location_type'] = locationType;
    data['google_map_url'] = googleMapUrl;
    return data;
  }
}

class NameModel {
  String? en;
  String? ar;

  NameModel({this.en, this.ar});

  NameModel.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ar = json['ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['en'] = en;
    data['ar'] = ar;
    return data;
  }
}
