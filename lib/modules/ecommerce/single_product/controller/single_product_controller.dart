import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
import 'package:orient/modules/ecommerce/checkout/controller/cosnts.dart';
import 'package:orient/modules/ecommerce/single_product/controller/const.dart';
import 'package:orient/modules/ecommerce/single_product/model/single_product_model.dart';

class SingleProductProvider extends ChangeNotifier {
  TextEditingController numberOfMetersController = TextEditingController();
  bool isLoading = false;
  bool isShowCommentLoading = false;
  bool isCheckLoading = false;
  bool isAddCommentLoading = false;
  bool isAddCommentSuccess = false;
  bool isAddtoCartLoading = false;
  bool isAddtoCartSuccess = false;
  bool isCheckSuccess = false;
  String? errorAddtoCartMessage;
  String? errorShowCommentMessage;
  String? errorAddCommentMessage;
  String? errorMessage;
  String? errorCheckMessage;
 String? productName ;
 String? productReview_rate ;
 String? productReview_count ;
 String? productDecscription ;
 List productVariations = [];
 String? productImage ;
 List comments = [];
 List productAttributesColors = [];
 List productAttributesSizes = [];
 List pdf = [];
 var count = 1;
 bool? check;
 var productVariationsColor;
 var productVariationsSize;
  SingleProductModel? singleProductModel;
  int? selectColorIndex;
  void changeColorIndex(id){
    productVariationsColor = null;
    productVariationsColor = id;
    notifyListeners();
  }
  void changeSizeIndex(id){
    productVariationsSize = id;
    notifyListeners();
  }
  Future<void> getOneProduct({required BuildContext context, int? id, bool crossSells = false, bool variation = false}) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      var values = await DioHelper.postData(
        url: (variation == true) ?(CheckConst.productParentId != null)?"/rm_ecommarce/v1/products/${CheckConst.productParentId}":"/rm_ecommarce/v1/products/$id"  :"/rm_ecommarce/v1/products/$id",
        context: context,
        query: {
         if(crossSells == true)  "with": "crossSells",
         if(productVariationsColor != null)  "options[1]" : productVariationsColor,
         if(productVariationsSize != null) "options[2]" : productVariationsSize
        },
      );
      if(values.data['attributes'].isNotEmpty){
        values.data['attributes'].forEach((e){
          if(e['slug'] == "color"){
            productAttributesColors = e['options'];
          }
        });
        values.data['attributes'].forEach((e){
          if(e['slug'] == "wight"){
            productAttributesSizes = e['options'];
            print("productAttributesSizes ---> $productAttributesSizes");
          }
        });
      }
      if(values.data['variations'].isNotEmpty){
        values.data['variations'][0].forEach((e){
          if(e['attribute_id'] == 1){
            productVariationsColor ??= e['option_id'];
            print("productVariationsColor1 ---> $productVariationsColor");
          }else if(e['attribute_id'] == 2){
            productVariationsSize ??= e['option_id'];
            print("productVariationsSize1 ---> $productVariationsSize");
          }
        });
      }
      if(values.data['variations'].length > 1){
        values.data['variations'][1].forEach((e){
          if(e['attribute_id'] == 1){
            productVariationsColor ??= e['option_id'];
            print("productVariationsColor2 ---> $productVariationsColor");
          }else if(e['attribute_id'] == 2){
            productVariationsSize ??= e['option_id'];
            print("productVariationsSize2 ---> $productVariationsSize");
          }
        });
      }
      print("VALUE ----> ${values.data}");
      singleProductModel = SingleProductModel.fromJson(values.data);
      print("CheckConst.productParentId -----> ${CheckConst.productParentId}");
      CheckConst.productParentId = values.data['product']['parent_id'];
      print("CheckConst.productParentId -----> ${CheckConst.productParentId}");
      if(values.data['product']['pdf'].isNotEmpty ) pdf = values.data['product']['pdf'];
      print("PDF is $pdf");
      if(values.data['variations']!=null)productVariations = values.data['variations'];
      if(values.data['product']['title']!=null) productName = values.data['product']['title'];
      if(values.data['product']['description']!=null) productDecscription = values.data['product']['description'];
      if(values.data['product']['review_rate']!=null) productReview_rate = values.data['product']['review_rate'];
      if(values.data['product']['review_count']!=null) productReview_count = values.data['product']['review_count'];
      if(values.data['product']['main_cover'][0]['thumbnail']!=null) productImage = values.data['product']['main_cover'][0]['thumbnail'];
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }
  Future<void> getComments({required BuildContext context, int? id,}) async {
    isShowCommentLoading = true;
    errorShowCommentMessage = null;
    notifyListeners();
    try {
      var value = await DioHelper.getData(
        url: "/rm_ecommarce/v1/products/$id/reviews",
        context: context,
        query: {
          "page" : 1,
        },
      );
      isShowCommentLoading = false;
      isAddCommentSuccess = false;
      comments = value.data['reviews'];
      notifyListeners();
    } catch (e) {
      isShowCommentLoading = false;
      errorShowCommentMessage = e.toString();
      notifyListeners();
    }
  }
  Future<void> addComments({required BuildContext context, int? id, rating, content}) async {
    isAddCommentLoading = true;
    errorAddCommentMessage = null;
    notifyListeners();
    try {
      var value = await DioHelper.postData(
        url: "/rm_ecommarce/v1/products/$id/review",
        context: context,
        data: {
          "rating" : rating,
          "content" : content
      }
      );
      isAddCommentLoading = false;
      isAddCommentSuccess = true;
      print(value.data);
      notifyListeners();
    } catch (e) {
      isAddCommentLoading = false;
      errorShowCommentMessage = e.toString();
      notifyListeners();
    }
  }
  Future<void> addToCart({required BuildContext context, int? id, int? qty,}) async {
    isAddtoCartLoading = true;
    errorAddtoCartMessage = null;
    notifyListeners();
    try {
      var value = await DioHelper.postData(
          url: "/rm_ecommarce/v1/cart/add_to_cart",
          context: context,
          data: {
            "product_id" : id,
            "qty" : qty
          }
      );
      isAddtoCartLoading = false;
      isAddtoCartSuccess = true;
      print(value.data);
      notifyListeners();
    } catch (e) {
      isAddtoCartLoading = false;
      errorAddtoCartMessage = e.toString();
      notifyListeners();
    }
  }
  Future<void> getCheck({required BuildContext context, id}) async {
    isCheckLoading = true;
    errorCheckMessage = null;
    notifyListeners();
    try {
      var value = await DioHelper.getData(
          url: "/rm_ecommarce/v1/products/check",
          context: context,
          query: {
            "ids[]" : id
          }
      );
      check = value.data['products']["$id"]['favorite'];
      print("CHECK IS ---> $check");
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
