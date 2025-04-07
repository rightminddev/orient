class ShippingInfoModel {
  int? id;
  String? type;
  int? zoneId;
  String? zone;
  int? countryId;
  String? country;
  int? stateId;
  String? state;
  int? cityId;
  String? city;
  int? shippingCost;
  String? addressText;

  ShippingInfoModel(
      {this.id,
      this.type,
      this.zoneId,
      this.zone,
      this.countryId,
      this.country,
      this.stateId,
      this.state,
      this.cityId,
      this.city,
      this.shippingCost,
      this.addressText});

  ShippingInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    zoneId = json['zone_id'];
    zone = json['zone'];
    countryId = json['country_id'];
    country = json['country'];
    stateId = json['state_id'];
    state = json['state'];
    cityId = json['city_id'];
    city = json['city'];
    shippingCost = json['shipping_cost'];
    addressText = json['address_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['zone_id'] = zoneId;
    data['zone'] = zone;
    data['country_id'] = countryId;
    data['country'] = country;
    data['state_id'] = stateId;
    data['state'] = state;
    data['city_id'] = cityId;
    data['city'] = city;
    data['shipping_cost'] = shippingCost;
    data['address_text'] = addressText;
    return data;
  }
}
