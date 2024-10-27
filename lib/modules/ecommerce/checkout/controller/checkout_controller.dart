import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
import 'package:orient/modules/ecommerce/checkout/controller/cosnts.dart';
import 'package:orient/modules/ecommerce/checkout/model/get_user_address.dart';
import 'package:orient/utils/components/general_components/all_bottom_sheet.dart';

class CheckoutControllerProvider extends ChangeNotifier {
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  int? selectedPaymentId;
  bool isPrepareCheckoutSuccess =false;
  bool isAddAddressSuccess =false;
  bool isUpdateCartSuccess =false;
  bool isConfirmOrderSuccess =false;
  bool isPrepareCheckoutLoading = false;
  bool isConfirmOrderLoading = false;
  bool isUpdateCartLoading = false;
  bool isAddAddressLoading = false;
  String? paymentUrl;
  UserAddressModel? userAddressModel;
  String? errorPrepareCheckoutMessage;
  String? errorConfirmOrderMessage;
  String? errorUpdateCartMessage;
  String? errorAddAddressMessage;
  List checkoutListItems = [];
  List checkoutPaymentMethods = [];
  List checkoutUserAddress = [];
  var checkoutSubtotal;
  var checkoutFees;
  var checkoutTotal;
  var checkoutDiscountTotal;
  void setPaymentStatus(String? status) {
   CheckConst.paymentStatus = status;
    notifyListeners();
  }

  Future<void> getPrepareCheckout({required BuildContext context}) async {
    isPrepareCheckoutLoading = true;
    errorPrepareCheckoutMessage = null;
    notifyListeners();
    try {
      var value = await DioHelper.getData(
        url: "/rm_ecommarce/v1/cart/prepare_checkout",
        context: context,
      );
      isPrepareCheckoutLoading = false;
      isPrepareCheckoutSuccess = true;
      userAddressModel = UserAddressModel.fromJson(value.data);
      checkoutUserAddress = value.data['user_addresses'];
      checkoutListItems = value.data['cart']['items'];
      checkoutPaymentMethods = value.data['payment_methods'];
      checkoutSubtotal = value.data['cart']['sub_total'];
      checkoutFees = value.data['cart']['fees_total'];
      checkoutTotal = value.data['cart']['total'];
      checkoutDiscountTotal = value.data['cart']['discount_total'];
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
        context: context,
        data: {
          "phone": phone,
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
      notifyListeners();
    } catch (e) {
      isAddAddressLoading = false;
      errorAddAddressMessage = e.toString();
      notifyListeners();
    }
  }
  Future<void> confirmOrder({required BuildContext context,email, name,  phone, country_key, address, country_id, state_id,city_id }) async {
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
      isConfirmOrderLoading = false;
      paymentUrl = value.data['url'];
      isConfirmOrderSuccess = true;
      notifyListeners();
    } catch (e) {
      isConfirmOrderLoading = false;
      errorConfirmOrderMessage = e.toString();
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
