import 'package:collection/collection.dart';

class DepartmentModel {
  final int? id;
  final String? title;
  final List<Manager>? departmentManagers;
  final List<Permission>? departmentManagersPermission;
  final List<Manager>? departmentTeamleaders;
  final List<Permission>? departmentTeamleadersPermission;
  final List<MustTogether>? mustTogether;
  final String? fpScan;
  final List<Location>? fpScanLocations;
  final String? fpNavigate;
  final List<Location>? fpNavigateLocations;
  final String? fpWifi;
  final List<Location>? fpWifiLocations;
  final String? fpBluetooth;
  final List<Location>? fpBluetoothLocations;
  final double? payrollOvertimeRate;
  final int? payrollVacationWithoutRequest;
  final int? payrollVacationWithoutPay;
  final List<LateAttendance>? payrollLateAttendance;
  final Activate? empPublicHolidaysActivate;
  final List<dynamic>? weekend;
  final WorkingHoursType? workingHoursType;
  final double? dailyWorkingHours;
  final double? allowedDelayMinutes;
  final String? workingHoursFrom;
  final String? workingHoursTo;
  final String? workingHoursFromStart;
  final String? workingHoursFromEnd;
  final List<RequestType>? requestTypes;
  final Status? status;
  final String? scheduleDate;
  final ActionLinks? action;

