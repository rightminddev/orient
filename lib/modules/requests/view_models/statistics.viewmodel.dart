import 'package:flutter/material.dart';
import '../../../models/request.model.dart';
import '../../../services/requests.services.dart';

class StatisticsViewModel extends ChangeNotifier {
  List<RequestModel>? requestsById;
  Future<void> getRequestByTypeIdAndEmpId(
      {required BuildContext context,
      required String requestTypeId,
      required GetRequestsTypes type}) async {
    // get Request by type id
    try {
      final result =
          await RequestsServices.getRequestsByTypeDependsOnUserPrivileges(
        context: context,
        reqType: type,
        requestTypeId: requestTypeId,
      );
      if (result.success && result.data != null) {
        var requestsData = result.data?['requests'] as List<dynamic>?;
        requestsById = requestsData
            ?.map((item) => RequestModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    } catch (err, t) {
      debugPrint(
          "error while getting Request by type id ${err.toString()} at :- $t");
    }
  }
}
