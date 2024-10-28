import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../general_services/app_config.service.dart';
import '../../../general_services/birthday_checker.service.dart';
import '../../../general_services/settings.service.dart';
import '../../../models/notification.model.dart';
import '../../../models/request.model.dart';
import '../../../models/settings/user_settings.model.dart';
import '../../../models/settings/user_settings_2.model.dart';
import '../../../services/crud_operation.service.dart';
import '../../../services/requests.services.dart';

class HomeViewModel extends ChangeNotifier {
  UserSettingsModel? userSettings;
  UserSettings2Model? userSettings2;
  List<RequestModel>? myRequests;
  List<RequestModel>? myTeamRequests;
  List<RequestModel>? allCompanyRequests;
  List<RequestModel>? otherDepartmentRequests;
  List<NotificationModel>? notifications;
  final ScrollController homeScrollController = ScrollController();
  bool isLoading = true;
  @override
  void dispose() {
    homeScrollController.dispose();
    super.dispose();
  }

  void updateLoadingStatus({required bool laodingValue}) {
    isLoading = laodingValue;
    notifyListeners();
  }

  Future<void> initializeHomeScreen(BuildContext context) async {
    updateLoadingStatus(laodingValue: true);
    final appConfigServiceProvider =
        Provider.of<AppConfigService>(context, listen: false);
    if (appConfigServiceProvider.isLogin != true ||
        appConfigServiceProvider.token.isEmpty) {
      return;
    }
    // initialize [userSettings] and [userSettings2] after chackings about token
    await AppSettingsService.getUserSettingsAndUpdateTheStoredSettings(
        allData: true, context: context);
    if (!context.mounted) return;
    userSettings = AppSettingsService.getSettings(
        settingsType: SettingsType.userSettings,
        context: context) as UserSettingsModel;
    userSettings2 = AppSettingsService.getSettings(
        settingsType: SettingsType.user2Settings,
        context: context) as UserSettings2Model;
    // get user requests
    //await _getAllUserRequests(context);
    await _getUserNotification(context);
    // Checking for user BirthDate
    try {
      final userBirthDate = userSettings?.birthDate;
      if (userBirthDate != null) {
        // intialize Birthday Service Checker
        BirthdayChecker.checkBirthday(
            context: context,
            birthDate: ((AppSettingsService.getSettings(
                    settingsType: SettingsType.userSettings,
                    context: context)) as UserSettingsModel)
                .birthDate);
      }
    } catch (err, t) {
      debugPrint("error while checking on user birthday $err at :- $t");
    }
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> _getAllUserRequests(BuildContext context) async {
    // get my Requests (all users)
    try {
      final result =
          (await RequestsServices.getRequestsByTypeDependsOnUserPrivileges(
              page: 1, context: context, reqType: GetRequestsTypes.mine));
      if (result.success &&
          result.data != null &&
          result.data?.isNotEmpty == true) {
        var requestsData = result.data?['requests'] as List<dynamic>?;
        myRequests = requestsData
            ?.map((item) => RequestModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    } catch (err, t) {
      debugPrint("error while getting my requests ${err.toString()} at :- $t");
    }

    // get team request and other department requests if i manager (Manager || team leader)
    if ((userSettings?.isManagerIn != null &&
            (userSettings?.isManagerIn?.isNotEmpty ?? false)) ||
        (userSettings?.isTeamleaderIn != null &&
            (userSettings?.isTeamleaderIn?.isNotEmpty ?? false))) {
      // get my Team Requests
      try {
        final result =
            (await RequestsServices.getRequestsByTypeDependsOnUserPrivileges(
                context: context, reqType: GetRequestsTypes.myTeam, page: 1));
        if (result.success &&
            result.data != null &&
            result.data?.isNotEmpty == true) {
          var requestsData = result.data?['requests'] as List<dynamic>?;
          myTeamRequests = requestsData
              ?.map(
                  (item) => RequestModel.fromJson(item as Map<String, dynamic>))
              .toList();
        }
      } catch (err, t) {
        debugPrint(
            "error while getting my Team requests ${err.toString()} at :- $t");
      }
      // get other Department Requests
      try {
        final result =
            (await RequestsServices.getRequestsByTypeDependsOnUserPrivileges(
                context: context,
                reqType: GetRequestsTypes.otherDepartment,
                page: 1));
        if (result.success &&
            result.data != null &&
            result.data?.isNotEmpty == true) {
          var requestsData = result.data?['requests'] as List<dynamic>?;
          otherDepartmentRequests = requestsData
              ?.map(
                  (item) => RequestModel.fromJson(item as Map<String, dynamic>))
              .toList();
        }
      } catch (err, t) {
        debugPrint(
            "error while getting other Departments requests ${err.toString()} at :- $t");
      }
    }

    // get all Company Requests
    if (userSettings?.topManagement == true) {
      try {
        final result =
            (await RequestsServices.getRequestsByTypeDependsOnUserPrivileges(
                context: context, reqType: GetRequestsTypes.allCompany));
        if (result.success &&
            result.data != null &&
            result.data?.isNotEmpty == true) {
          var requestsData = result.data?['requests'] as List<dynamic>?;
          allCompanyRequests = requestsData
              ?.map(
                  (item) => RequestModel.fromJson(item as Map<String, dynamic>))
              .toList();
        }
      } catch (err, t) {
        debugPrint(
            "error while getting all company requests ${err.toString()} at :- $t");
      }
    }
    notifyListeners();
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
