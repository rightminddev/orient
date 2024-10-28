import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
import 'package:orient/modules/ecommerce/checkout/controller/cosnts.dart';
import 'package:orient/modules/ecommerce/single_product/model/single_product_model.dart';

class SingleProductProvider extends ChangeNotifier {
  TextEditingController numberOfMetersController = TextEditingController();
  bool isLoading = false;
  bool isShowCommentLoading = false;
  bool isAddCommentLoading = false;
  bool isAddCommentSuccess = false;
  bool isAddtoCartLoading = false;
  bool isAddtoCartSuccess = false;
  String? errorAddtoCartMessage;
  String? errorShowCommentMessage;
  String? errorAddCommentMessage;
  String? errorMessage;
 String? productName ;
 String? productReview_rate ;
 String? productReview_count ;
 String? productDecscription ;
 List productVariations = [];
 var productVariationsColor;
 var productVariationsSize;
 String? productImage ;
 List comments = [];
 List productAttributesColors = [];
 List productAttributesSizes = [];
 var count = 1;
  SingleProductModel? singleProductModel;
  int? selectColorIndex;
  void changeColorIndex(id){
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
      print("VALUE ----> ${values.data}");
      singleProductModel = SingleProductModel.fromJson(values.data);
      print("CheckConst.productParentId -----> ${CheckConst.productParentId}");
      CheckConst.productParentId = values.data['product']['parent_id'];
      print("CheckConst.productParentId -----> ${CheckConst.productParentId}");
      productVariations = values.data['variations'];
      productName = values.data['product']['title'];
      productDecscription = values.data['product']['description'];
      productReview_rate = values.data['product']['review_rate'];
      productReview_count = values.data['product']['review_count'];
      productImage = values.data['product']['main_cover'][0]['thumbnail'];
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
      values.data['variations'][0].forEach((e){
        if(e['attribute_id'] == 1){
          productVariationsColor = e['option_id'];
          print("productVariationsColor ---> $productVariationsColor");
        }else if(e['attribute_id'] == 2){
          productVariationsSize = e['option_id'];
          print("productVariationsSize ---> $productVariationsSize");
        }
      });
      values.data['variations'][1].forEach((e){
        if(e['attribute_id'] == 1){
          productVariationsColor = e['option_id'];
          print("productVariationsColor ---> $productVariationsColor");
        }else if(e['attribute_id'] == 2){
          productVariationsSize = e['option_id'];
          print("productVariationsSize ---> $productVariationsSize");
        }
      });

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
}
