import 'package:flutter/material.dart';
import '../../../models/orders/order_model.dart';
import '../services/order.service.dart';

class OrdersViewModel extends ChangeNotifier {
  List<OrderModel> myOrders = List.empty(growable: true);
  OrderModel orderDetails = OrderModel();
  int pageNumber = 1;
  int count = 0;
  bool isLoading = false;
  bool hasMoreData(int length) {
    if (pageNumber < count) {
      pageNumber = pageNumber + 1;
      return true;
    } else {
      return false;
    }
  }

  void updateLoadingStatus({required bool laodingValue}) {
    isLoading = laodingValue;
    notifyListeners();
  }

  Future<void> initializeMyOrdersScreen(BuildContext context, int id) async {
    updateLoadingStatus(laodingValue: true);
    await _getMyOrders(context, id);
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> initializeOrderDetailsScreen(
      BuildContext context, int storeId, int orderId) async {
    updateLoadingStatus(laodingValue: true);
    await _getOrderDetails(context, storeId, orderId);
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> _getMyOrders(BuildContext context, int id) async {
    try {
      final result = await OrdersService.getMyOrders(context: context, id: id);
      if (result.success && result.data != null) {
        (result.data?['orders'] ?? []).forEach((v) {
          myOrders.add(OrderModel.fromJson(v));
        });
      }
      debugPrint(myOrders.length.toString());
    } catch (err, t) {
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
    }
  }

  Future<void> _getOrderDetails(
      BuildContext context, int storeId, int orderId) async {
    try {
      final result = await OrdersService.getOrderDetails(
          context: context, storeId: storeId, orderId: orderId);

      if (result.success && result.data != null) {
        orderDetails = OrderModel.fromJson(result.data?['order']);
      }
      debugPrint(myOrders.length.toString());
    } catch (err, t) {
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
    }
  }
}
