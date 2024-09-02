import '../../../models/employee.model.dart';

class RewardAndPenaltyModel {
  final int? id;
  final int? amount;
  final Type? type;
  final Category? category;
  final String? reason;
  final ActionLinks? action;
  final EmployeeModel? employee;
  final int? employeeId;
  final int? payrollId;
  final String? createdAt;

  RewardAndPenaltyModel({
    this.id,
    this.amount,
    this.createdAt,
    this.type,
    this.category,
    this.reason,
    this.action,
    this.employee,
    this.employeeId,
    this.payrollId,
  });

  factory RewardAndPenaltyModel.fromJson(Map<String, dynamic> json) {
    return RewardAndPenaltyModel(
      id: json['id'] as int?,
      amount: json['amount'] as int?,
      type: json['type'] != null ? Type.fromJson(json['type']) : null,
      category:
          json['category'] != null ? Category.fromJson(json['category']) : null,
      reason: json['reason'] as String?,
      action:
          json['action'] != null ? ActionLinks.fromJson(json['action']) : null,
      employee:
          EmployeeModel.fromJson(json['employee'] as Map<String, dynamic>),
      employeeId: json['employee_id'] as int?,
      payrollId: json['payroll_id'] as int?,
      createdAt: json['created_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'type': type?.toJson(),
      'category': category?.toJson(),
      'reason': reason,
      'action': action?.toJson(),
      'employee': employee?.toJson(),
      'employee_id': employeeId,
      'payroll_id': payrollId,
      'created_at': createdAt,
    };
  }

  @override
  String toString() {
    return 'RewardAndPenaltyModel(id: $id, amount: $amount, type: $type, category: $category, reason: $reason, action: $action, employee: $employee, employeeId: $employeeId, payrollId: $payrollId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RewardAndPenaltyModel &&
        other.id == id &&
        other.amount == amount &&
        other.type == type &&
        other.category == category &&
        other.reason == reason &&
        other.action == action &&
        other.employee == employee &&
        other.employeeId == employeeId &&
        other.payrollId == payrollId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        amount.hashCode ^
        type.hashCode ^
        category.hashCode ^
        reason.hashCode ^
        action.hashCode ^
        employee.hashCode ^
        employeeId.hashCode ^
        payrollId.hashCode;
  }
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

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value,
    };
  }

  @override
  String toString() => 'Type(key: $key, value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Type && other.key == key && other.value == value;
  }

  @override
  int get hashCode => key.hashCode ^ value.hashCode;
}

class Category {
  final String? key;
  final String? value;

  Category({this.key, this.value});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
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

  @override
  String toString() => 'Category(key: $key, value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category && other.key == key && other.value == value;
  }

  @override
  int get hashCode => key.hashCode ^ value.hashCode;
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

  Map<String, dynamic> toJson() {
    return {
      'edit': edit,
      'delete': delete,
    };
  }

  @override
  String toString() => 'ActionLinks(edit: $edit, delete: $delete)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ActionLinks && other.edit == edit && other.delete == delete;
  }

  @override
  int get hashCode => edit.hashCode ^ delete.hashCode;
}
