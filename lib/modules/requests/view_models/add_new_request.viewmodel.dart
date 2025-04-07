import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../general_services/alert_service/alerts.service.dart';
import '../../../general_services/date.service.dart';
import '../../../general_services/image_file_picker.service.dart';
import '../../../general_services/settings.service.dart';
import '../../../models/operation_result.model.dart';
import '../../../models/settings/general_settings.model.dart';
import '../../../models/settings/user_settings_2.model.dart';
import '../../../routing/app_router.dart';
import '../../../services/requests.services.dart';

class AddNewRequestViewModel extends ChangeNotifier {
  Map<String, dynamic>? selectedRequestType;
  List<Map<String, dynamic>>? requestsTypes;
  TextEditingController controller = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController fileController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  FilePickerResult? attachedFile;
  DateTimeRange? selectedDateOrDatetimeRange;
  num? duration;
  String? notes;

  void initializeAddNewRequestScreen({required BuildContext context}) {
    // Initialize your request types here
    _resetValues();
    _getRequestTypes(context: context);
    notifyListeners();
  }

  @override
  void dispose() {
    controller.dispose();
    reasonController.dispose();
    fileController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void _resetValues() {
    selectedRequestType = null;
    requestsTypes = null;
    controller = TextEditingController();
    reasonController = TextEditingController();
    fileController = TextEditingController();
    amountController = TextEditingController();
    attachedFile = null;
    selectedDateOrDatetimeRange = null;
    duration = null;
    notes = null;
  }

  /// USED WHEN THE DURATION TYPE IN OFFICAIL HOLIDAYS
  Future<void> selectInsteadOfHolidays(BuildContext context,
      {required String? startDateOrDatetime,
      required String? endDateOrDatetime}) async {
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
    final DateFormat dateTimeFormatter = DateFormat('yyyy-MM-dd HH:mm');
    if (startDateOrDatetime == null || endDateOrDatetime == null) {
      AlertsService.warning(
          context: context,
          message: 'please select offical holiday again !',
          title: 'Warning');
      return;
    }
    DateTime start;
    DateTime end;
    bool containsTime =
        startDateOrDatetime.contains(' ') || endDateOrDatetime.contains(' ');

    if (containsTime) {
      // Parse date and time
      start = dateTimeFormatter.parse(startDateOrDatetime);
      end = dateTimeFormatter.parse(endDateOrDatetime);
    } else {
      // Parse date only
      start = dateFormatter.parse(startDateOrDatetime);
      end = dateFormatter.parse(endDateOrDatetime);
    }

    selectedDateOrDatetimeRange = DateTimeRange(start: start, end: end);
    return;
  }

  Future<void> selectDate(BuildContext context) async {
    final String? type = selectedRequestType?['type'];
    if (type == null || type.isEmpty) {
      AlertsService.info(
          context: context,
          message: 'please Select First Request Type',
          title: 'Information');
      return;
    }
    // check if the type is days then show the date range picker
    if (type.toLowerCase().trim() == 'days') {
      await _selectDateRange(context);
    }
    // check if the type is hours then show date time picker
    else if (type.toLowerCase().trim() == 'hours' ||
        type.toLowerCase().trim() == 'minutes') {
      await _selectDateTimeRange(context);
    }
    // check if the type is instead of holidays then thow list of official holidays to choose from
    else {
      AlertsService.warning(
          context: context,
          message: 'Could not get the request time type, please try later',
          title: 'Warning');
      return;
    }
    if (selectedDateOrDatetimeRange == null) {
      AlertsService.warning(
          context: context,
          message: 'please select request Duration again !',
          title: 'Warning');
      return;
    }
    controller.text = formatDateTimeRange(selectedDateOrDatetimeRange!);
    _calcDuration(context: context);
    notifyListeners();
  }

  /// USED WHEN THE DURATION TYPE IN THE SELECTED REQUEST IS DAYS
  Future<void> _selectDateRange(BuildContext context) async {
    final newDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDateRange: selectedDateOrDatetimeRange);
    if (newDateRange == null) return;
    selectedDateOrDatetimeRange = newDateRange;
  }

