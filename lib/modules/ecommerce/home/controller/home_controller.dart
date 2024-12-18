  import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';
  import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
import 'package:orient/modules/ecommerce/home/controller/const.dart';
import 'package:orient/modules/ecommerce/home/model/color_trend_model.dart';

  class HomeProvider extends ChangeNotifier {
    TextEditingController numberOfMetersController = TextEditingController();
    String? selectCategory;
    bool isLoading = false;
    bool isColorTrendLoading = false;
    bool isInspiredCategoryLoading = false;
    bool isInspiredLoading = false;
    bool isCheckLoading = false;
    bool isSuccess = false;
    bool isColorTrendSuccess = false;
    bool isInspiredCategorySuccess = false;
    bool isInspiredSuccess = false;
    bool isCheckSuccess = false;
    List productsCategories = [];
    List productsBlog = [];
    List products = [];
    List moreProducts = [];
    List premiumProductImage = [];
    List colorTrendGallery = [];
    List colorTrendProducts = [];
    List colorTrendBlog = [];
    List inspiredCategories = [];
    List inspireds = [];
    String colorTrendContant = '';
    String colorTrendCover = '';
    var coverImage;
    String? errorMessage;
    String? errorColorTrendMessage;
    String? errorInspiredCategoryMessage;
    String? errorInspiredMessage;
    String? errorCheckMessage;
    List ids = [];
    List idsCheck = [];
    Future<void> getPages({required BuildContext context, bool addAll = false, bool fromHome = true}) async {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
      try {
        var value = await DioHelper.getData(
          url: "/rm_page/v1/show",
          context: context,
          query: {
            "slug": "home-app",
          },
        );
        productsCategories = value.data['page']['products_categories'];
        value.data['page']['products_categories'].forEach((e){
          ids.add(e['id']);
        });
        if(addAll == true){
          productsCategories.add({
            "id": ids,
            "title": AppStrings.all.tr().toUpperCase(),
            "image": [
              {
                "id": 755,
                "type": "webp",
                "title": "orient-metal",
                "alt": "orient-metal",
                "file": "https://lab.r-m.dev/files/2024/orient-metal.webp",
                "thumbnail": "https://lab.r-m.dev/files/2024/orient-metal_thumbnail.webp",
                "sizes": {
                  "thumbnail": "https://lab.r-m.dev/files/2024/orient-metal_thumbnail.webp",
                  "medium": "https://lab.r-m.dev/files/2024/orient-metal_medium.webp",
                  "large": "https://lab.r-m.dev/files/2024/orient-metal_large.webp",
                  "1200_800": "https://lab.r-m.dev/files/2024/orient-metal_1200_800.webp",
                  "800_1200": "https://lab.r-m.dev/files/2024/orient-metal_800_1200.webp",
                  "1200_300": "https://lab.r-m.dev/files/2024/orient-metal_1200_300.webp",
                  "300_1200": "https://lab.r-m.dev/files/2024/orient-metal_300_1200.webp"
                }
              }
            ],
            "status": {
              "key": "publish",
              "value": "publish"
            }
          },);
          final allCategoryIndex = productsCategories.indexWhere((item) => item['title'] == AppStrings.all.tr().toUpperCase());
          if (allCategoryIndex != -1) {
            final allCategory = productsCategories.removeAt(allCategoryIndex);
            productsCategories.insert(0, allCategory);
          }
          addAll == false;
        }
        print("IDS ------> ${ids}");
        productsBlog = value.data['page']['blogs'];
        products = value.data['page']['products_list'];
        moreProducts = value.data['page']['more_products'];
        premiumProductImage = value.data['page']['premium_product_image'];
        coverImage = value.data['page']['cover_image'][0]['file'];
        isLoading = false;
        if(fromHome == true){
          HomeConst.Ids = [];
          if(products.isNotEmpty){
            for (var e in products) {
              idsCheck.add(e['id']);
              HomeConst.Ids = idsCheck;
              print("IDS CHECK products---> $idsCheck");
            }
          }
          if(moreProducts.isNotEmpty){
            print("Not1");
            for (var e in moreProducts) {
              if(e['products'].isNotEmpty){
                for (var v in e['products']) {
                  idsCheck!.add(v['id']);
                  HomeConst.Ids = idsCheck;
                  print("IDS CHECK moreProducts---> $idsCheck");
                }
              }
            }
          }
        }
        isSuccess = true;
        notifyListeners();
      } catch (e) {
        isLoading = false;
        errorMessage = e.toString();
        notifyListeners();
      }
    }
    Future<void> getColorTrend({required BuildContext context}) async {
      isColorTrendLoading = true;
      errorColorTrendMessage = null;
      notifyListeners();
      try {
        var value = await DioHelper.getData(
          url: "/rm_page/v1/show",
          context: context,
          query: {
            "slug": "color-trend",
            "with": "blogs",
          },
        );
        colorTrendGallery = value.data['page']['gallery'];
        colorTrendProducts = value.data['page']['products'];
        colorTrendBlog = value.data['page']['blogs'];
        colorTrendContant = value.data['page']['content'];
        colorTrendCover = value.data['page']['cover_for_web'][0]['file'];
        HomeConst.Ids = [];
        if(colorTrendProducts.isNotEmpty){
          for (var e in colorTrendProducts) {
            idsCheck.add(e['id']);
            HomeConst.Ids = idsCheck;
            print("IDS CHECK SEARCH products---> $idsCheck");
          }
        }
        isColorTrendLoading = false;
        isColorTrendSuccess = true;
        notifyListeners();
      } catch (e) {
        isColorTrendLoading = false;
        errorColorTrendMessage = e.toString();
        notifyListeners();
      }
    }
    Future<void> getInspiredCategory({required BuildContext context}) async {
      isInspiredCategoryLoading = true;
      errorInspiredCategoryMessage = null;
      notifyListeners();
      try {
        var value = await DioHelper.getData(
          url: "/inspired-categories/entities-operations",
          context: context,
        );
        inspiredCategories = value.data['data'];
        isInspiredCategoryLoading = false;
        isInspiredCategorySuccess = true;
        notifyListeners();
      } catch (e) {
        isInspiredCategoryLoading = false;
        errorInspiredCategoryMessage = e.toString();
        notifyListeners();
      }
    }
    Future<void> getInspired({required BuildContext context, inspired_categories}) async {
      isInspiredLoading = true;
      errorInspiredMessage = null;
      notifyListeners();
      try {
        var value = await DioHelper.getData(
          url: "/inspired-items/entities-operations",
          context: context,
          query: {
            "inspired_categories" : inspired_categories
          }
        );
        inspireds = value.data['data'];
        isInspiredLoading = false;
        isInspiredSuccess = true;
        notifyListeners();
      } catch (e) {
        isInspiredLoading = false;
        errorInspiredMessage = e.toString();
        notifyListeners();
      }
    }
    var checkResponse;
    Future<void> getCheck({required BuildContext context, ids}) async {
      isCheckLoading = true;
      errorCheckMessage = null;
      notifyListeners();
      print("LENGTH IS ---> $idsCheck");
      print("ids IS ---> $ids");
      try {
        var queryParams = {
          'ids[]': ids, // List of ids
        };
        var value = await DioHelper.getData(
          url: "/rm_ecommarce/v1/products/check",
          context: context,
          query: queryParams,
        );
        checkResponse = value.data;
        print("checkResponse ----> $checkResponse");
        isCheckLoading = false;
        isCheckSuccess = true;
        notifyListeners();
      } catch (e) {
        isCheckLoading = false;
        errorCheckMessage = e.toString();
        notifyListeners();
      }
    }
  }
