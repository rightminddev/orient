import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../constants/app_strings.dart';
import '../../../general_services/alert_service/alerts.service.dart';
import '../services/order.service.dart';

class OrderActionsViewModel extends ChangeNotifier {
  String? orderStatus;

  bool isLoading = false;
  void updateLoadingStatus({required bool laodingValue}) {
    isLoading = laodingValue;
    notifyListeners();
  }

  Future<bool> updateOrderStatus(
    BuildContext context,
    int orderId,
    int storeId,
  ) async {
    updateLoadingStatus(laodingValue: true);
    final result = await _updateOrderStatus(
      context,
      orderId,
      storeId,
    );
    updateLoadingStatus(laodingValue: false);
    return result;
  }

  Future<bool> _updateOrderStatus(
      BuildContext context, int orderId, int storeId) async {
    try {
      final result = await OrdersService.updateOrderStatus(
        context: context,
        orderId: orderId,
        storeId: storeId,
        status: orderStatus!,
      );

      if (result.success && result.data != null) {
        context.pop();
        AlertsService.info(
            title: AppStrings.information.tr(),
            context: context,
            message: result.message ?? AppStrings.updatedSuccessfully.tr());
        return true;
      } else {
        AlertsService.error(
            title: AppStrings.failed.tr(),
            context: context,
            message: result.message ?? AppStrings.failedPleaseTryAgain.tr());
      }
      return false;
      //debugPrint(myOrders.length.toString());
    } catch (err, t) {
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
      return false;
    }
  }
}
