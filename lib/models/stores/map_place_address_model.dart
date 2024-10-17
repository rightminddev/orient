class MapPlaceAddressModel {
  String? road;
  String? suburb;
  String? county;
  String? state;
  String? countryISOCode;
  String? city;
  String? postcode;
  String? country;
  String? countryCode;
  MapPlaceAddressModel({
    this.road,
    this.suburb,
    this.county,
    this.state,
    this.countryISOCode,
    this.city,
    this.postcode,
    this.country,
    this.countryCode,
  });

  MapPlaceAddressModel.fromJson(Map<String, dynamic> json) {
    road = json['road'];
    suburb = json['suburb'];
    county = json['county'];
    state = json['state'];
    countryISOCode = json['ISO3166-2-lvl4'];
    city = json['city'];
    postcode = json['postcode'];
    country = json['country'];
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['road'] = road;
    data['suburb'] = suburb;
    data['county'] = county;
    data['city'] = city;
    data['state'] = state;
    data['ISO3166-2-lvl4'] = countryISOCode;
    data['postcode'] = postcode;
    data['country'] = country;
    data['country_code'] = countryCode;
    return data;
  }
}
