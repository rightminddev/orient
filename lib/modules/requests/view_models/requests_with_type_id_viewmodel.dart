import 'package:flutter/material.dart';
import '../../../general_services/layout.service.dart';
import '../../../models/request.model.dart';
import '../../../services/requests.services.dart';
import '../../../utils/modal_sheet_helper.dart';
import '../models/summary_report.model.dart';
import '../views/widgets/modals/summary_reports.modal.dart';

class RequestsWithTypeIdViewModel extends ChangeNotifier {
  bool isLoading = true;
  List<RequestModel>? requestsById;
  List<SummaryReportModel>? summaryReports;

  Future<void> initializeRequestScreenByTypeIdgetRequestsByTypeId(
      {required BuildContext context,
      required String requestTypeId,
      String? employeeId}) async {
    updateLoadingStatus(laodingValue: true);
    await _getRequestByTypeId(
        context: context, requestTypeId: requestTypeId, employeeId: employeeId);
    if (employeeId == null) {
      await _getSumaryReports(context: context, requestTypeId: requestTypeId);
    }
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> showSummaryReports({required BuildContext context}) async {
    if (summaryReports == null || summaryReports?.isEmpty == true) return;
    await ModalSheetHelper.showModalSheet(
        context: context,
        height: (LayoutService.getHeight(context) * 0.5),
        modalContent: SummaryReportsModal(summaryReports: summaryReports!),
        title: 'Summary Report');
  }

  Future<void> _getSumaryReports(
      {required BuildContext context, required String requestTypeId}) async {
    try {
      final result = await RequestsServices.getSummaryReports(
          context: context, requestTypeId: requestTypeId);
      if (result.success && result.data != null) {
        var summaryReportsData = result.data as List<dynamic>;
        summaryReports = summaryReportsData
            .map((item) =>
                SummaryReportModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    } catch (err, t) {
      debugPrint(
          "error while getting Summary Reports by type id ${err.toString()} at :- $t");
    }
  }

  Future<void> _getRequestByTypeId(
      {required BuildContext context,
      required String requestTypeId,
      String? employeeId}) async {
    // get Request by type id
    try {
      final result =
          await RequestsServices.getRequestsByTypeDependsOnUserPrivileges(
              context: context,
              reqType: GetRequestsTypes.mine,
              requestTypeId: requestTypeId,
              empIds: employeeId != null ? [employeeId] : null);
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

  void updateLoadingStatus({required bool laodingValue}) {
    isLoading = laodingValue;
    notifyListeners();
  }
}
