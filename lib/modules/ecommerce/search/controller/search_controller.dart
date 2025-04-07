import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/alert_service/alerts.service.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
import 'package:orient/modules/ecommerce/home/controller/const.dart';
import 'package:orient/modules/ecommerce/search/consts.dart';
class SearchConstant{

 static var selectId;
 static var selectSizeId;
 static var selectSizeAttributesId;
 static var selectColorId;
 static var selectColorAttributesId;
 static bool? filter = false;
}
class SearchControllerProvider extends ChangeNotifier {
  bool isLoadingSearch = false;
  bool isSuccessSearch = false;
  String? errorMessageSearch;
  List searchProduct = [];

  List searchProductsCategories = [];
  List searchProductsAttributesColor= [];
  List searchProductsAttributesSize= [];
  List ids = [];
  int? selectColorIndex;
  int? selectCatIndex;
  int? selectSizeIndex;
  bool hasMore = true;
  final ScrollController controller = ScrollController();
  final int expectedPageSize = 9;
  int pageNumber = 1;
  int count = 0;
  ScrollController get scrollController => controller;
  List idsCheck = [];
  void changeColorIndex(index){
    selectColorIndex = index;
    notifyListeners();
  }
  bool isLoading = false;
  void updateLoadingStatus({required bool laodingValue}) {
    isLoading = laodingValue;
    notifyListeners();
  }
  Future<void> initializeMyStoresScreen(BuildContext context) async {
    updateLoadingStatus(laodingValue: true);
    await getSearch(context: context);
    updateLoadingStatus(laodingValue: false);
  }
  bool hasMoreData(int length) {
    if (length < expectedPageSize) {
      return false;
    } else {
      pageNumber += 1;
      return true;
    }
  }
  List productss = [];
  Set<int> productIds = {}; // Track unique product IDs

  Future<void> getSearch({
    required BuildContext context,
    int? id,
    bool crossSells = false,
    category_id,
    price_from,
    price_to,
    pages,
    bool addAll = false,
    bool? isNewPage,
    colorId,
    sizeId,
    attributesColorId,
    attributesSizeId,
  }) async {
    print(isNewPage);
    isLoadingSearch = true;
    errorMessageSearch = null;
    notifyListeners();

    try {
      var value = await DioHelper.getData(
        url: "/rm_ecommarce/v1/products/search",
        context: context,
        query: {
          "page": pages ?? pageNumber,
          if (attributesColorId != null) "attributes[$attributesColorId]": colorId != -1 ? colorId : null,
          if (attributesSizeId != null) "attributes[$attributesSizeId]": sizeId != -1 ? sizeId : null,
          if (SearchConstant.selectId != null && SearchConstant.selectId != '-1' && SearchConstant.selectId != -1)
            "category_id": SearchConstant.selectId,
          if (category_id != '-1' && category_id != -1) "category_id": category_id,
          "price_from": (SearchConsts.minPriceController.text.isNotEmpty) ? SearchConsts.minPriceController.text : null,
          "price_to": (SearchConsts.maxPriceController.text.isNotEmpty) ? SearchConsts.maxPriceController.text : null,
        },
      );

      print("API Response: ${value.data}");
      isSuccessSearch = true;
      isLoadingSearch = false;
      productss = value.data['products'];

      if (value.data['products'] != null && value.data['products'].isNotEmpty) {
        List newProducts = value.data['products'];

        // Remove duplicates based on ID
        List uniqueProducts = newProducts.where((p) => !productIds.contains(p['id'])).toList();

        if (isNewPage == true) {
          searchProduct.addAll(uniqueProducts);
        } else {
          searchProduct = uniqueProducts;
          print("PRODUCTS SUCCESS");
        }

        // Update product ID tracker
        productIds.addAll(uniqueProducts.map((p) => p['id']));

        if (hasMore) pageNumber++;
      }

      print("111");
      SearchConstant.selectId = null;
      SearchConsts.minPriceController.clear();
      SearchConsts.maxPriceController.clear();
      searchProductsCategories = value.data['categories'];
      HomeConst.Ids = [];

      if (searchProduct.isNotEmpty) {
        for (var e in searchProduct) {
          idsCheck.add(e['id']);
          HomeConst.Ids = idsCheck;
          print("IDS CHECK SEARCH products---> $idsCheck");
        }
      }

      // Process attributes
      value.data['attributes'].forEach((e) {
        if (e['slug'] == "color") {
          searchProductsAttributesColor = e['options'];
          searchProductsAttributesColor.insert(0, {"id": null, "title": 0, "data": "123456"});
          SearchConstant.selectColorAttributesId = e['id'];
        }
      });

      value.data['attributes'].forEach((e) {
        if (e['slug'] == "wight") {
          searchProductsAttributesSize = e['options'];
          SearchConstant.selectSizeAttributesId = e['id'];
          searchProductsAttributesSize.insert(0, {"id": null, "title": AppStrings.all.tr(), "data": "123456"});
        }
      });

      value.data['categories'].forEach((e) {
        ids.add(e['id']);
      });

      if (addAll == true) {
        searchProductsCategories.add({
          "id": null,
          "title": AppStrings.all.tr().toUpperCase(),
          "status": "publish",
          "parent_id": null,
        });

        final allCategoryIndex = searchProductsCategories.indexWhere(
                (item) => item['title'] == AppStrings.all.tr().toUpperCase());

        if (allCategoryIndex != -1) {
          final allCategory = searchProductsCategories.removeAt(allCategoryIndex);
          searchProductsCategories.insert(0, allCategory);
        }
      }

      print("Search products: $searchProduct");
      notifyListeners();
    } catch (e) {
      isLoadingSearch = false;
      errorMessageSearch = e.toString();
      isSuccessSearch = false;
      print("FINAL");
      notifyListeners();
    }
  }

  bool isLoadingCategory = false;
  String? errorMessageCategory;
  List categories = [];
}
