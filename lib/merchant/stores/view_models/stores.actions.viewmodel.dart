import 'package:flutter/material.dart';
import 'package:orient/models/availability/availability_model.dart';
import '../services/stores.service.dart';

class StoreActionsViewModel extends ChangeNotifier {
  AvailabilityModel addedToStock =
      AvailabilityModel(products: List.empty(growable: true));
  bool isLoading = true;
  void updateLoadingStatus({required bool laodingValue}) {
    isLoading = laodingValue;
    notifyListeners();
  }

  Future<void> updateAvailableProducts(BuildContext context, int id) async {
    updateLoadingStatus(laodingValue: true);
    await _updateAvailableProducts(context, id);
    updateLoadingStatus(laodingValue: false);
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
      //   debugPrint(products.length.toString());
    } catch (err, t) {
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
    }
  }
}
