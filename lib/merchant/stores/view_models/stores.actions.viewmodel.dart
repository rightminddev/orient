import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/constants/settings/app_icons.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
import 'package:orient/models/request/request_model.dart';
import 'package:orient/routing/app_router.dart';
import '../../../general_services/alert_service/alerts.service.dart';
import '../../../models/availability/availability_model.dart';
import '../../../utils/components/general_components/all_bottom_sheet.dart';
import '../services/stores.service.dart';

class StoreActionsViewModel extends ChangeNotifier {
  AvailabilityModel addedToStock = AvailabilityModel(items: List.empty(growable: true));
  bool isLoading = false;
  bool isLoadingDialog = false;
String? errorMessage;
  RequestModel requestedOrders =
      RequestModel(items: List.empty(growable: true), name: "items");
  AvailabilityModel availabilityModel =
  AvailabilityModel(items: List.empty(growable: true));

  int subTotal = 0;
  int discount = 0;
  int total = 0;
  void updateLoadingStatus({required bool laodingValue}) {
    isLoading = laodingValue;
    notifyListeners();
  }

  void updateLoadingDialogStatus({required bool laodingValue}) {
    isLoadingDialog = laodingValue;
    notifyListeners();
  }

  Future<void> updateAvailableProducts(BuildContext context, int id) async {
    updateLoadingStatus(laodingValue: true);
    await _updateAvailableProducts(context, id);
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> calculateOrders(BuildContext context,
      StoreActionsViewModel storeActionsViewModel, int id) async {
    updateLoadingStatus(laodingValue: true);
    await _calculateOrders(context, storeActionsViewModel, id);
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> completeOrders(BuildContext context, int id) async {
    updateLoadingDialogStatus(laodingValue: true);
    await _completeOrders(context, id);
    updateLoadingDialogStatus(laodingValue: false);
  }

  Future<void> _updateAvailableProducts(BuildContext context, int id) async {
    if(addedToStock.toJson()['availabilities'].isNotEmpty){
      print("STOCK IS ---> ${addedToStock.toJson()['availabilities']} ");
      try {
        final result = await StoresService.updateAvailableProducts(
            context: context, id: id, data: addedToStock.toJson());
        //TODO: add bottom sheet for success or fail

        if (result.success && result.data != null) {
          // (result.data?['products'] ?? []).forEach((v) {
          //   products.add(ProductModel.fromJson(v));
          // });
          context.pop();
          AlertsService.success(
              title: AppStrings.success.tr(),
              context: context,
              message: result.message ?? AppStrings.updatedSuccessfully.tr());
        } else {
          Fluttertoast.showToast(
              msg: result.message!,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          AlertsService.error(
              title: AppStrings.failed.tr(),
              context: context,
              message: result.message ?? AppStrings.failedPleaseTryAgain.tr());
        }
        //   debugPrint(products.length.toString());
      } catch (err, t) {
        debugPrint(
            "error while getting Employee Details  ${err.toString()} at :- $t");
      }
    }
  }
  Future<void> postAvailableProducts(BuildContext context, int id) async {
    availabilityModel.items = requestedOrders.items;
    isLoading = true;
    notifyListeners();
    await DioHelper.postData(
        url: "/rm_ecommarce/v1/stores/$id/stock/availability",
        context: context,
        data: jsonEncode(addedToStock.toJson())
    ).then((value){
      isLoading = false;
      if(value.data["status"] == false){
        Fluttertoast.showToast(
            msg: value.data["message"],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        AlertsService.error(
            context: context,
            message: value.data["message"],
            title: AppStrings.failed.tr());
      } if(value.data["status"] == true){
        AlertsService.success(
            context: context,
            message: value.data["message"],
            title: AppStrings.success.tr());
      }
      notifyListeners();
    }).catchError((error){
      isLoading = false;
      notifyListeners();
      if (error is DioError) {
        errorMessage = error.response?.data['message'] ?? 'Something went wrong';
      } else {
        errorMessage = error.toString();
      }
      Fluttertoast.showToast(
          msg: errorMessage!,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      AlertsService.error(
          context: context,
          message: errorMessage!,
          title: AppStrings.failed.tr());
      print("ERROR IS ---> ${errorMessage}");
    });
  }
  Future<void> _calculateOrders(BuildContext context,
      StoreActionsViewModel storeActionsViewModel, int id) async {
    try {

      final result = await StoresService.calculateOrders(
          context: context, id: id, data: requestedOrders.toJson());
      //TODO: add bottom sheet for success or fail

      if (result.success && result.data != null) {
        subTotal = result.data?["sub_total"];
        discount = result.data?["discounts"];
        total = result.data?["total"];
        await completeOrderActionBottomSheet(
            context: context,
            subTotal: subTotal,
            storeActionsViewModel: storeActionsViewModel,
            discount: discount,
            total: total,
            onTapButton: () async {
              await completeOrders(context, id);
            });
        notifyListeners();
      }else{
        Fluttertoast.showToast(
            msg: result.message!,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        AlertsService.error(
            context: context,
            message: result.message!,
            title: AppStrings.failed.tr());
      }
      notifyListeners();
      //   debugPrint(products.length.toString());
    } catch (err, t) {
      Fluttertoast.showToast(
          msg: err.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      AlertsService.error(
          context: context,
          message: err.toString(),
          title: AppStrings.failed.tr());
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
    }
  }

  Future<void> _completeOrders(BuildContext context, int id) async {
    try {
      final result = await StoresService.completeOrders(
          context: context, id: id, data: requestedOrders.toJson());
      //TODO: add bottom sheet for success or fail

      if (result.success && result.data != null) {
        await defaultActionBottomSheet(
          context: context,
          home: false,
          headerIcon: SvgPicture.asset(
            fit: BoxFit.scaleDown,
            AppIcons.successRequest,
            width: 40,
            height: 40,
          ),
          title: AppStrings.successful.tr(),
          subTitle: AppStrings
              .yourOrderWillBeDeliveredSoonThankYouForChoosingOurApp
              .tr(),
          buttonText: AppStrings.goToHome.tr(),
          viewCheckIcon: false,
          viewDropDownButton: false,
          onTapButton: () {
            context.goNamed(AppRoutes.merchantHomeScreen.name,
                pathParameters: {'lang': context.locale.languageCode});
          },
        );
      }else{
        Fluttertoast.showToast(
            msg: result.message!,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        AlertsService.error(
            context: context,
            message: result.message!,
            title: AppStrings.failed.tr());
      }
      //   debugPrint(products.length.toString());
    } catch (err, t) {
      Fluttertoast.showToast(
          msg: err.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      AlertsService.error(
          context: context,
          message: err.toString(),
          title: AppStrings.failed.tr());
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
    }
  }
}
