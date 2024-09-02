import 'package:flutter/material.dart';
import '../../../models/notification.model.dart';
import '../../../services/crud_operation.service.dart';

class NotificationViewModel extends ChangeNotifier {
  List<NotificationModel>? notifications;
  bool isLoading = true;
  void updateLoadingStatus({required bool laodingValue}) {
    isLoading = laodingValue;
    notifyListeners();
  }

  Future<void> initializeNotificationScreen(BuildContext context) async {
    updateLoadingStatus(laodingValue: true);
    await _getUserNotification(context);
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> _getUserNotification(BuildContext context) async {
    // get user notification
    try {
      final result = (await CrudOperationService.readEntities(
        context: context,
        slug: 'rmnotifications',
        queryParams: {
          'page': 1,
          // 'with': 'cate',
          // 'trash': 1,
          // 'scope': 'filter',
        },
      ));
      if (result.success && result.data != null) {
        var notificationData = result.data?['data'] as List<dynamic>?;
        notifications = notificationData
            ?.map((item) =>
                NotificationModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    } catch (err, t) {
      debugPrint(
          "error while getting user notification ${err.toString()} at :- $t");
    }
  }
}
