import 'package:flutter/material.dart';
import 'package:orient/models/stores/store_model.dart';
import '../services/stores.service.dart';

class StoresViewModel extends ChangeNotifier {
  List<StoreModel> myStores = List.empty(growable: true);
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
}