  DepartmentModel({
    this.id,
    this.title,
    this.departmentManagers,
    this.departmentManagersPermission,
    this.departmentTeamleaders,
    this.departmentTeamleadersPermission,
    this.mustTogether,
    this.fpScan,
    this.fpScanLocations,
    this.fpNavigate,
    this.fpNavigateLocations,
    this.fpWifi,
    this.fpWifiLocations,
    this.fpBluetooth,
    this.fpBluetoothLocations,
    this.payrollOvertimeRate,
    this.payrollVacationWithoutRequest,
    this.payrollVacationWithoutPay,
    this.payrollLateAttendance,
    this.empPublicHolidaysActivate,
    this.weekend,
    this.workingHoursType,
    this.dailyWorkingHours,
    this.allowedDelayMinutes,
    this.workingHoursFrom,
    this.workingHoursTo,
    this.workingHoursFromStart,
    this.workingHoursFromEnd,
    this.requestTypes,
    this.status,
    this.scheduleDate,
    this.action,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      title: json['title'] as String?,
      departmentManagers: (json['department_managers'] as List<dynamic>?)
          ?.map((e) => Manager.fromJson(e as Map<String, dynamic>))
          .toList(),
      departmentManagersPermission:
          (json['department_managers_permission'] as List<dynamic>?)
              ?.map((e) => Permission.fromJson(e as Map<String, dynamic>))
              .toList(),
      departmentTeamleaders: (json['department_teamleaders'] as List<dynamic>?)
          ?.map((e) => Manager.fromJson(e as Map<String, dynamic>))
          .toList(),
      departmentTeamleadersPermission:
          (json['department_teamleaders_permission'] as List<dynamic>?)
              ?.map((e) => Permission.fromJson(e as Map<String, dynamic>))
              .toList(),
      mustTogether: (json['must_together'] as List<dynamic>?)
          ?.map((e) => MustTogether.fromJson(e as Map<String, dynamic>))
          .toList(),
      fpScan: json['fp_scan'] as String?,
      fpScanLocations: (json['fp_scan_locations'] as List<dynamic>?)
          ?.map((e) => Location.fromJson(e as Map<String, dynamic>))
          .toList(),
      fpNavigate: json['fp_navigate'] as String?,
      fpNavigateLocations: (json['fp_navigate_locations'] as List<dynamic>?)
          ?.map((e) => Location.fromJson(e as Map<String, dynamic>))
          .toList(),
      fpWifi: json['fp_wifi'] as String?,
      fpWifiLocations: (json['fp_wifi_locations'] as List<dynamic>?)
          ?.map((e) => Location.fromJson(e as Map<String, dynamic>))
          .toList(),
      fpBluetooth: json['fp_bluetooth'] as String?,
      fpBluetoothLocations: (json['fp_bluetooth_locations'] as List<dynamic>?)
          ?.map((e) => Location.fromJson(e as Map<String, dynamic>))
          .toList(),
      payrollOvertimeRate: json['payroll_overtime_rate'] as double?,
      payrollVacationWithoutRequest: json['payroll_vacation_without_request'] !=
              null
          ? int.tryParse(json['payroll_vacation_without_request'].toString()) ??
              json['payroll_vacation_without_request'] as int?
          : null,
      payrollVacationWithoutPay: json['payroll_vacation_without_pay'] != null
          ? int.tryParse(json['payroll_vacation_without_pay'].toString()) ??
              json['payroll_vacation_without_pay'] as int?
          : null,
      payrollLateAttendance: (json['payroll_late_attendance'] as List<dynamic>?)
          ?.map((e) => LateAttendance.fromJson(e as Map<String, dynamic>))
          .toList(),
      empPublicHolidaysActivate: json['emp_public_holidays_activate'] != null
          ? Activate.fromJson(
              json['emp_public_holidays_activate'] as Map<String, dynamic>)
          : null,
      weekend: json['weekend'] as List<dynamic>?,
      workingHoursType: json['working_hours_type'] != null
          ? WorkingHoursType.fromJson(
              json['working_hours_type'] as Map<String, dynamic>)
          : null,
      dailyWorkingHours: json['daily_working_hours'] as double?,
      allowedDelayMinutes: json['allowed_delay_minutes'] as double?,
      workingHoursFrom: json['working_hours_from'] as String?,
      workingHoursTo: json['working_hours_to'] as String?,
      workingHoursFromStart: json['working_hours_from_start'] as String?,
      workingHoursFromEnd: json['working_hours_from_end'] as String?,
      requestTypes: (json['request_types'] as List<dynamic>?)
          ?.map((e) => RequestType.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] != null
          ? Status.fromJson(json['status'] as Map<String, dynamic>)
          : null,
      scheduleDate: json['schedule_date'] as String?,
      action: json['action'] != null
          ? ActionLinks.fromJson(json['action'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'department_managers':
          departmentManagers?.map((e) => e.toJson()).toList(),
      'department_managers_permission':
          departmentManagersPermission?.map((e) => e.toJson()).toList(),
      'department_teamleaders':
          departmentTeamleaders?.map((e) => e.toJson()).toList(),
      'department_teamleaders_permission':
          departmentTeamleadersPermission?.map((e) => e.toJson()).toList(),
      'must_together': mustTogether?.map((e) => e.toJson()).toList(),
      'fp_scan': fpScan,
      'fp_scan_locations': fpScanLocations?.map((e) => e.toJson()).toList(),
      'fp_navigate': fpNavigate,
      'fp_navigate_locations':
          fpNavigateLocations?.map((e) => e.toJson()).toList(),
      'fp_wifi': fpWifi,
      'fp_wifi_locations': fpWifiLocations?.map((e) => e.toJson()).toList(),
      'fp_bluetooth': fpBluetooth,
      'fp_bluetooth_locations':
          fpBluetoothLocations?.map((e) => e.toJson()).toList(),
      'payroll_overtime_rate': payrollOvertimeRate,
      'payroll_vacation_without_request': payrollVacationWithoutRequest,
      'payroll_vacation_without_pay': payrollVacationWithoutPay,
      'payroll_late_attendance':
          payrollLateAttendance?.map((e) => e.toJson()).toList(),
      'emp_public_holidays_activate': empPublicHolidaysActivate?.toJson(),
      'weekend': weekend,
      'working_hours_type': workingHoursType?.toJson(),
      'daily_working_hours': dailyWorkingHours,
      'allowed_delay_minutes': allowedDelayMinutes,
      'working_hours_from': workingHoursFrom,
      'working_hours_to': workingHoursTo,
      'working_hours_from_start': workingHoursFromStart,
      'working_hours_from_end': workingHoursFromEnd,
      'request_types': requestTypes?.map((e) => e.toJson()).toList(),
      'status': status?.toJson(),
      'schedule_date': scheduleDate,
      'action': action?.toJson(),
    };
  }

  DepartmentModel copyWith({
    int? id,
    String? title,
    List<Manager>? departmentManagers,
    List<Permission>? departmentManagersPermission,
    List<Manager>? departmentTeamleaders,
    List<Permission>? departmentTeamleadersPermission,
    List<MustTogether>? mustTogether,
    String? fpScan,
    List<Location>? fpScanLocations,
    String? fpNavigate,
    List<Location>? fpNavigateLocations,
    String? fpWifi,
    List<Location>? fpWifiLocations,
    String? fpBluetooth,
    List<Location>? fpBluetoothLocations,
    double? payrollOvertimeRate,
    int? payrollVacationWithoutRequest,
    int? payrollVacationWithoutPay,
    List<LateAttendance>? payrollLateAttendance,
    Activate? empPublicHolidaysActivate,
    List<dynamic>? weekend,
    WorkingHoursType? workingHoursType,
    double? dailyWorkingHours,
    double? allowedDelayMinutes,
    String? workingHoursFrom,
    String? workingHoursTo,
    String? workingHoursFromStart,
    String? workingHoursFromEnd,
    List<RequestType>? requestTypes,
    Status? status,
    String? scheduleDate,
    ActionLinks? action,
  }) {
    return DepartmentModel(
      id: id ?? this.id,
      title: title ?? this.title,
      departmentManagers: departmentManagers ?? this.departmentManagers,
      departmentManagersPermission:
          departmentManagersPermission ?? this.departmentManagersPermission,
      departmentTeamleaders:
          departmentTeamleaders ?? this.departmentTeamleaders,
      departmentTeamleadersPermission: departmentTeamleadersPermission ??
          this.departmentTeamleadersPermission,
      mustTogether: mustTogether ?? this.mustTogether,
      fpScan: fpScan ?? this.fpScan,
      fpScanLocations: fpScanLocations ?? this.fpScanLocations,
      fpNavigate: fpNavigate ?? this.fpNavigate,
      fpNavigateLocations: fpNavigateLocations ?? this.fpNavigateLocations,
      fpWifi: fpWifi ?? this.fpWifi,
      fpWifiLocations: fpWifiLocations ?? this.fpWifiLocations,
      fpBluetooth: fpBluetooth ?? this.fpBluetooth,
      fpBluetoothLocations: fpBluetoothLocations ?? this.fpBluetoothLocations,
      payrollOvertimeRate: payrollOvertimeRate ?? this.payrollOvertimeRate,
      payrollVacationWithoutRequest:
          payrollVacationWithoutRequest ?? this.payrollVacationWithoutRequest,
      payrollVacationWithoutPay:
          payrollVacationWithoutPay ?? this.payrollVacationWithoutPay,
      payrollLateAttendance:
          payrollLateAttendance ?? this.payrollLateAttendance,
      empPublicHolidaysActivate:
          empPublicHolidaysActivate ?? this.empPublicHolidaysActivate,
      weekend: weekend ?? this.weekend,
      workingHoursType: workingHoursType ?? this.workingHoursType,
      dailyWorkingHours: dailyWorkingHours ?? this.dailyWorkingHours,
      allowedDelayMinutes: allowedDelayMinutes ?? this.allowedDelayMinutes,
      workingHoursFrom: workingHoursFrom ?? this.workingHoursFrom,
      workingHoursTo: workingHoursTo ?? this.workingHoursTo,
      workingHoursFromStart:
          workingHoursFromStart ?? this.workingHoursFromStart,
      workingHoursFromEnd: workingHoursFromEnd ?? this.workingHoursFromEnd,
      requestTypes: requestTypes ?? this.requestTypes,
      status: status ?? this.status,
      scheduleDate: scheduleDate ?? this.scheduleDate,
      action: action ?? this.action,
    );
  }

  @override
  String toString() {
    return 'DepartmentModel(id: $id, title: $title, departmentManagers: $departmentManagers, departmentManagersPermission: $departmentManagersPermission, departmentTeamleaders: $departmentTeamleaders, departmentTeamleadersPermission: $departmentTeamleadersPermission, mustTogether: $mustTogether, fpScan: $fpScan, fpScanLocations: $fpScanLocations, fpNavigate: $fpNavigate, fpNavigateLocations: $fpNavigateLocations, fpWifi: $fpWifi, fpWifiLocations: $fpWifiLocations, fpBluetooth: $fpBluetooth, fpBluetoothLocations: $fpBluetoothLocations, payrollOvertimeRate: $payrollOvertimeRate, payrollVacationWithoutRequest: $payrollVacationWithoutRequest, payrollVacationWithoutPay: $payrollVacationWithoutPay, payrollLateAttendance: $payrollLateAttendance, empPublicHolidaysActivate: $empPublicHolidaysActivate, weekend: $weekend, workingHoursType: $workingHoursType, dailyWorkingHours: $dailyWorkingHours, allowedDelayMinutes: $allowedDelayMinutes, workingHoursFrom: $workingHoursFrom, workingHoursTo: $workingHoursTo, workingHoursFromStart: $workingHoursFromStart, workingHoursFromEnd: $workingHoursFromEnd, requestTypes: $requestTypes, status: $status, scheduleDate: $scheduleDate, action: $action)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DepartmentModel &&
        other.id == id &&
        other.title == title &&
        const DeepCollectionEquality()
            .equals(other.departmentManagers, departmentManagers) &&
        const DeepCollectionEquality().equals(
            other.departmentManagersPermission, departmentManagersPermission) &&
        const DeepCollectionEquality()
            .equals(other.departmentTeamleaders, departmentTeamleaders) &&
        const DeepCollectionEquality().equals(
            other.departmentTeamleadersPermission,
            departmentTeamleadersPermission) &&
        const DeepCollectionEquality()
            .equals(other.mustTogether, mustTogether) &&
        other.fpScan == fpScan &&
        const DeepCollectionEquality()
            .equals(other.fpScanLocations, fpScanLocations) &&
        other.fpNavigate == fpNavigate &&
        const DeepCollectionEquality()
            .equals(other.fpNavigateLocations, fpNavigateLocations) &&
        other.fpWifi == fpWifi &&
        const DeepCollectionEquality()
            .equals(other.fpWifiLocations, fpWifiLocations) &&
        other.fpBluetooth == fpBluetooth &&
        const DeepCollectionEquality()
            .equals(other.fpBluetoothLocations, fpBluetoothLocations) &&
        other.payrollOvertimeRate == payrollOvertimeRate &&
        other.payrollVacationWithoutRequest == payrollVacationWithoutRequest &&
        other.payrollVacationWithoutPay == payrollVacationWithoutPay &&
        const DeepCollectionEquality()
            .equals(other.payrollLateAttendance, payrollLateAttendance) &&
        other.empPublicHolidaysActivate == empPublicHolidaysActivate &&
        const DeepCollectionEquality().equals(other.weekend, weekend) &&
        other.workingHoursType == workingHoursType &&
        other.dailyWorkingHours == dailyWorkingHours &&
        other.allowedDelayMinutes == allowedDelayMinutes &&
        other.workingHoursFrom == workingHoursFrom &&
        other.workingHoursTo == workingHoursTo &&
        other.workingHoursFromStart == workingHoursFromStart &&
        other.workingHoursFromEnd == workingHoursFromEnd &&
        const DeepCollectionEquality()
            .equals(other.requestTypes, requestTypes) &&
        other.status == status &&
        other.scheduleDate == scheduleDate &&
        other.action == action;
  }

  @override
  int get hashCode {
    final int firstHash = Object.hash(
        id,
        title,
        const DeepCollectionEquality().hash(departmentManagers),
        const DeepCollectionEquality().hash(departmentManagersPermission),
        const DeepCollectionEquality().hash(departmentTeamleaders),
        const DeepCollectionEquality().hash(departmentTeamleadersPermission),
        const DeepCollectionEquality().hash(mustTogether),
        fpScan,
        const DeepCollectionEquality().hash(fpScanLocations),
        fpNavigate,
        const DeepCollectionEquality().hash(fpNavigateLocations),
        fpWifi,
        const DeepCollectionEquality().hash(fpWifiLocations),
        fpBluetooth,
        const DeepCollectionEquality().hash(fpBluetoothLocations),
        payrollOvertimeRate,
        payrollVacationWithoutRequest,
        payrollVacationWithoutPay);

    final int secondHash = Object.hash(
        const DeepCollectionEquality().hash(payrollLateAttendance),
        empPublicHolidaysActivate,
        const DeepCollectionEquality().hash(weekend),
        workingHoursType,
        dailyWorkingHours,
        allowedDelayMinutes,
        workingHoursFrom,
        workingHoursTo,
        workingHoursFromStart,
        workingHoursFromEnd,
        const DeepCollectionEquality().hash(requestTypes),
        status,
        scheduleDate,
        action);

    return Object.hash(firstHash, secondHash);
  }
}

class Manager {
  final int? key;
  final String? value;

  Manager({this.key, this.value});

  factory Manager.fromJson(Map<String, dynamic> json) {
    return Manager(
      key: json['key'] is int
          ? json['key'] as int?
          : int.tryParse(json['key'].toString()),
      value: json['value'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'key': key,
        'value': value,
      };

  Manager copyWith({
    int? key,
    String? value,
  }) {
    return Manager(
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }

  @override
  String toString() {
    return 'Manager(key: $key, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Manager && other.key == key && other.value == value;
  }

  @override
  int get hashCode => Object.hash(key, value);
}

class Permission {
  final int? id;
  final String? name;

  Permission({this.id, this.name});

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      id: json['id'] is int
          ? json['id'] as int?
          : int.tryParse(json['id'].toString()),
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  Permission copyWith({
    int? id,
    String? name,
  }) {
    return Permission(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'Permission(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Permission && other.id == id && other.name == name;
  }

  @override
  int get hashCode => Object.hash(id, name);
}

class MustTogether {
  final int? id;
  final String? name;

  MustTogether({this.id, this.name});

  factory MustTogether.fromJson(Map<String, dynamic> json) {
    return MustTogether(
      id: json['id'] is int
          ? json['id'] as int?
          : int.tryParse(json['id'].toString()),
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  MustTogether copyWith({
    int? id,
    String? name,
  }) {
    return MustTogether(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'MustTogether(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MustTogether && other.id == id && other.name == name;
  }

  @override
  int get hashCode => Object.hash(id, name);
}

class Location {
  final int? id;
  final String? name;

  Location({this.id, this.name});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'] is int
          ? json['id'] as int?
          : int.tryParse(json['id'].toString()),
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  Location copyWith({
    int? id,
    String? name,
  }) {
    return Location(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'Location(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Location && other.id == id && other.name == name;
  }

  @override
  int get hashCode => Object.hash(id, name);
}

class LateAttendance {
  final double? minutesLate;
  final double? deductionsRate;
  final Type? type;

  LateAttendance({this.minutesLate, this.deductionsRate, this.type});

  factory LateAttendance.fromJson(Map<String, dynamic> json) {
    return LateAttendance(
      minutesLate: json['minutes_late'] as double?,
      deductionsRate: json['deductions_rate'] as double?,
      type: json['type'] != null ? Type.fromJson(json['type']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'minutes_late': minutesLate,
        'deductions_rate': deductionsRate,
        'type': type?.toJson(),
      };

  LateAttendance copyWith({
    double? minutesLate,
    double? deductionsRate,
    Type? type,
  }) {
    return LateAttendance(
      minutesLate: minutesLate ?? this.minutesLate,
      deductionsRate: deductionsRate ?? this.deductionsRate,
      type: type ?? this.type,
    );
  }

  @override
  String toString() {
    return 'LateAttendance(minutesLate: $minutesLate, deductionsRate: $deductionsRate, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LateAttendance &&
        other.minutesLate == minutesLate &&
        other.deductionsRate == deductionsRate &&
        other.type == type;
  }

  @override
  int get hashCode => Object.hash(minutesLate, deductionsRate, type);
}

class Type {
  final String? key;
  final String? value;

  Type({this.key, this.value});

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      key: json['key'] as String?,
      value: json['value'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'key': key,
        'value': value,
      };

  Type copyWith({
    String? key,
    String? value,
  }) {
    return Type(
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }

  @override
  String toString() {
    return 'Type(key: $key, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Type && other.key == key && other.value == value;
  }

  @override
  int get hashCode => Object.hash(key, value);
}

class Activate {
  final String? key;
  final String? value;

  Activate({this.key, this.value});

  factory Activate.fromJson(Map<String, dynamic> json) {
    return Activate(
      key: json['key'] as String?,
      value: json['value'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'key': key,
        'value': value,
      };

  Activate copyWith({
    String? key,
    String? value,
  }) {
    return Activate(
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }

  @override
  String toString() {
    return 'Activate(key: $key, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Activate && other.key == key && other.value == value;
  }

  @override
  int get hashCode => Object.hash(key, value);
}

class WorkingHoursType {
  final String? key;
  final String? value;

  WorkingHoursType({this.key, this.value});

  factory WorkingHoursType.fromJson(Map<String, dynamic> json) {
    return WorkingHoursType(
      key: json['key'] as String?,
      value: json['value'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'key': key,
        'value': value,
      };

  WorkingHoursType copyWith({
    String? key,
    String? value,
  }) {
    return WorkingHoursType(
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }

  @override
  String toString() {
    return 'WorkingHoursType(key: $key, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WorkingHoursType &&
        other.key == key &&
        other.value == value;
  }

  @override
  int get hashCode => Object.hash(key, value);
}

class RequestType {
  final Type? type;
  final int? maximum;
  final bool? maximumUnlimited;

  RequestType({this.type, this.maximum, this.maximumUnlimited});

  factory RequestType.fromJson(Map<String, dynamic> json) {
    return RequestType(
      type: json['type'] != null ? Type.fromJson(json['type']) : null,
      maximum: json['maximum'] != null
          ? int.tryParse(json['maximum'].toString()) ?? json['maximum'] as int?
          : null,
      maximumUnlimited: json['maximum_unlimited'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type?.toJson(),
        'maximum': maximum,
        'maximum_unlimited': maximumUnlimited,
      };

  RequestType copyWith({
    Type? type,
    int? maximum,
    bool? maximumUnlimited,
  }) {
    return RequestType(
      type: type ?? this.type,
      maximum: maximum ?? this.maximum,
      maximumUnlimited: maximumUnlimited ?? this.maximumUnlimited,
    );
  }

  @override
  String toString() {
    return 'RequestType(type: $type, maximum: $maximum, maximumUnlimited: $maximumUnlimited)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RequestType &&
        other.type == type &&
        other.maximum == maximum &&
        other.maximumUnlimited == maximumUnlimited;
  }

  @override
  int get hashCode => Object.hash(type, maximum, maximumUnlimited);
}

class Status {
  final String? key;
  final String? value;

  Status({this.key, this.value});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      key: json['key'] as String?,
      value: json['value'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'key': key,
        'value': value,
      };

  Status copyWith({
    String? key,
    String? value,
  }) {
    return Status(
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }

  @override
  String toString() {
    return 'Status(key: $key, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Status && other.key == key && other.value == value;
  }

  @override
  int get hashCode => Object.hash(key, value);
}

class ActionLinks {
  final String? edit;
  final String? delete;

  ActionLinks({this.edit, this.delete});

  factory ActionLinks.fromJson(Map<String, dynamic> json) {
    return ActionLinks(
      edit: json['edit'] as String?,
      delete: json['delete'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'edit': edit,
        'delete': delete,
      };

  ActionLinks copyWith({
    String? edit,
    String? delete,
  }) {
    return ActionLinks(
      edit: edit ?? this.edit,
      delete: delete ?? this.delete,
    );
  }

  @override
  String toString() {
    return 'ActionLinks(edit: $edit, delete: $delete)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ActionLinks && other.edit == edit && other.delete == delete;
  }

  @override
  int get hashCode => Object.hash(edit, delete);
}
