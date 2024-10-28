import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:orient/models/stores/create_edit_store_model.dart';
import '../../../models/stores/map_place_model.dart';
import '../services/stores.service.dart';
import 'package:latlong2/latlong.dart' as latLng;

class StoreCreateEditModel extends ChangeNotifier {
  CreateEditStoreModel createEditStoreModel = CreateEditStoreModel();
  List<MapPlaceModel> mapPlaces = List.empty(growable: true);
  MapPlaceModel locationData = MapPlaceModel();

  latLng.LatLng finalLatLng = const latLng.LatLng(0, 0);
  bool isLoading = true;
  void updateLoadingStatus({required bool laodingValue}) {
    isLoading = laodingValue;
    notifyListeners();
  }

  Future<void> addStore(
    BuildContext context,
  ) async {
    updateLoadingStatus(laodingValue: true);
    await _addStore(context);
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> updateStore(
    BuildContext context,
  ) async {
    updateLoadingStatus(laodingValue: true);
    await _updateStore(context);
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> getPlaceByName(BuildContext context, String placeName) async {
    try {
      final encodedQuery = Uri.encodeComponent(placeName);
      final url =
          'https://nominatim.openstreetmap.org/search?q=$encodedQuery&format=json&limit=5';

      final result = await StoresService.getPlace(context: context, url: url);
      mapPlaces = mapPlaces.isNotEmpty ? List.empty(growable: true) : mapPlaces;
      if (result.success && result.data != null) {
        (result.data ?? []).forEach((v) {
          mapPlaces.add(MapPlaceModel.fromJson(v));
        });
      }
      finalLatLng = latLng.LatLng(
          double.parse(mapPlaces.elementAt(0).lat ?? '0'),
          double.parse(mapPlaces.elementAt(0).lon ?? '0'));
      debugPrint(mapPlaces.length.toString());
    } catch (err, t) {
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
    }
  }

  Future<bool> getPlaceByLatAndLong(
      BuildContext context, double lat, double lon) async {
    try {
      String url =
          'https://nominatim.openstreetmap.org/reverse?lat=$lat&lon=$lon&format=json&addressdetails=1';

      final result = await StoresService.getPlace(context: context, url: url);
      // mapPlaces = mapPlaces.isNotEmpty ? List.empty(growable: true) : mapPlaces;

      if (result.success && result.data != null) {
        locationData = MapPlaceModel.fromJson(result.data);

        // String? locationCity = locationData.address?.city;
        // String? locationCountry = locationData.address?.country;

        // // Check if the location is in the desired city and country
        // if (locationCity != null && locationCountry != null) {
        //   if (locationCity.toLowerCase() == createStoreModel.sta &&
        //       locationCountry.toLowerCase() == country.toLowerCase()) {
        //     // return true;
        //   }
        // }
        log(result.data.toString());
        debugPrint(mapPlaces.length.toString());
        //  createStoreModel.locationType = locationData.addresstype;
        createEditStoreModel.locationType = "sale_point";
        createEditStoreModel.locationsAddress = NameModel(
          ar: locationData.displayName,
          en: locationData.displayName,
        );

        createEditStoreModel.googleMapUrl =
            'http://maps.google.com/maps?z=12&t=m&q=loc:$lat+$lon';

        return true;
      } else {
        return false;
      }
      // finalLatLng = latLng.LatLng(
      //     double.parse(mapPlaces.elementAt(0).lat ?? '0'),
      //     double.parse(mapPlaces.elementAt(0).lon ?? '0'));

      // createStoreModel.locationType =
      // Extract city and country from the address field
    } catch (err, t) {
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
      return false;
    }
  }

  Future<void> _addStore(BuildContext context) async {
    try {
      final result = await StoresService.addStore(
          context: context, data: createEditStoreModel.toJson());

      //TODO: add bottom sheet for success or fail
      if (result.success && result.data != null) {
        // (result.data?['products'] ?? []).forEach((v) {
        //   products.add(ProductModel.fromJson(v));
        // });
      }
    } catch (err, t) {
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
    }
  }

  Future<void> _updateStore(BuildContext context) async {
    try {
      final result = await StoresService.updateStore(
        context: context,
        data: createEditStoreModel.toJson(),
        id: createEditStoreModel.id!,
      );

      //TODO: add bottom sheet for success or fail

      if (result.success && result.data != null) {
        // (result.data?['products'] ?? []).forEach((v) {
        //   products.add(ProductModel.fromJson(v));
        // });
      }
    } catch (err, t) {
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
    }
  }
}
