import 'package:flutter/material.dart';
import '../../../models/info/cities_model.dart';
import '../../../services/crud_operation.service.dart';

class CitiesViewModel extends ChangeNotifier {
  List<CitiesModel> cities = List.empty(growable: true);
  bool isLoading = true;
  void updateLoadingStatus({required bool laodingValue}) {
    isLoading = laodingValue;
    notifyListeners();
  }

  Future<void> initializeCities(BuildContext context, int stateId) async {
    updateLoadingStatus(laodingValue: true);
    await _getCities(context, stateId);
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> _getCities(BuildContext context, int stateId) async {
    try {
      final result = await CrudOperationService.readEntities(
        context: context,
        slug: 'info-cities',
        queryParams: {
          "itemsCount": 200,
          "state_id": stateId
          //'page': 1,
          // 'with': 'cate',
          // 'trash': 1,
          // 'scope': 'filter',
        },
      );
      cities = cities.isNotEmpty ? List.empty(growable: true) : cities;

      if (result.success && result.data != null) {
        (result.data?['data'] ?? []).forEach((v) {
          cities.add(CitiesModel.fromJson(v));
        });
      }

      debugPrint(cities.length.toString());
    } catch (err, t) {
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
    }
  }
}
