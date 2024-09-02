import '../../../models/employee.model.dart';

class PayrollModel {
  final int? id;
  final EmployeeModel? user;
  final int? userId;
  final String? dateFrom;
  final String? dateTo;
  final double? basicSalary;
  final double? salaryAdvance;
  final double? netPayable;
  final String? currency;
  final double? payrollTotalDeductions;
  final double? payrollTotalSpecialBonus;
  final List<Deduction>? payrollDeductions;
  final List<SpecialBonus>? payrollSpecialBonuses;
  final Status? status;
  final String? scheduleDate;
  final Action? action;
  final String? title;

  PayrollModel({
    this.id,
    this.title,
    this.user,
    this.userId,
    this.dateFrom,
    this.dateTo,
    this.basicSalary,
    this.salaryAdvance,
    this.netPayable,
    this.currency,
    this.payrollTotalDeductions,
    this.payrollTotalSpecialBonus,
    this.payrollDeductions,
    this.payrollSpecialBonuses,
    this.status,
    this.scheduleDate,
    this.action,
  });

  factory PayrollModel.fromJson(Map<String, dynamic> json) {
    return PayrollModel(
      id: json['id'] as int?,
      user: EmployeeModel.fromJson(json['user']),
      userId: json['user_id'] as int?,
      title: json['title'] as String?,
      dateFrom: json['date_from'] as String?,
      dateTo: json['date_to'] as String?,
      basicSalary: (json['basic_salary'] as num?)?.toDouble(),
      salaryAdvance: (json['salary_advance'] as num?)?.toDouble(),
      netPayable: (json['net_payable'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      payrollTotalDeductions:
          (json['payroll_total_deductions'] as num?)?.toDouble(),
      payrollTotalSpecialBonus:
          (json['payroll_total_special_bonus'] as num?)?.toDouble(),
      payrollDeductions: (json['payroll_deductions'] as List<dynamic>?)
          ?.map((item) => Deduction.fromJson(item as Map<String, dynamic>))
          .toList(),
      payrollSpecialBonuses: (json['payroll_special_bonus'] as List<dynamic>?)
          ?.map((item) => SpecialBonus.fromJson(item as Map<String, dynamic>))
          .toList(),
      status: json['status'] != null
          ? Status.fromJson(json['status'] as Map<String, dynamic>)
          : null,
      scheduleDate: json['schedule_date'] as String?,
      action: json['action'] != null
          ? Action.fromJson(json['action'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'user_id': userId,
      'date_from': dateFrom,
      'date_to': dateTo,
      'basic_salary': basicSalary,
      'salary_advance': salaryAdvance,
      'net_payable': netPayable,
      'currency': currency,
      'payroll_total_deductions': payrollTotalDeductions,
      'payroll_total_special_bonus': payrollTotalSpecialBonus,
      'payroll_deductions':
          payrollDeductions?.map((item) => item.toJson()).toList(),
      'payroll_special_bonus':
          payrollSpecialBonuses?.map((item) => item.toJson()).toList(),
      'status': status?.toJson(),
      'schedule_date': scheduleDate,
      'action': action?.toJson(),
      'title': title,
    };
  }

  PayrollModel copyWith({
    int? id,
    EmployeeModel? user,
    int? userId,
    String? dateFrom,
    String? dateTo,
    double? basicSalary,
    double? salaryAdvance,
    double? netPayable,
    String? currency,
    double? payrollTotalDeductions,
    double? payrollTotalSpecialBonus,
    List<Deduction>? payrollDeductions,
    List<SpecialBonus>? payrollSpecialBonuses,
    Status? status,
    String? scheduleDate,
    Action? action,
    String? title,
    String? jobTitle,
  }) {
    return PayrollModel(
      id: id ?? this.id,
      user: user ?? this.user,
      userId: userId ?? this.userId,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      basicSalary: basicSalary ?? this.basicSalary,
      salaryAdvance: salaryAdvance ?? this.salaryAdvance,
      netPayable: netPayable ?? this.netPayable,
      currency: currency ?? this.currency,
      payrollTotalDeductions:
          payrollTotalDeductions ?? this.payrollTotalDeductions,
      payrollTotalSpecialBonus:
          payrollTotalSpecialBonus ?? this.payrollTotalSpecialBonus,
      payrollDeductions: payrollDeductions ?? this.payrollDeductions,
      payrollSpecialBonuses:
          payrollSpecialBonuses ?? this.payrollSpecialBonuses,
      status: status ?? this.status,
      scheduleDate: scheduleDate ?? this.scheduleDate,
      action: action ?? this.action,
      title: title ?? this.title,
    );
  }

  @override
  String toString() {
    return 'PayrollModel(id: $id, user: $user, userId: $userId, dateFrom: $dateFrom, dateTo: $dateTo, basicSalary: $basicSalary, salaryAdvance: $salaryAdvance, netPayable: $netPayable, currency: $currency, payrollTotalDeductions: $payrollTotalDeductions, payrollTotalSpecialBonus: $payrollTotalSpecialBonus, payrollDeductions: $payrollDeductions, payrollSpecialBonuses: $payrollSpecialBonuses, status: $status, scheduleDate: $scheduleDate, action: $action)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PayrollModel) return false;
    return other.id == id &&
        other.user == user &&
        other.userId == userId &&
        other.dateFrom == dateFrom &&
        other.dateTo == dateTo &&
        other.basicSalary == basicSalary &&
        other.salaryAdvance == salaryAdvance &&
        other.netPayable == netPayable &&
        other.currency == currency &&
        other.payrollTotalDeductions == payrollTotalDeductions &&
        other.payrollTotalSpecialBonus == payrollTotalSpecialBonus &&
        other.payrollDeductions == payrollDeductions &&
        other.payrollSpecialBonuses == payrollSpecialBonuses &&
        other.status == status &&
        other.scheduleDate == scheduleDate &&
        other.action == action;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      user,
      userId,
      dateFrom,
      dateTo,
      basicSalary,
      salaryAdvance,
      netPayable,
      currency,
      payrollTotalDeductions,
      payrollTotalSpecialBonus,
      payrollDeductions,
      payrollSpecialBonuses,
      status,
      scheduleDate,
      action,
    );
  }
}

// Helper class for key-value pairs
class KeyValue {
  final dynamic key;
  final String? value;

  KeyValue({this.key, this.value});

  factory KeyValue.fromJson(Map<String, dynamic> json) {
    return KeyValue(
      key: json['key'],
      value: json['value'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value,
    };
  }

  @override
  String toString() {
    return 'KeyValue(key: $key, value: $value)';
  }
}

// Deduction class
class Deduction {
  final String? title;
  final double? value;
  final bool? nextPeriodOnly;

  Deduction({this.title, this.value, this.nextPeriodOnly});

  factory Deduction.fromJson(Map<String, dynamic> json) {
    return Deduction(
      title: json['title'] as String?,
      value: (json['value'] as num?)?.toDouble(),
      nextPeriodOnly: json['next_period_only'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'value': value,
      'next_period_only': nextPeriodOnly,
    };
  }
}

// SpecialBonus class
class SpecialBonus {
  final String? title;
  final double? value;
  final bool? nextPeriodOnly;

  SpecialBonus({this.title, this.value, this.nextPeriodOnly});

  factory SpecialBonus.fromJson(Map<String, dynamic> json) {
    return SpecialBonus(
      title: json['title'] as String?,
      value: (json['value'] as num?)?.toDouble(),
      nextPeriodOnly: json['next_period_only'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'value': value,
      'next_period_only': nextPeriodOnly,
    };
  }
}

// Status class
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

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value,
    };
  }
}

// Action class
class Action {
  final String? edit;
  final String? delete;

  Action({this.edit, this.delete});

  factory Action.fromJson(Map<String, dynamic> json) {
    return Action(
      edit: json['edit'] as String?,
      delete: json['delete'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'edit': edit,
      'delete': delete,
    };
  }
}













// class PayrollModel {
//   final int? id;
//   final int? userId;
//   final double? payrollTotalDeductions;
//   final double? payrollTotalSpecialBonus;
//   final double? netPayable;
//   final String? dateFrom;
//   final String? dateTo;
//   final String? title;
//   final String? jobTitle;

//   PayrollModel({
//     this.id,
//     this.userId,
//     this.payrollTotalDeductions,
//     this.payrollTotalSpecialBonus,
//     this.netPayable,
//     this.dateFrom,
//     this.dateTo,
//     this.title,
//     this.jobTitle,
//   });

//   // Factory constructor for creating an instance from a JSON map
//   factory PayrollModel.fromJson(Map<String, dynamic> json) {
//     return PayrollModel(
//       id: json['id'] as int?,
//       userId: json['user_id'] as int?,
//       payrollTotalDeductions:
//           (json['payroll_total_deductions'] as num?)?.toDouble(),
//       payrollTotalSpecialBonus:
//           (json['payroll_total_special_bonus'] as num?)?.toDouble(),
//       netPayable: (json['net_payable'] as num?)?.toDouble(),
//       dateFrom: json['date_from'] as String?,
//       dateTo: json['date_to'] as String?,
//       title: json['title'] as String?,
//       jobTitle: json['job_title'] as String?,
//     );
//   }

//   // Method to convert an instance to a JSON map
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'user_id': userId,
//       'payroll_total_deductions': payrollTotalDeductions,
//       'payroll_total_special_bonus': payrollTotalSpecialBonus,
//       'net_payable': netPayable,
//       'date_from': dateFrom,
//       'date_to': dateTo,
//       'title': title,
//       'job_title': jobTitle,
//     };
//   }

//   // Method to create a copy of an instance with optional new values
//   PayrollModel copyWith({
//     int? id,
//     int? userId,
//     double? payrollTotalDeductions,
//     double? payrollTotalSpecialBonus,
//     double? netPayable,
//     String? dateFrom,
//     String? dateTo,
//     String? title,
//     String? jobTitle,
//   }) {
//     return PayrollModel(
//       id: id ?? this.id,
//       userId: userId ?? this.userId,
//       payrollTotalDeductions:
//           payrollTotalDeductions ?? this.payrollTotalDeductions,
//       payrollTotalSpecialBonus:
//           payrollTotalSpecialBonus ?? this.payrollTotalSpecialBonus,
//       netPayable: netPayable ?? this.netPayable,
//       dateFrom: dateFrom ?? this.dateFrom,
//       dateTo: dateTo ?? this.dateTo,
//       title: title ?? this.title,
//       jobTitle: jobTitle ?? this.jobTitle,
//     );
//   }

//   // Overriding the toString method for better debugging output
//   @override
//   String toString() {
//     return 'PayrollModel(id: $id, userId: $userId, payrollTotalDeductions: $payrollTotalDeductions, payrollTotalSpecialBonus: $payrollTotalSpecialBonus, netPayable: $netPayable, dateFrom: $dateFrom, dateTo: $dateTo, title: $title, jobTitle: $jobTitle)';
//   }

//   // Overriding equality operator
//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
//     if (other is! PayrollModel) return false;
//     return other.id == id &&
//         other.userId == userId &&
//         other.payrollTotalDeductions == payrollTotalDeductions &&
//         other.payrollTotalSpecialBonus == payrollTotalSpecialBonus &&
//         other.netPayable == netPayable &&
//         other.dateFrom == dateFrom &&
//         other.dateTo == dateTo &&
//         other.title == title &&
//         other.jobTitle == jobTitle;
//   }

//   // Overriding the hashCode method
//   @override
//   int get hashCode {
//     return Object.hash(
//       id,
//       userId,
//       payrollTotalDeductions,
//       payrollTotalSpecialBonus,
//       netPayable,
//       dateFrom,
//       dateTo,
//       title,
//       jobTitle,
//     );
//   }
// }
