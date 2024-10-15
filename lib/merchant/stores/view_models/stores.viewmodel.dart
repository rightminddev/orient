import 'package:flutter/material.dart';
import 'package:orient/models/availability/availability_model.dart';
import 'package:orient/models/products/product_model.dart';
import 'package:orient/models/stores/store_model.dart';
import '../services/stores.service.dart';

class StoresViewModel extends ChangeNotifier {
  List<StoreModel> myStores = List.empty(growable: true);
  List<ProductModel> products = List.empty(growable: true);
  AvailabilityModel addedToStock =
      AvailabilityModel(products: List.empty(growable: true));

  bool isLoading = true;
  void updateLoadingStatus({required bool laodingValue}) {
    isLoading = laodingValue;
    notifyListeners();
  }

  Future<void> initializeMyStoresScreen(BuildContext context) async {
    updateLoadingStatus(laodingValue: true);
    await _getMyStores(context);
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> initializeAvailableProductsScreen(
      BuildContext context, int id) async {
    updateLoadingStatus(laodingValue: true);
    await _getAvailableProducts(context, id);
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> updateAvailableProducts(BuildContext context, int id) async {
    updateLoadingStatus(laodingValue: true);
    await _updateAvailableProducts(context, id);
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> _getMyStores(BuildContext context) async {
    try {
      final result = await StoresService.getMyStores(context: context);

      if (result.success && result.data != null) {
        (result.data?['stores'] ?? []).forEach((v) {
          myStores.add(StoreModel.fromJson(v));
        });
      }
      debugPrint(myStores.length.toString());
    } catch (err, t) {
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
    }
  }

  Future<void> _getAvailableProducts(BuildContext context, int id) async {
    try {
      final result =
          await StoresService.getAvailableProducts(context: context, id: id);
      if (result.success && result.data != null) {
        (result.data?['products'] ?? []).forEach((v) {
          products.add(ProductModel.fromJson(v));
        });
      }
      debugPrint(products.length.toString());
    } catch (err, t) {
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
    }
  }

  Future<void> _updateAvailableProducts(BuildContext context, int id) async {
    try {
      final result = await StoresService.updateAvailableProducts(
          context: context, id: id, data: addedToStock.toJson());
      //TODO: add bottom sheet for success or fail
      if (result.success && result.data != null) {
        // (result.data?['products'] ?? []).forEach((v) {
        //   products.add(ProductModel.fromJson(v));
        // });
      }
      debugPrint(products.length.toString());
    } catch (err, t) {
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
    }
  }
}
