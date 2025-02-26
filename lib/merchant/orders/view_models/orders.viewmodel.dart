import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/alert_service/alerts.service.dart';
import 'package:orient/models/invoice_details_model.dart';
import 'package:orient/models/invoice_model.dart';
import 'package:orient/models/model_odoo_order_details.dart';
import '../../../models/orders/order_model.dart';
import '../services/order.service.dart';

class OrdersViewModel extends ChangeNotifier {
  List<OrderModel> myOrders = List.empty(growable: true);
  List<InvoiceModel> myInvoices = List.empty(growable: true);
  List orders = [];
  OrderModel orderDetails = OrderModel();
  OdooOrderDetailsModel? odooOrderDetailsModel;
  InvoiceDetailsModel? invoiceDetailsModel;
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
  Future<void> initializeMyOrdersOdooScreen(BuildContext context, int id) async {
    updateLoadingStatus(laodingValue: true);
    await _getMyOrdersOdoo(context, id);
    updateLoadingStatus(laodingValue: false);
  }
  Future<void> initializeGetMyOrdersInvoices(BuildContext context, int storeId, int orderId) async {
    updateLoadingStatus(laodingValue: true);
    await _getMyOrdersInvoices(context, storeId, orderId);
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> initializeOrderDetailsScreen(
      BuildContext context, int storeId, int orderId) async {
    updateLoadingStatus(laodingValue: true);
    await _getOrderDetails(context, storeId, orderId);
    updateLoadingStatus(laodingValue: false);
  }
  Future<void> initializeOrderOdooDetailsScreen(
      BuildContext context, int storeId, int orderId) async {
    updateLoadingStatus(laodingValue: true);
    await _getOrderOdooDetails(context, storeId, orderId);
    updateLoadingStatus(laodingValue: false);
  }
  Future<void> initializeInvoiceDetailsScreen(
      BuildContext context, int storeId, int orderId,int invoiceId) async {
    updateLoadingStatus(laodingValue: true);
    await _getMyOrdersInvoicesDetails(context, storeId, orderId, invoiceId);
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> _getMyOrders(BuildContext context, int id) async {
    try {
      final result = await OrdersService.getMyOrders(context: context, id: id);
      if (result.success && result.data != null) {
        (result.data?['orders'] ?? []).forEach((v) {
          myOrders.add(OrderModel.fromJson(v));

        });
        debugPrint(myOrders.length.toString());
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
    } catch (err, t) {
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
      AlertsService.error(
          context: context,
          message: err.toString(),
          title: AppStrings.failed.tr());
    }
  }
  Future<void> _getMyOrdersInvoices(BuildContext context, int storeId, int orderId) async {
    try {
      final result = await OrdersService.getMyOrdersInvoices(context: context, storeId: storeId, orderId: orderId);
      if (result.success && result.data != null) {
        (result.data?['invoices'] ?? []).forEach((v) {
          myInvoices.add(InvoiceModel.fromJson(v));

        });
        debugPrint(myOrders.length.toString());
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
    } catch (err, t) {
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
      AlertsService.error(
          context: context,
          message: err.toString(),
          title: AppStrings.failed.tr());
    }
  }
  Future<void> _getMyOrdersInvoicesDetails(BuildContext context, int storeId, int orderId, int invoiceId ) async {
    try {
      final result = await OrdersService.getMyOrdersInvoicesDetails(context: context, storeId: storeId, orderId: orderId, invoiceId: invoiceId);
      if (result.success && result.data != null) {
        invoiceDetailsModel = InvoiceDetailsModel.fromJson(result.data!);
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
    } catch (err, t) {
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
      AlertsService.error(
          context: context,
          message: err.toString(),
          title: AppStrings.failed.tr());
    }
  }
  Future<void> _getMyOrdersOdoo(BuildContext context, int id) async {
    try {
      final result = await OrdersService.getMyOrdersOdoo(context: context, id: id);
      if (result.success && result.data != null) {
        orders = result.data!['orders'];
        (result.data?['orders'] ?? []).forEach((v) {
          myOrders.add(OrderModel.fromJson(v));
        });
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
      debugPrint(myOrders.length.toString());
    } catch (err, t) {
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
      AlertsService.error(
          context: context,
          message: err.toString(),
          title: AppStrings.failed.tr());
    }
  }

  Future<void> _getOrderDetails(
      BuildContext context, int storeId, int orderId) async {
    try {
      final result = await OrdersService.getOrderDetails(
          context: context, storeId: storeId, orderId: orderId);

      if (result.success && result.data != null) {
        orderDetails = OrderModel.fromJson(result.data?['order']);
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
      }
      debugPrint(myOrders.length.toString());
    } catch (err, t) {
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
    }
  }
  Future<void> _getOrderOdooDetails(
      BuildContext context, int storeId, int orderId) async {
    try {
      final result = await OrdersService.getOrderOdooDetails(
          context: context, storeId: storeId, orderId: orderId);

      if (result.success && result.data != null) {
        odooOrderDetailsModel = OdooOrderDetailsModel.fromJson(result.data!);
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
      }
      debugPrint(myOrders.length.toString());
    } catch (err, t) {
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
    }
  }
}
