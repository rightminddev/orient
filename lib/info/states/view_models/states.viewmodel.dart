import 'package:flutter/material.dart';
import '../../../models/stores/state_model.dart';
import '../../../services/crud_operation.service.dart';

class StatesViewModel extends ChangeNotifier {
  List<StateModel> states = List.empty(growable: true);
  bool isLoading = true;
  void updateLoadingStatus({required bool laodingValue}) {
    isLoading = laodingValue;
    notifyListeners();
  }

  Future<void> initializeStates(
      BuildContext context, String countryCode) async {
    updateLoadingStatus(laodingValue: true);
    await _getStates(context, countryCode);
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> _getStates(BuildContext context, String countryCode) async {
    try {
      final result = await CrudOperationService.readEntities(
        context: context,
        slug: 'states',
        queryParams: {
          "itemsCount": 200,
          "country_code": countryCode
          //'page': 1,
          // 'with': 'cate',
          // 'trash': 1,
          // 'scope': 'filter',
        },
      );
      states = states.isNotEmpty ? List.empty(growable: true) : states;
      if (result.success && result.data != null) {
        (result.data?['data'] ?? []).forEach((v) {
          states.add(StateModel.fromJson(v));
        });
      }
      debugPrint(states.length.toString());
    } catch (err, t) {
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
    }
  }
}
