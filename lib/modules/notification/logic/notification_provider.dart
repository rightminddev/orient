import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
import 'package:orient/models/get_one_notification_model.dart';
import 'package:orient/models/notification.model.dart';

class NotificationProviderModel extends ChangeNotifier {
  bool isGetNotificationLoading = false;
  bool isGetNotificationSuccess = false;
  bool hasMoreNotifications = true; // Track if there are more notifications to load
  String? getNotificationErrorMessage;
  List notifications = [];
  List newNotifications = [];
  int currentPage = 1;
  final int itemsCount = 9;
  bool hasMore = true;
  final int expectedPageSize = 9;
  Set<int> notificationIds = {}; // Track unique product IDs

  bool hasMoreData(int length) {
    if (length < expectedPageSize) {
      return false;
    } else {
      currentPage += 1;
      return true;
    }
  }
  Future<void> refreshPaints(context) async{
    currentPage = 1;
    hasMore = true;
    await getNotification(page : 1,context);
  }
  Future<void> getNotification(BuildContext context, {int? page}) async {
    if(page != null){currentPage = page;}
    print("currentPage is --> $currentPage}");
    isGetNotificationLoading = true;
    notifyListeners();
    try {
      final response = await DioHelper.getData(
        url: "/rmnotifications/entities-operations",
        context: context, // Pass this explicitly only if necessary
        query: {
          "itemsCount": itemsCount,
          "page": page ?? currentPage,
        },
      );

       newNotifications = response.data['data'] ?? [];
      List uniqueNotifications = newNotifications.where((p) => !notificationIds.contains(p['id'])).toList();
      if (page == 1) {
        notifications.clear(); // Clear only when loading the first page
      }
      if (newNotifications.isNotEmpty) {
        notifications.addAll(uniqueNotifications);
        print("LENGTH IS --> ${newNotifications.length}");
        if (hasMore) currentPage++;
      } else {
        hasMoreNotifications = false;

      }

      isGetNotificationSuccess = true;
    } catch (error) {
      getNotificationErrorMessage = error is DioError
          ? error.response?.data['message'] ?? 'Something went wrong'
          : error.toString();
    } finally {
      isGetNotificationLoading = false;
      notifyListeners();
    }
  }
  NotificationSingleModel? notificationModel;
  Future<void> getNotificationSingle(BuildContext context, id) async {
    isGetNotificationLoading = true;
    notifyListeners();
    try {
      final response = await DioHelper.getData(
        url: "/rmnotifications/entities-operations/$id",
        context: context, // Pass this explicitly only if necessary
      );
      if(response.data["status"] == true){
        notificationModel = NotificationSingleModel.fromJson(response.data['item']);
        isGetNotificationSuccess = true;
        isGetNotificationLoading = false;
        notifyListeners();
      }
    } catch (error) {
      getNotificationErrorMessage = error is DioError
          ? error.response?.data['message'] ?? 'Something went wrong'
          : error.toString();
    } finally {
      isGetNotificationLoading = false;
      notifyListeners();
    }
  }
}
