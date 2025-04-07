import 'package:flutter/material.dart';
import '../../../general_services/settings.service.dart';
import '../../../models/request.model.dart';
import '../../../models/settings/user_settings_2.model.dart';
import '../../../services/requests.services.dart';

class RequestsViewModel extends ChangeNotifier {
  bool isLoading = true;
  List<RequestModel>? requests;
  UserSettings2Model? userSettings2;

  Future<void> initializeRequestsScreen(
      {required BuildContext context,
      required GetRequestsTypes requestsType}) async {
    updateLoadingStatus(laodingValue: true);
    userSettings2 = AppSettingsService.getSettings(
        settingsType: SettingsType.user2Settings,
        context: context) as UserSettings2Model;
    await _getAllUserRequests(context: context, requestType: requestsType);
    updateLoadingStatus(laodingValue: false);
  }

  void updateLoadingStatus({required bool laodingValue}) {
    isLoading = laodingValue;
    notifyListeners();
  }

  Future<void> _getAllUserRequests(
      {required BuildContext context,
      required GetRequestsTypes requestType}) async {
    // get my Requests (all users)
    try {
      final result =
          (await RequestsServices.getRequestsByTypeDependsOnUserPrivileges(
              page: 1, context: context, reqType: requestType));
      if (result.success &&
          result.data != null &&
          result.data?.isNotEmpty == true) {
        var requestsData = result.data?['requests'] as List<dynamic>?;
        requests = requestsData
            ?.map((item) => RequestModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    } catch (err, t) {
      debugPrint("error while getting Rquests ${err.toString()} at :- $t");
    }
  }

  String getRequestsScreenTitleDependsOnRequestsType(
      {required GetRequestsTypes requestsType}) {
    switch (requestsType) {
      case GetRequestsTypes.allCompany:
        return 'ALL COMPANY REQUESTS';
      case GetRequestsTypes.myTeam:
        return 'MY TEAM REQUESTS';
      case GetRequestsTypes.otherDepartment:
        return 'OTHER DEPARTMENTS REQUESTS';
      default:
        return 'MY REQUESTS';
    }
  }
}