  /// USED WHEN THE DURATION TYPE IN THE SELECTED REQUEST IS (HOURS OR MINUTES)
  Future<void> _selectDateTimeRange(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      // Show time picker for start time
      final TimeOfDay? pickedStartTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      // Show time picker for end time
      final TimeOfDay? pickedEndTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedStartTime != null && pickedEndTime != null) {
        selectedDateOrDatetimeRange = DateTimeRange(
          start: DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedStartTime.hour,
            pickedStartTime.minute,
          ),
          end: DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedEndTime.hour,
            pickedEndTime.minute,
          ),
        );
      }
    }
  }

  /// USED TO GET FORMATED STRING FROM THE SELECTED DATE || DATETIME
  String formatDateTimeRange(DateTimeRange range) {
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
    final DateFormat dateTimeFormatter = DateFormat('yyyy-MM-dd HH:mm');

    String startDateStr = dateFormatter.format(range.start);
    String endDateStr = dateFormatter.format(range.end);

    bool hasStartTime = range.start.hour != 0 || range.start.minute != 0;
    bool hasEndTime = range.end.hour != 0 || range.end.minute != 0;

    if (hasStartTime || hasEndTime) {
      // Include time if either start or end time is non-zero
      String startDateTimeStr = dateTimeFormatter.format(range.start);
      String endDateTimeStr = dateTimeFormatter.format(range.end);
      return '$startDateTimeStr : $endDateTimeStr';
    } else {
      // Only include date if no time is specified
      return '$startDateStr : $endDateStr';
    }
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FileAndImagePickerService.pickFile();
    if (result != null) {
      attachedFile = result;
      fileController.text = result.files.single.name;
    }
    notifyListeners();
  }

  void _getRequestTypes({required BuildContext context}) {
    try {
      // Fetch user2Settings data from app settings
      final user2SettingsData = AppSettingsService.getSettings(
          settingsType: SettingsType.user2Settings,
          context: context) as UserSettings2Model?;

      // Fetch generalSettings data from app settings
      final generalSettingsData = AppSettingsService.getSettings(
          settingsType: SettingsType.generalSettings,
          context: context) as GeneralSettingsModel?;

      // get user balance from User2Settings
      final userBalance = user2SettingsData?.balance;
      // check if the user balance is null || empty then there is no requests types
      if (userBalance == null || userBalance.isEmpty) {
        requestsTypes = [];
        return;
      }
      // Fetch request types from generalSettings and if there is no request types in generalSettings then return requests types with empty list
      final requestsTypesDataFromGeneralSettings =
          generalSettingsData?.requestTypes;
      if (requestsTypesDataFromGeneralSettings == null ||
          requestsTypesDataFromGeneralSettings.isEmpty) {
        requestsTypes = [];
        return;
      }

      // looping on user balance to get the available requests types with considering the the balance and it can be listed or not
      userBalance.forEach((requestId, val) {
        final userBalanceRequestType = userBalance[requestId];
        final max = userBalanceRequestType?.max;
        if (max != null &&
            requestsTypesDataFromGeneralSettings.containsKey(requestId)) {
          if (max == -1 || ((userBalanceRequestType?.take ?? 0) < max)) {
            requestsTypes ??= [];
            requestsTypes!.add((requestsTypesDataFromGeneralSettings[requestId]
                ?.toJson() as Map<String, dynamic>));
          }
        }
      });
      return;
    } catch (ex, t) {
      debugPrint(
          'Error getting request types ${ex.toString()} at :- ${t.toString()}');
      requestsTypes = [];
    }
  }

  Map<String, String> _filterNonNullValues(Map<String, String?> map) {
    final filteredMap = <String, String>{};
    for (var entry in map.entries) {
      if (entry.value != null) {
        filteredMap[entry.key] = entry.value!;
      }
    }
    return filteredMap;
  }

  void _calcDuration({required BuildContext context}) {
    if (selectedDateOrDatetimeRange == null) {
      duration = 0;
      return;
    }
    final String? type = selectedRequestType?['type'];
    // check if the type is days then duration will be in days
    if (type?.toLowerCase().trim() == 'days') {
      _getDateDifferenceWithoutWeekendsAndOfficailHolidays(context: context);
      return;
    }
    // check if the type is hours then duration will be in hours
    else if (type?.toLowerCase().trim() == 'hours' ||
        type?.toLowerCase().trim() == 'minutes') {
      _getHoursDifference(context: context);
      return;
    }
  }

  void _getHoursDifference({required BuildContext context}) {
    duration = (selectedDateOrDatetimeRange?.duration.inHours ?? 0) + 1;
    notifyListeners();
  }

  void _getDateDifferenceWithoutWeekendsAndOfficailHolidays(
      {required BuildContext context}) {
    final generalSettings = AppSettingsService.getSettings(
        settingsType: SettingsType.generalSettings,
        context: context) as GeneralSettingsModel;
    final user2Settigns = AppSettingsService.getSettings(
        settingsType: SettingsType.user2Settings,
        context: context) as UserSettings2Model;

    int nbDays = 0;
    final List<HolidayOrString>? holidays = generalSettings.holidays;
    List<int> weekendDays = [];
    List<String> weekendDaysNames = [];
    Map<int, String> weekdaysMap = {
      1: 'monday',
      2: 'tuesday',
      3: 'wednesday',
      4: 'thursday',
      5: 'friday',
      6: 'saturday',
      7: 'sunday',
    };

    // First: Subtracting Weekends if the Current user not Variable [means that the current user follows the weekend system]
    if (user2Settigns.weekend?.contains('variable') == false) {
      DateTime currentDay = selectedDateOrDatetimeRange!.start;
      while (currentDay.isBefore(
          selectedDateOrDatetimeRange!.end.add(const Duration(days: 1)))) {
        int dayOfWeek = currentDay.weekday;

        // Check if the current day is a weekend day
        final weekendDaysList = user2Settigns.weekend;
        if (weekendDaysList != null &&
            weekendDaysList.contains(weekdaysMap[dayOfWeek])) {
          nbDays++;
          weekendDays.add(dayOfWeek);
        }
        currentDay = currentDay.add(const Duration(days: 1));
      }

      // Calculate the duration after subtracting weekends
      duration =
          ((selectedDateOrDatetimeRange?.duration.inDays ?? 0) + 1) - nbDays;

      // Convert weekend days from integer to week day names
      for (var element in weekendDays) {
        if (weekdaysMap.containsKey(element)) {
          weekendDaysNames.add(weekdaysMap[element]!);
        }
      }

      notes = nbDays != 0
          ? 'New Request Subtracting ${weekendDaysNames.length} as the Weekends Days'
          : null;
    }

    debugPrint(
        '1- duration after subtracting weekends |||||||||||||||||| $duration');

    // Second: Subtracting Holidays if the Current user can use holidays
    if (user2Settigns.canUseHolidays == true && holidays != null) {
      int holidayDays = 0;

      for (var holidayOrString in holidays) {
        if (holidayOrString.holiday != null) {
          DateTime holidayStart =
              DateTime.parse(holidayOrString.holiday!.from!);
          DateTime holidayEnd = DateTime.parse(holidayOrString.holiday!.to!);

          DateTime currentDay = selectedDateOrDatetimeRange!.start;
          while (currentDay.isBefore(
              selectedDateOrDatetimeRange!.end.add(const Duration(days: 1)))) {
            if (currentDay
                    .isAfter(holidayStart.subtract(const Duration(days: 1))) &&
                currentDay.isBefore(holidayEnd.add(const Duration(days: 1))) &&
                !weekendDays.contains(currentDay.weekday)) {
              holidayDays++;
            }
            currentDay = currentDay.add(const Duration(days: 1));
          }
        }
      }

      duration = (duration ?? 0) - holidayDays;
      if ((duration ?? 0) < 0) duration = 0;
      if (holidayDays != 0) {
        notes =
            '${notes ?? ''} \n New Request Subtracting $holidayDays as the Official Holidays';
      }
    }

    debugPrint(
        '2- duration after subtracting holidays |||||||||||||||||| $duration');
    notifyListeners();
  }

  String getHoursOrDayesStringDependsOnRequestType() {
    if (selectedRequestType == null) return '';
    return (selectedRequestType?['type'] as String?)?.trim().toLowerCase() ==
            'days'
        ? 'Days'
        : 'Hours';
  }

  Future<void> createNewRequest({required BuildContext context}) async {
    try {
      // First Validate on the main data
      if (selectedRequestType == null ||
          (selectedRequestType?.isEmpty ?? true)) {
        AlertsService.info(
            context: context,
            message: 'Please Select Request Type',
            title: 'Information');
        return;
      }
      if (selectedDateOrDatetimeRange == null) {
        AlertsService.info(
            context: context,
            message: 'Please Select Request Duration',
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

      // Second Validate on the optional data
      final attachingFile =
          (selectedRequestType?['fields']?['attaching_file'] as String?)
              ?.toLowerCase()
              .trim();
      final isAttachingFile = attachingFile == 'active' ||
          attachingFile == 'required' ||
          attachingFile == 'optional';
      if (isAttachingFile && attachedFile == null) {
        AlertsService.info(
            context: context,
            message: 'Please Attach File',
            title: 'Information');
        return;
      }
      final moneyValue =
          (selectedRequestType?['fields']?['money_value'] as String?)
              ?.toLowerCase()
              .trim();
      final isMoneyValue = moneyValue == 'active' ||
          moneyValue == 'required' ||
          moneyValue == 'optional';
      if (isMoneyValue && amountController.text.isEmpty) {
        AlertsService.info(
            context: context,
            message: 'Please Enter Amount',
            title: 'Information');
        return;
      }
      // Finally, send Request to server create new request
      final requestMainData = {
        'emp_request_type_id': selectedRequestType?['id'].toString(),
        'date_from': DateService.formateDateTimeBeforeSendToServer(
            dateTime: selectedDateOrDatetimeRange!.start),
        'date_to': DateService.formateDateTimeBeforeSendToServer(
            dateTime: selectedDateOrDatetimeRange!.end),
        'duration': duration.toString(),
        'reason': reasonController.text,
      };
      if (isMoneyValue) {
        requestMainData['money_value'] = amountController.text;
      }

      final OperationResult<Map<String, dynamic>> result;
      // using form data request to the server
      result = await RequestsServices.createNewRequestWithFile(
          context: context,
          requestData: _filterNonNullValues(requestMainData),
          files:
              (isAttachingFile && attachedFile != null) ? [attachedFile!] : []);

      if (result.success) {
        await AlertsService.success(
            context: context,
            title: 'Success!',
            message: result.message ?? 'New Request Created Successfully');
        _resetValues();
        notifyListeners();
        context.goNamed(AppRoutes.requests.name, pathParameters: {
          'type': 'mine',
          'lang': context.locale.languageCode
        });
        return;
      } else {
        if (result.data?['duration'] != null &&
            result.data?['duration'] != '') {
          bool resendRequestWithTheCorrectDuration =
              await AlertsService.confirmMessage(context, '${result.message}',
                  message:
                      'Do you want to resend your request with the Correct Duration is ${result.data?['duration']} ${getHoursOrDayesStringDependsOnRequestType()} ?');
          if (resendRequestWithTheCorrectDuration) {
            requestMainData['duration'] = result.data?['duration'].toString();
            final resendRequestResult =
                await RequestsServices.createNewRequestWithFile(
                    context: context,
                    requestData: _filterNonNullValues(requestMainData),
                    files: (isAttachingFile && attachedFile != null)
                        ? [attachedFile!]
                        : []);
            if (resendRequestResult.success) {
              await AlertsService.success(
                  context: context,
                  title: 'Success!',
                  message: resendRequestResult.message ??
                      'New Request Created Successfully');
              _resetValues();
              notifyListeners();
              context.goNamed(AppRoutes.requests.name, pathParameters: {
                'type': 'mine',
                'lang': context.locale.languageCode
              });
              return;
            } else {
              await AlertsService.error(
                  context: context,
                  title: 'Error',
                  message: resendRequestResult.message ??
                      'Failed to create new request');
              return;
            }
          }
          return;
        } else {
          await AlertsService.error(
              context: context,
              title: 'Error',
              message: result.message ?? 'Failed to create new request');
          return;
        }
      }
    } catch (ex, t) {
      debugPrint(
          'Error creating new request ${ex.toString()} at :- ${t.toString()}');
      await AlertsService.error(
          context: context,
          title: 'Error',
          message: 'Failed to create new request ${ex.toString()}');
      return;
    }
  }
}
