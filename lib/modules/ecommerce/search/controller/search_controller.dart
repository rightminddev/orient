import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
class SearchConstant{
static  TextEditingController minPriceController = TextEditingController();
 static TextEditingController maxPriceController = TextEditingController();
 static var selectId;
 static var selectSizeId;
 static var selectSizeAttributesId;
 static var selectColorId;
 static var selectColorAttributesId;
}
class SearchControllerProvider extends ChangeNotifier {
  bool isLoadingSearch = false;
  String? errorMessageSearch;
  List searchProduct = [];
  List searchProductsCategories = [];
  List searchProductsAttributesColor= [];
  List searchProductsAttributesSize= [];
  List ids = [];
  int? selectColorIndex;
  int pageNumber = 1;
  int count = 0;
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
    if (length < count) {
      pageNumber = pageNumber + 1;
      return true;
    } else {
      return false;
    }
  }
  Future<void> getSearch({required BuildContext context, int? id, bool crossSells = false,
    category_id, price_from, price_to, bool addAll = false, colorId, sizeId,attributesColorId,attributesSizeId
  }) async {
    isLoadingSearch = true;
    errorMessageSearch = null;
    notifyListeners();
    try {
      var value = await DioHelper.getData(
        url: "/rm_ecommarce/v1/products/search",
        context: context,
        query: {
          "page": pageNumber,
          if(crossSells == true)  "with": "crossSells",
          if(colorId != null && attributesColorId != null)"attributes[$attributesColorId]" : colorId,
          if(sizeId != null && attributesSizeId != null)"attributes[$attributesSizeId}]" : sizeId,
          if(SearchConstant.selectId != null)"category_id" : SearchConstant.selectId,
          if(category_id != null && category_id != '')"category_id" : category_id,
          if(SearchConstant.minPriceController.text.isNotEmpty)"price_from" : SearchConstant.minPriceController.text,
          if(SearchConstant.maxPriceController.text.isNotEmpty)"price_to" : SearchConstant.maxPriceController.text
        },
      );
      notifyListeners();
      print("API Response: ${value.data}");
      isLoadingSearch = false;
      SearchConstant.selectId = null;
      SearchConstant.minPriceController.clear();
      SearchConstant.maxPriceController.clear();
      searchProduct = searchProduct.isNotEmpty ? pageNumber > 1 ? searchProduct : List.empty(growable: true): List.empty(growable: true);
      searchProduct = value.data['products'] ?? [];
      searchProductsCategories = value.data['categories'];
      value.data['attributes'].forEach((e){
        if(e['slug'] == "color"){
          searchProductsAttributesColor = e['options'];
          SearchConstant.selectColorAttributesId = e['id'];
        }
      });
      value.data['attributes'].forEach((e){
        if(e['slug'] == "wight"){
          searchProductsAttributesSize = e['options'];
          SearchConstant.selectSizeAttributesId = e['id'];
        }
      });
      value.data['categories'].forEach((e){
        ids.add(e['id']);
      });
      if(addAll == true){
        searchProductsCategories.add({
          "id": ids,
          "title": AppStrings.all.tr().toUpperCase(),
          "status": "publish",
          "parent_id": null
        },);
        final allCategoryIndex = searchProductsCategories.indexWhere((item) => item['title'] == AppStrings.all.tr().toUpperCase());
        if (allCategoryIndex != -1) {
          final allCategory = searchProductsCategories.removeAt(allCategoryIndex);
          searchProductsCategories.insert(0, allCategory);
        }
        addAll == false;
      }
      print("Search products: $searchProduct");
      } catch (e) {
      isLoadingSearch = false;
      errorMessageSearch = e.toString();
      notifyListeners();
    }
  }
  bool isLoadingCategory = false;
  String? errorMessageCategory;
  List categories = [];
}
