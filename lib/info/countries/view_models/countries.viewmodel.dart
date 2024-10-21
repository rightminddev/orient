import 'package:flutter/material.dart';
import 'package:orient/models/info/country_model.dart';
import '../../../services/crud_operation.service.dart';

class CountriesViewModel extends ChangeNotifier {
  List<CountryModel> countries = List.empty(growable: true);
  bool isLoading = true;
  void updateLoadingStatus({required bool laodingValue}) {
    isLoading = laodingValue;
    notifyListeners();
  }

  Future<void> initializeCountries(BuildContext context) async {
    updateLoadingStatus(laodingValue: true);
    await _getCountries(context);
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> _getCountries(BuildContext context) async {
    try {
      final result = await CrudOperationService.readEntities(
        context: context,
        slug: 'countries',
        queryParams: {
          "itemsCount": 100,
          //'page': 1,
          // 'with': 'cate',
          // 'trash': 1,
          // 'scope': 'filter',
        },
      );

      if (result.success && result.data != null) {
        (result.data?['data'] ?? []).forEach((v) {
          countries.add(CountryModel.fromJson(v));
        });
      }
      debugPrint(countries.length.toString());
    } catch (err, t) {
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
    }
  }
}
