import 'department.model.dart';
import 'stores/country_key_model.dart';

class RequestModel {
  final int? id;
  final DepartmentModel? department;
  final int? departmentId;
  final Type? type;
  final int? typeid;
  final String? dateFrom;
  final String? dateTo;
  final UserModel? user;
  final int? userId;
  final int? duration;
  final int? moneyValue;
  final String? reason;
  final List<dynamic>? files;
  final String? theManagerReply;
  final String? notes;
  final Status? status;
  final String? username;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;
  final List<dynamic>? askRemember;
  final List<dynamic>? askIgnore;
  final List<dynamic>? replays;
  final List<dynamic>? changeStatus;
  final bool? multiApprove;
  final LastSeen? lastSeen;
  final Level? level;
  final Action? action;

  RequestModel(
      {this.id,
      this.type,
      this.typeid,
      this.user,
      this.dateFrom,
      this.dateTo,
      this.duration,
      this.moneyValue,
      this.files,
      this.reason,
      this.theManagerReply,
      this.notes,
      this.status,
      this.userId,
      this.username,
      this.departmentId,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.askRemember,
      this.askIgnore,
      this.replays,
      this.changeStatus,
      this.multiApprove,
      this.lastSeen,
      this.action,
      this.department,
      this.level});

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      id: json['id'] as int?,
      type: json['type'] != null ? Type.fromJson(json['type']) : null,
      typeid: json['type_id'] != null
          ? int.tryParse(json['type_id'].toString()) ?? json['type_id'] as int?
          : null,
      dateFrom: json['date_from'] as String?,
      dateTo: json['date_to'] as String?,
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      duration: json['duration'] as int?,
      moneyValue: json['money_value'] as int?,
      files: json['files'] as List<dynamic>?,
      reason: json['reason'] as String?,
      theManagerReply: json['the_manager_Reply'] as String?,
      notes: json['notes'] as String?,
      status: json['status'] != null ? Status.fromJson(json['status']) : null,
      userId: json['user_id'] as int?,
      username: json['username'] as String?,
      departmentId: json['department_id'] as int?,
      deletedAt: json['deleted_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      askRemember: json['ask_remember'] as List<dynamic>?,
      askIgnore: json['ask_ignore'] as List<dynamic>?,
      replays: json['replays'] as List<dynamic>?,
      changeStatus: json['change_status'] as List<dynamic>?,
      multiApprove: json['multi_approve'] as bool?,
      lastSeen: json['last_seen'] != null
          ? LastSeen.fromJson(json['last_seen'])
          : null,
      department: DepartmentModel.fromJson(json['department']),
      level: json['level'] != null ? Level.fromJson(json['level']) : null,
      action: json['action'] != null ? Action.fromJson(json['action']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type?.toJson(),
      'typeid': typeid,
      'date_from': dateFrom,
      'date_to': dateTo,
      'user': user?.toJson(),
      'duration': duration,
      'money_value': moneyValue,
      'files': files,
      'reason': reason,
      'the_manager_Reply': theManagerReply,
      'notes': notes,
      'status': status?.toJson(),
      'user_id': userId,
      'username': username,
      'department_id': departmentId,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'ask_remember': askRemember,
      'ask_ignore': askIgnore,
      'replays': replays,
      'change_status': changeStatus,
      'multi_approve': multiApprove,
      'last_seen': lastSeen?.toJson(),
      'department': department?.toJson(),
      'level': level?.toJson(),
      'action': action?.toJson(),
    };
  }
}

class UserModel {
  final int? id;
  final String? avatar;
  final String? name;
  final String? username;
  final String? email;
  final String? birthDay;
  final CountryKeyModel? countryKey;
  final String? phone;
  final String? roles;
  final DefaultLanguage? defaultLanguage;
  final Status? status;
  final String? tags;
  final Action? action;

