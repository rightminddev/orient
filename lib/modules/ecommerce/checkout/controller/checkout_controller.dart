import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/alert_service/alerts.service.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
import 'package:orient/modules/ecommerce/checkout/controller/cosnts.dart';
import 'package:orient/modules/ecommerce/checkout/model/get_address_model.dart';
import 'package:orient/modules/ecommerce/checkout/model/update_cart_model.dart';
import 'package:orient/modules/shared_more_screen/shipping_address/model_address.dart';

class CheckoutControllerProvider extends ChangeNotifier {
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isPrepareCheckoutSuccess =false;
  bool isAddAddressSuccess =false;
  bool isShippingAddressLoading =false;
  bool isUpdateAddressSuccess =false;
  bool isGetAddressSuccess =false;
  bool isUpdateCartSuccess =false;
  bool isConfirmOrderSuccess =false;
  bool isPrepareCheckoutLoading = false;
  bool isConfirmOrderLoading = false;
  bool isLoading = false;
  bool isSuccess = false;
  bool isUpdateCartLoading = false;
  bool isAddAddressLoading = false;
  bool isGetAddressLoading = false;
  bool isUpdateAddressLoading = false;
  String? paymentUrl;
  UserAddressModel? userAddressModel;
  AddressModel? addressModel;
  UpdateCartModel? updateCartModel;
  String? errorPrepareCheckoutMessage;
  String? errorConfirmOrderMessage;
  String? errorUpdateCartMessage;
  String? errorAddAddressMessage;
  String? errorGetAddressMessage;
  String? errorUpdateAddressMessage;
  List checkoutListItems = [];
  List checkoutPaymentMethods = [];
  List checkoutUserAddress = [];
  List shippingAddresses = [];
  var checkoutSubtotal;
  var checkoutAddress;
  var checkoutAddressId;
  var checkoutDefualtAddress;
  var checkoutDefualtAddressId;
  var checkoutFees;
  var checkoutTotal;
  var checkoutDiscountTotal;
  var checkoutTax;
  var checkoutShipping;
  List address = [];
  void setPaymentStatus(String? status) {
   CheckConst.paymentStatus = status;
    notifyListeners();
  }
  void updateScreen(){
    notifyListeners();
  }
  Future<void> getShippingAddress({required BuildContext context}) async {
    notifyListeners();
    isShippingAddressLoading = true;
    errorPrepareCheckoutMessage = null;
    CheckConst.selectedPaymentId = null;
    await DioHelper.getData(
      url: "/shipping-addresses/entities-operations",
      query: {
        "itemsCount" : 50
      },
      context: context,
    ).then((value){
      isShippingAddressLoading = false;
      isPrepareCheckoutSuccess = true;
      address = value.data['data'];
      addressModel = AddressModel.fromJson(value.data);
      print("userAddressModel_>$addressModel");
      print("userAddressModel_>${addressModel!}");
      notifyListeners();
    }).catchError((e){
      isShippingAddressLoading = false;
      errorPrepareCheckoutMessage = e.toString();
      notifyListeners();
    });
  }
  Future<void> getPrepareCheckout({required BuildContext context}) async {
    isPrepareCheckoutLoading = true;
    errorPrepareCheckoutMessage = null;
    CheckConst.selectedPaymentId = null;
    notifyListeners();
    try {
      var value = await DioHelper.getData(
        url: "/rm_ecommarce/v1/cart/prepare_checkout",
        context: context,
      );
      isPrepareCheckoutLoading = false;
      isPrepareCheckoutSuccess = true;
      checkoutUserAddress = value.data['user_addresses'];
      checkoutAddress = value.data['user_address'];
      checkoutAddressId = value.data['cart']['address_id'];
      checkoutListItems = value.data['cart']['items'];
      checkoutPaymentMethods = value.data['payment_methods'];
      checkoutSubtotal = value.data['cart']['sub_total'];
      checkoutFees = value.data['cart']['fees_total'];
      checkoutTotal = value.data['cart']['total'];
      checkoutDiscountTotal = value.data['cart']['discount_total'];
      checkoutTax = value.data['cart']['taxes_total'];
      checkoutShipping = value.data['cart']['shipping_cost'];
      if(checkoutAddressId != null){
        checkoutUserAddress.forEach((e){
          if(e['id'] == checkoutAddressId){
            checkoutDefualtAddress = e['address'];
            checkoutDefualtAddressId = e['id'];
          }
        });
      }
      if(CheckConst.selectedPaymentId != null){
      }else{
        //CheckConst.selectedPaymentId = value.data['payment_methods'][0]['id'];
      }
      userAddressModel = UserAddressModel.fromJson(value.data['user_address']);
      CheckConst.userAddressModel = userAddressModel;
      print("userAddressModel_>$userAddressModel");
      print("userAddressModel_>${userAddressModel!.address}");
      notifyListeners();
    } catch (e) {
      isPrepareCheckoutLoading = false;
      errorPrepareCheckoutMessage = e.toString();
      notifyListeners();
    }
  }
  Future<void> addAddressCheckout({required BuildContext context, phone, city_id, country_key, address, country_id, state_id, user_id }) async {
    isAddAddressLoading = true;
    errorAddAddressMessage = null;
    notifyListeners();
    try {
      var value = await DioHelper.postData(
        url: "/shipping-addresses/entities-operations/store",
          query: {
            "itemsCount" : 50
          },
        context: context,
        data: {
         if(phone != null) "phone": phone,
          "country_key": country_key,
          "address" : address,
          "city_id" : city_id,
          "country_id": country_id,
          "state_id" : state_id,
          "user_id" : user_id
        }
      );
      isAddAddressLoading = false;
      isAddAddressSuccess = true;
      CheckConst.selectedAddressId= value.data['id'];
      CheckConst.userAddressModel!.id = value.data['id'];
      userAddressModel!.id = value.data['id'];
      userAddressModel!.address  = address;
      notifyListeners();
    } catch (e) {
      isAddAddressLoading = false;
      errorAddAddressMessage = e.toString();
      notifyListeners();
    }
  }
  Future<void> getAddressCheckout({required BuildContext context,}) async {
    isGetAddressLoading = true;
    errorGetAddressMessage = null;
    notifyListeners();
    try {
      var value = await DioHelper.getData(
        url: "/shipping-addresses/entities-operations",
        context: context,
        query: {
          "itemsCount" : 50
        },
      );
      shippingAddresses = value.data['data'];
      isGetAddressLoading = false;
      notifyListeners();
    } catch (e) {
      isGetAddressLoading = false;
      errorGetAddressMessage = e.toString();
      notifyListeners();
    }
  }
  Future<void> updateAddressCheckout({required BuildContext context, phone, city_id, country_key, address, country_id, state_id, user_id, id }) async {
    isUpdateAddressLoading = true;
    errorUpdateAddressMessage = null;
    notifyListeners();
    try {
      var value = await DioHelper.putData(
        url: "/shipping-addresses/entities-operations/$id/update",
        context: context,
        data: {
         if(phone != null) "phone": phone,
          "country_key": country_key,
          "address" : address,
          "city_id" : city_id,
          "country_id": country_id,
          "state_id" : state_id,
          "user_id" : user_id
        }
      );
      CheckConst.userAddressModel!.address = address;
      CheckConst.userAddressModel!.id = id;
      print("CheckConst.selectedPaymentId -> ${CheckConst.selectedPaymentId}");
      CheckConst.selectedAddressId = id;
      isUpdateAddressSuccess = true;
      userAddressModel!.id = id;
      userAddressModel!.address = address;
          isUpdateAddressLoading = false;
      notifyListeners();
    } catch (e) {
      isUpdateAddressLoading = false;
      errorUpdateAddressMessage = e.toString();
      notifyListeners();
    }
  }
  Future<void> updateShippingAddress({required BuildContext context, phone, city_id, country_key, address, country_id, state_id, user_id, id }) async {
    isLoading = true;
    notifyListeners();
    try {
      var value = await DioHelper.putData(
        url: "/shipping-addresses/entities-operations/$id/update",
        context: context,
        data: {
         if(phone != null) "phone": phone,
          "country_key": country_key,
          "address" : address,
          "city_id" : city_id,
          "country_id": country_id,
          "state_id" : state_id,
          "user_id" : user_id
        }
      );
      isSuccess = true;
      AlertsService.success(
          context: context,
          message: 'UPDATED SUCCESSFULLY',
          title: 'SUCCESS');
          isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      AlertsService.error(
          context: context,
          message: 'UPDATED FAILED',
          title: 'FAILED');
      notifyListeners();
    }
  }
  Future<void> confirmOrder({required BuildContext context,email, name,  phone, country_key, address, country_id, state_id,city_id }) async {
    if(address == null){
      AlertsService.error(
          context: context,
          message: AppStrings.pleaseSelectAddress.tr(),
          title: AppStrings.failed.tr());
      return ;
    }
    isConfirmOrderLoading = true;
    errorConfirmOrderMessage = null;
    notifyListeners();
    try {
      var value = await DioHelper.postData(
        url: "/rm_ecommarce/v1/cart/complete_order",
        context: context,
        data: {
          "callback": "http://rm.localhost/testing/v1",
          "name": name,
          "email" : email,
          "country_key": country_key,
          "phone" : phone,
          "address" : address,
          "country_id" : country_id,
          "state_id" : state_id,
          "city_id" : city_id
        }
      );
      if(value.data['status'] == true){
        CheckConst.selectedPaymentId = null;
        isConfirmOrderLoading = false;
        paymentUrl = value.data['url'];
        isConfirmOrderSuccess = true;
      }else{
        CheckConst.selectedPaymentId = null;
        isConfirmOrderLoading = false;
        AlertsService.error(
            context: context,
            message: value.data['message'],
            title: AppStrings.failed.tr());
      }
      notifyListeners();
    } catch (e) {
      isConfirmOrderLoading = false;
      errorConfirmOrderMessage = e.toString();
      if (e is DioError) {
        errorConfirmOrderMessage = e.response?.data['message'] ?? 'Something went wrong';
      } else {
        errorConfirmOrderMessage = e.toString();
      }
        AlertsService.error(
            context: context,
            message: errorConfirmOrderMessage!,
            title: AppStrings.failed.tr());
      notifyListeners();
    }
  }
  Future<void> updateCart({required BuildContext context, address_id, payment_method_id }) async {
    isUpdateCartLoading = true;
    errorUpdateCartMessage = null;
    notifyListeners();
    try {
      var value = await DioHelper.postData(
        url: "/rm_ecommarce/v1/cart/update_cart",
        context: context,
        data: {
          "address_id" : address_id,
          "payment_method_id" : payment_method_id
        }
      );
      updateCartModel = UpdateCartModel.fromJson(value.data);
      isUpdateCartLoading = false;
      isUpdateCartSuccess = true;
      notifyListeners();
    } catch (e) {
      isUpdateCartLoading = false;
      errorUpdateCartMessage = e.toString();
      notifyListeners();
    }
  }
}
