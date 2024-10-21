import 'package:flutter/material.dart';
import '../services/order.service.dart';

class OrderActionsViewModel extends ChangeNotifier {
  String? orderStatus;

  bool isLoading = false;
  void updateLoadingStatus({required bool laodingValue}) {
    isLoading = laodingValue;
    notifyListeners();
  }

  Future<void> updateOrderStatus(
    BuildContext context,
    int orderId,
    int storeId,
  ) async {
    updateLoadingStatus(laodingValue: true);
    await _updateOrderStatus(
      context,
      orderId,
      storeId,
    );
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> _updateOrderStatus(
      BuildContext context, int orderId, int storeId) async {
    try {
      final result = await OrdersService.updateOrderStatus(
        context: context,
        orderId: orderId,
        storeId: storeId,
        status: orderStatus!,
      );

      if (result.success && result.data != null) {
        Navigator.of(context).pop();
        // (result.data?['orders'] ?? []).forEach((v) {
        //   myOrders.add(OrderModel.fromJson(v));
        // });
      }
      //debugPrint(myOrders.length.toString());
    } catch (err, t) {
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
    }
  }
}
