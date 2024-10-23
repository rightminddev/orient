import '../info/city_model.dart';
import '../info/country_model.dart';
import 'create_edit_store_model.dart';
import 'location_type_model.dart';
import '../people/manager_model.dart';
import '../people/owner_model.dart';
import '../info/state_model.dart';

class StoreModel {
  int? id;
  String? name;
  int? countryKey;
  int? phoneNumber;
  CountryModel? country;
  int? countryId;
  StateModel? state;
  int? stateId;
  CityModel? city;
  int? cityId;
  String? lng;
  String? lat;
  String? locationsAddress;
  LocationTypeModel? locationType;
  OwnerModel? owner;
  int? ownerId;
  List<ManagersModel>? managers;
  String? googleMapUrl;
  NameModel? names;
  NameModel? locationsAddresses;

  StoreModel({
    this.id,
    this.name,
    this.countryKey,
    this.phoneNumber,
    this.country,
    this.countryId,
    this.state,
    this.stateId,
    this.city,
    this.cityId,
    this.lng,
    this.lat,
    this.locationsAddress,
    this.locationType,
    this.owner,
    this.ownerId,
    this.managers,
    this.googleMapUrl,
    this.names,
    this.locationsAddresses,
  });

  StoreModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryKey = json['country_key'];
    phoneNumber = json['phone_number'];

    country =
        json['country'] != null ? CountryModel.fromJson(json['country']) : null;
    countryId = json['country_id'];
    state = json['state'] != null ? StateModel.fromJson(json['state']) : null;
    stateId = json['state_id'];
    city = json['city'] != null ? CityModel.fromJson(json['city']) : null;
    cityId = json['city_id'];
    lng = json['lng'];
    lat = json['lat'];
    locationsAddress = json['locations_address'];
    locationType = json['location_type'] != null
        ? LocationTypeModel.fromJson(json['location_type'])
        : null;
    owner = json['owner'] != null ? OwnerModel.fromJson(json['owner']) : null;
    names = json['names'] != null ? NameModel.fromJson(json['names']) : null;
    locationsAddresses = json['locations_addresses'] != null
        ? NameModel.fromJson(json['locations_addresses'])
        : null;
    ownerId = json['owner_id'];
    if (json['managers'] != null) {
      managers = <ManagersModel>[];
      json['managers'].forEach((v) {
        managers!.add(ManagersModel.fromJson(v));
      });
    }
    googleMapUrl = json['google_map_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['country_key'] = countryKey;
    data['phone_number'] = phoneNumber;
    if (country != null) {
      data['country'] = country!.toJson();
    }
    data['country_id'] = countryId;
    if (state != null) {
      data['state'] = state!.toJson();
    }
    data['state_id'] = stateId;
    if (city != null) {
      data['city'] = city!.toJson();
    }
    data['lng'] = lng;
    data['lat'] = lat;
    data['locations_address'] = locationsAddress;
    if (locationType != null) {
      data['location_type'] = locationType!.toJson();
    }
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    if (names != null) {
      data['names'] = names!.toJson();
    }
    if (locationsAddresses != null) {
      data['locations_addresses'] = locationsAddresses!.toJson();
    }
    data['owner_id'] = ownerId;
    if (managers != null) {
      data['managers'] = managers!.map((v) => v.toJson()).toList();
    }
    data['google_map_url'] = googleMapUrl;
    return data;
  }
}
