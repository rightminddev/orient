import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../general_services/alert_service/alerts.service.dart';

class AddRewardAndPenaltyViewModel extends ChangeNotifier {
  // days || hours || amount
  List<Map<String, dynamic>> categories = [
    {
      'type': 'days',
      'name': 'Days',
    },
    {
      'type': 'hours',
      'name': 'Hours',
    },
    {
      'type': 'amount',
      'name': 'Amount',
    },
  ];
  Map<String, dynamic>? selectedCategory;
  // penalty || reward
  List<Map<String, dynamic>> types = [
    {
      'type': 'penalty',
      'name': 'Penalty',
    },
    {
      'type': 'reward',
      'name': 'Reward',
    },
  ];
  Map<String, dynamic>? selectedType;
  TextEditingController selectedDatecontroller = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  DateTime? selectedDate;

  void initializeAddRewardAndPenaltyScreen({required BuildContext context}) {
    _resetValues();
    notifyListeners();
  }

  @override
  void dispose() {
    selectedDatecontroller.dispose();
    reasonController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void _resetValues() {
    selectedType = null;
    selectedDatecontroller = TextEditingController();
    reasonController = TextEditingController();
    amountController = TextEditingController();
    selectedDate = null;
  }

  Future<void> selectDate(BuildContext context) async {
    final String? type = selectedType?['type'];
    if (type == null || type.isEmpty) {
      AlertsService.info(
          context: context,
          message: 'please Select First Type',
          title: 'Information');
      return;
    }
    await _selectDate(context);
    if (selectedDate == null) {
      AlertsService.warning(
          context: context,
          message: 'please select the Date again !',
          title: 'Warning');
      return;
    }
    selectedDatecontroller.text = formatDateTimeRange(selectedDate!);
    notifyListeners();
  }

  /// USED WHEN THE DURATION TYPE IN THE SELECTED REQUEST IS DAYS
  Future<void> _selectDate(BuildContext context) async {
    final newDateRange = await showDatePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDate: DateTime.now());
    if (newDateRange == null) return;
    selectedDate = newDateRange;
  }

  String formatDateTimeRange(DateTime date) {
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
    return dateFormatter.format(date);
  }

  Future<void> createRewardAndPenalty({required BuildContext context}) async {
    try {
      // First Validate on the main data
      if (selectedType == null || (selectedType?.isEmpty ?? true)) {
        AlertsService.info(
            context: context,
            message: 'Please Select Type',
            title: 'Information');
        return;
      }
      if (selectedDate == null) {
        AlertsService.info(
            context: context,
            message: 'Please Select Request Date',
            title: 'Information');
        return;
      }
      if (reasonController.text.isEmpty || reasonController.text.length < 20) {
        AlertsService.info(
            context: context,
            message: 'Please Enter Reason with at least 20 characters',
            title: 'Information');
        return;
      }
      // Finally, send Request to server create new request
      // final requestMainData = {
      //   "type": selectedType?['type'],
      //   "amount": amountController.text,
      //   "category": selectedCategory?['type'],
      //   "reason": reasonController.text,
      //   "employee_id": "1",
      //   "due_date": selectedDatecontroller.text
      // };

      // OperationResult<Map<String, dynamic>> result;

      // if (result.success) {
      //   await AlertsService.success(
      //       context: context,
      //       title: 'Success!',
      //       message: result.message ?? 'New Request Created Successfully');
      //   _resetValues();
      //   notifyListeners();
      //   return;
      // } else {
      //   await AlertsService.error(
      //       context: context,
      //       title: 'Error',
      //       message: result.message ?? 'Failed to create new request');
      //   return;
      // }
    } catch (ex, t) {
      debugPrint(
          'Error creating new Penalty Or Reward ${ex.toString()} at :- ${t.toString()}');
      await AlertsService.error(
          context: context,
          title: 'Error',
          message: 'Failed to create Penalty Or Reward ${ex.toString()}');
      return;
    }
  }
}
