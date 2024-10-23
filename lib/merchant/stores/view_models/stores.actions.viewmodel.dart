import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/constants/settings/app_icons.dart';
import 'package:orient/models/request/request_model.dart';
import 'package:orient/routing/app_router.dart';
import '../../../general_services/alert_service/alerts.service.dart';
import '../../../models/availability/availability_model.dart';
import '../../../utils/components/general_components/all_bottom_sheet.dart';
import '../services/stores.service.dart';

class StoreActionsViewModel extends ChangeNotifier {
  AvailabilityModel addedToStock =
      AvailabilityModel(items: List.empty(growable: true));
  bool isLoading = false;
  bool isLoadingDialog = false;

  RequestModel requestedOrders =
      RequestModel(items: List.empty(growable: true));
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
    try {
      final result = await StoresService.updateAvailableProducts(
          context: context, id: id, data: addedToStock.toJson());
      //TODO: add bottom sheet for success or fail

      if (result.success && result.data != null) {
        // (result.data?['products'] ?? []).forEach((v) {
        //   products.add(ProductModel.fromJson(v));
        // });
        context.pop();
        AlertsService.info(
            title: AppStrings.information.tr(),
            context: context,
            message: result.message ?? AppStrings.updatedSuccessfully.tr());
      } else {
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
      }
      //   debugPrint(products.length.toString());
    } catch (err, t) {
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
        Navigator.of(context).pop();
        await defaultActionBottomSheet(
          context: context,
          headerIcon: SvgPicture.asset(
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
      }
      //   debugPrint(products.length.toString());
    } catch (err, t) {
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
    }
  }
}
