import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
import 'package:orient/modules/ecommerce/home/controller/const.dart';
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
  bool isSuccessSearch = false;
  String? errorMessageSearch;
  List searchProduct = [];

  List searchProductsCategories = [];
  List searchProductsAttributesColor= [];
  List searchProductsAttributesSize= [];
  List ids = [];
  int? selectColorIndex;
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
  Future<void> getSearch({required BuildContext context, int? id, bool crossSells = false,
    category_id, price_from, price_to,pages, bool addAll = false,bool? isNewPage, colorId, sizeId,attributesColorId,attributesSizeId
  }) async {
    isLoadingSearch = true;
    errorMessageSearch = null;
    notifyListeners();
    try {
      var value = await DioHelper.getData(
        url: "/rm_ecommarce/v1/products/search",
        context: context,
        query: {
          "page":pages ?? pageNumber,
          if(crossSells == true)  "with": "crossSells",
          if(colorId != null && attributesColorId != null)"attributes[$attributesColorId]" : colorId,
          if(sizeId != null && attributesSizeId != null)"attributes[$attributesSizeId}]" : sizeId,
          if(SearchConstant.selectId != null && SearchConstant.selectId != '-1'&& SearchConstant.selectId != -1)"category_id" : SearchConstant.selectId,
          if(category_id != null && category_id != '-1' && category_id != -1)"category_id" : category_id,
          if(SearchConstant.minPriceController.text.isNotEmpty)"price_from" : SearchConstant.minPriceController.text,
          if(SearchConstant.maxPriceController.text.isNotEmpty)"price_to" : SearchConstant.maxPriceController.text
        },
      );
      print("API Response: ${value.data}");
      isSuccessSearch = true;
      isLoadingSearch = false;
      if (value.data['products'] != null && value.data['products'].isNotEmpty) {
        if (isNewPage == true) {
          searchProduct.addAll(value.data['products'] );
        } else {
          searchProduct = value.data['products'];
          print("PRODUCTS SUCCESS");
        }
        if (hasMore) pageNumber++;
       // pageNumber++;
      }
      print("111");
      SearchConstant.selectId = null;
      print("222");
      SearchConstant.minPriceController.clear();
      print("333");
      SearchConstant.maxPriceController.clear();
      print("444");
      searchProductsCategories = value.data['categories'];
      print("555");
      HomeConst.Ids = [];
      print("666");
      if(searchProduct.isNotEmpty){
        for (var e in searchProduct) {
          idsCheck.add(e['id']);
          HomeConst.Ids = idsCheck;
          print("IDS CHECK SEARCH products---> $idsCheck");
        }
      }
      print("777");
      value.data['attributes'].forEach((e){
        if(e['slug'] == "color"){
          searchProductsAttributesColor = e['options'];
          print("888");
          SearchConstant.selectColorAttributesId = e['id'];
          print("searchProductsAttributesColor is ---> $searchProductsAttributesColor");
        }
      });
      print("999");
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
