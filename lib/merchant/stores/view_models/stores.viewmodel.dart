import 'package:flutter/material.dart';
import 'package:orient/models/products/product_model.dart';
import 'package:orient/models/stores/store_model.dart';
import '../services/stores.service.dart';

class StoresViewModel extends ChangeNotifier {
  List<StoreModel> myStores = List.empty(growable: true);
  List<ProductModel> products = List.empty(growable: true);
  String? search;
  int pageNumber = 1;
  int count = 0;
  bool isLoading = false;
  bool hasMoreData(int length) {
    if (pageNumber < count) {
      pageNumber = pageNumber + 1;
      return true;
    } else {
      return false;
    }
  }

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

  Future<void> _getMyStores(BuildContext context) async {
    try {
      final result = await StoresService.getMyStores(
        context: context,
        queryParameters: {"page": pageNumber},
      );

      myStores = myStores.isNotEmpty
          ? pageNumber > 1
              ? myStores
              : List.empty(growable: true)
          : List.empty(growable: true);
      if (result.success && result.data != null) {
        //   count = result.data?['count'];

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
      final result = await StoresService.getAvailableProducts(
        context: context,
        id: id,
        search: search,
        queryParameters: {"page": pageNumber},
      );
      products = products.isNotEmpty
          ? pageNumber > 1
              ? products
              : List.empty(growable: true)
          : List.empty(growable: true);

      if (result.success && result.data != null) {
        count = result.data?['count'];
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
}