  UserModel({
    this.id,
    this.avatar,
    this.name,
    this.username,
    this.email,
    this.birthDay,
    this.countryKey,
    this.phone,
    this.roles,
    this.defaultLanguage,
    this.status,
    this.tags,
    this.action,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int?,
      avatar: json['avatar'] as String?,
      name: json['name'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      birthDay: json['birth_day'] as String?,
      countryKey: json['country_key'] != null
          ? CountryKeyModel.fromJson(json['country_key'])
          : null,
      phone: json['phone'] as String?,
      roles: json['roles'] as String?,
      defaultLanguage: json['default_language'] != null
          ? DefaultLanguage.fromJson(json['default_language'])
          : null,
      status: json['status'] != null ? Status.fromJson(json['status']) : null,
      tags: json['tags'] as String?,
      action: json['action'] != null ? Action.fromJson(json['action']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'avatar': avatar,
      'name': name,
      'username': username,
      'email': email,
      'birth_day': birthDay,
      'country_key': countryKey?.toJson(),
      'phone': phone,
      'roles': roles,
      'default_language': defaultLanguage?.toJson(),
      'status': status?.toJson(),
      'tags': tags,
      'action': action?.toJson(),
    };
  }
}

class DefaultLanguage {
  final String? key;
  final String? value;

  DefaultLanguage({this.key, this.value});

  factory DefaultLanguage.fromJson(Map<String, dynamic> json) {
    return DefaultLanguage(
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

class Level {
  final String? key;
  final String? value;

  Level({this.key, this.value});

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
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

class Type {
  final int? id;
  final String? title;
  final TypeDetail? type;
  final int? maximum;
  final String? maximumUnlimited;
  final int? acceptanceTime;
  final String? acceptanceTimeType;
  final CountingType? countingType;
  final String? attachingFile;
  final String? moneyValueField;
  final String? rulesMessage;
  final String? deductedFromSalary;
  final String? salaryDeductionPercentage;
  final String? halfDayLeave;
  final String? autoCancel;
  final List<dynamic> notifyDepartments;
  final List<MultiDepartment>? multiDepartments;
  final List<User>? users;
  final Status? status;
  final String? scheduleDate;
  final Action? action;

  Type({
    this.id,
    this.title,
    this.type,
    this.maximum,
    this.maximumUnlimited,
    this.acceptanceTime,
    this.acceptanceTimeType,
    this.countingType,
    this.attachingFile,
    this.moneyValueField,
    this.rulesMessage,
    this.deductedFromSalary,
    this.salaryDeductionPercentage,
    this.halfDayLeave,
    this.autoCancel,
    this.notifyDepartments = const [],
    this.multiDepartments,
    this.users,
    this.status,
    this.scheduleDate,
    this.action,
  });

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      id: json['id'] as int?,
      title: json['title'] as String?,
      type: json['type'] != null ? TypeDetail.fromJson(json['type']) : null,
      maximum: json['maximum'] as int?,
      maximumUnlimited: json['maximum_unlimited'] as String?,
      acceptanceTime: json['acceptance_time'] as int?,
      acceptanceTimeType: json['acceptance_time_type'] as String?,
      countingType: json['counting_type'] != null
          ? CountingType.fromJson(json['counting_type'])
          : null,
      attachingFile: json['attaching_file'] as String?,
      moneyValueField: json['money_value_field'] as String?,
      rulesMessage: json['rules_message'] as String?,
      deductedFromSalary: json['deducted_from_salary'] as String?,
      salaryDeductionPercentage: json['salary_deduction_percentage'] as String?,
      halfDayLeave: json['half_day_leave'] as String?,
      autoCancel: json['auto_cancel'] as String?,
      notifyDepartments: json['notify_departments'] as List<dynamic>,
      multiDepartments: json['multi_departments'] != null
          ? (json['multi_departments'] as List<dynamic>)
              .map((e) => MultiDepartment.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      users: json['users'] != null
          ? (json['users'] as List<dynamic>)
              .map((e) => User.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      status: json['status'] != null ? Status.fromJson(json['status']) : null,
      scheduleDate: json['schedule_date'] as String?,
      action: json['action'] != null ? Action.fromJson(json['action']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type?.toJson(),
      'maximum': maximum,
      'maximum_unlimited': maximumUnlimited,
      'acceptance_time': acceptanceTime,
      'acceptance_time_type': acceptanceTimeType,
      'counting_type': countingType?.toJson(),
      'attaching_file': attachingFile,
      'money_value_field': moneyValueField,
      'rules_message': rulesMessage,
      'deducted_from_salary': deductedFromSalary,
      'salary_deduction_percentage': salaryDeductionPercentage,
      'half_day_leave': halfDayLeave,
      'auto_cancel': autoCancel,
      'notify_departments': notifyDepartments,
      'multi_departments': multiDepartments?.map((e) => e.toJson()).toList(),
      'users': users?.map((e) => e.toJson()).toList(),
      'status': status?.toJson(),
      'schedule_date': scheduleDate,
      'action': action?.toJson(),
    };
  }
}

class TypeDetail {
  final String? key;
  final String? value;

  TypeDetail({this.key, this.value});

  factory TypeDetail.fromJson(Map<String, dynamic> json) {
    return TypeDetail(
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

class CountingType {
  final String? key;
  final String? value;

  CountingType({this.key, this.value});

  factory CountingType.fromJson(Map<String, dynamic> json) {
    return CountingType(
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

class MultiDepartment {
  final String? key;
  final String? value;

  MultiDepartment({this.key, this.value});

  factory MultiDepartment.fromJson(Map<String, dynamic> json) {
    return MultiDepartment(
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

class User {
  final String? key;
  final String? value;

  User({this.key, this.value});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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

class LastSeen {
  final int? seenBy;
  final String? date;

  LastSeen({this.seenBy, this.date});

  factory LastSeen.fromJson(Map<String, dynamic> json) {
    return LastSeen(
      seenBy: json['seen_by'] as int?,
      date: json['date'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seen_by': seenBy,
      'date': date,
    };
  }
}
