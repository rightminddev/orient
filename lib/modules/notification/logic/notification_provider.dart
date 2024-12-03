import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';

class NotificationProviderModel extends ChangeNotifier {
  bool isGetNotificationLoading = false;
  bool isGetNotificationSuccess = false;
  bool hasMoreNotifications = true; // Track if there are more notifications to load
  String? getNotificationErrorMessage;
  List notifications = [];
  List newNotifications = [];
  int currentPage = 1;
  final int itemsCount = 9;

  Future<void> getNotification(BuildContext context, {int? page}) async {
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
      if (newNotifications.isNotEmpty) {
        notifications.addAll(newNotifications);
        currentPage++;
      } else {
        hasMoreNotifications = false; // No more data to fetch
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
}
