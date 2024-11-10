import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';

class NotificationProviderModel extends ChangeNotifier {
  bool isGetNotificationLoading = false;
  bool isGetNotificationSuccess = false;
  bool hasMoreNotifications = true; // Track if there are more notifications to load
  String? getNotificationErrorMessage;
  List notifications = [];
  int currentPage = 1;  // Start with the first page
  final int itemsCount = 9; // Number of items per page

  Future<void> getNotification(BuildContext context) async {
    if (isGetNotificationLoading || !hasMoreNotifications) return;

    isGetNotificationLoading = true;
    notifyListeners();

    try {
      final response = await DioHelper.getData(
        url: "/rmnotifications/entities-operations",
        context: context,
        query: {
          "itemsCount": itemsCount,
          "page": currentPage,
        },
      );
      final List newNotifications = response.data['data'];
      if (newNotifications.isEmpty) {
        hasMoreNotifications = false;
      } else {
        notifications.addAll(newNotifications);
        currentPage++;
      }
      isGetNotificationLoading = false;
      isGetNotificationSuccess = true;
      notifyListeners();
    } catch (error) {
      if (error is DioError) {
        getNotificationErrorMessage = error.response?.data['message'] ?? 'Something went wrong';
      } else {
        getNotificationErrorMessage = error.toString();
      }
      isGetNotificationLoading = false;
      notifyListeners();
    }
  }
}

