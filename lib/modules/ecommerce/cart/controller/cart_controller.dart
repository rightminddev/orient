import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/alert_service/alerts.service.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
import 'package:orient/modules/ecommerce/cart/model/get_cart_model.dart';

class CartControllerProvider extends ChangeNotifier {
  TextEditingController couponController = TextEditingController();
  TextEditingController promoController = TextEditingController();
  bool isGetCartLoading = false;
  bool isAddCouponSuccess =false;
  bool isDeleteCouponSuccess =false;
  bool isAddItemCountSuccess =false;
  bool isAddCouponLoading = false;
  bool isAddItemCountLoading = false;
  bool isDeleteCouponLoading = false;
  String? errorGetCartMessage;
  String? errorAddCouponMessage;
  String? errorAddItemCountMessage;
  String? errorDeleteCouponMessage;
  var coupons;
  CartModel? cartModel;
  Future<void> getCart({required BuildContext context}) async {
    isGetCartLoading = true;
    errorGetCartMessage = null;
    notifyListeners();
    try {
      var value = await DioHelper.getData(
        url: "/rm_ecommarce/v1/cart/get_active_cart",
        context: context,
        query: {
          "type": "default",
        },
      );
      isGetCartLoading = false;
      cartModel = CartModel.fromJson(value.data);
      notifyListeners();
    } catch (e) {
      isGetCartLoading = false;
      errorGetCartMessage = e.toString();
      notifyListeners();
    }
  }
  Future<void> addItemCount({required BuildContext context, item_id, qty, from}) async {
    isAddItemCountLoading = true;
    errorAddItemCountMessage = null;
    notifyListeners();
    try {
      var value = await DioHelper.postData(
          url: "/rm_ecommarce/v1/cart/change_item_count",
          context: context,
          data: {
            "item_id" : item_id,
            "qty" : qty,
            "from" : from
          }
      );
      isAddItemCountLoading = false;
      getCart(context: context);
      isAddItemCountSuccess = true;
      notifyListeners();
    } catch (e) {
      isAddItemCountLoading = false;
      errorAddItemCountMessage = e.toString();
      notifyListeners();
    }
  }
  Future<void> addCoupon({required BuildContext context, coupon}) async {
    isAddCouponLoading = true;
    errorAddCouponMessage = null;
    notifyListeners();
    try {
      var value = await DioHelper.postData(
        url: "/rm_ecommarce/v1/cart/apply_coupon",
        context: context,
        data: {
          "coupon" : coupon
        }
      );
      if(value.data['status'] == true){
        coupons = value.data['cart']['applied_coupon'];
        AlertsService.success(
            context: context,
            message: value.data['message'],
            title: AppStrings.success.tr()
        );
        couponController.text == promoController.text;
        promoController.clear();
      }
      if(value.data['status'] == false){
        AlertsService.error(
            context: context,
            message: value.data['message'],
            title: AppStrings.failed.tr()
        );
      }
      print("COUPON ----> $coupons");
      isAddCouponLoading = false;
      isAddCouponSuccess = true;

      notifyListeners();
    } catch (e) {
      isAddCouponLoading = false;
      errorAddCouponMessage = e.toString();
      notifyListeners();
    }
  }
  Future<void> deleteCoupon({required BuildContext context, coupon}) async {
    isDeleteCouponLoading = true;
    errorDeleteCouponMessage = null;
    notifyListeners();
    try {
      var value = await DioHelper.postData(
        url: "/rm_ecommarce/v1/cart/delete_coupon",
        context: context,
        data: {
          "coupon" : coupon
        }
      );
      isDeleteCouponLoading = false;
      isDeleteCouponSuccess = true;
      isAddCouponSuccess = false;
      coupons = null;
      couponController.text == promoController.text;
      promoController.clear();
      notifyListeners();
    } catch (e) {
      isDeleteCouponLoading = false;
      errorDeleteCouponMessage = e.toString();
      notifyListeners();
    }
  }
}
