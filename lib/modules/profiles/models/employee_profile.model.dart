import '../../../models/settings/user_settings_2.model.dart';

class EmployeeProfileModel {
  final int? id;
  final String? avatar;
  final String? jobTitle;
  final String? name;
  final String? username;
  final String? email;
  final String? birthDay;
  // final KeyValue? countryKey;
  final int? countryKey;
  final String? phone;
  final String? roles;
  final EmpKeyValue? defaultLanguage;
  final EmpKeyValue? status;
  final String? tags;
  final EmpKeyValue? departmentId;
  final Map<String, String>? action;
  final List<String>? additionalPhoneNumbers;
  final EmpSocialMedia? social;
  final String? jobDescription;
  final String? hireDate;
  final List<Balance>? balance;
  final String? weekends;
  final EmpWorkingHours? workingHours;
  final List<String>? assets;
  final String? basicSalary;
  final List<EmpPayrollDeduction>? payrollDeductions;
  final List<EmpPayrollBonus>? payrollSpecialBonus;
  final List<EmpPayroll>? payrolls;
  final double? netSalary;
  final String? workingHoursType;
  final double? totalDeductions;
  final double? additions; // or "totalBonuses"

  EmployeeProfileModel({
    this.id,
    this.avatar,
    this.name,
    this.workingHoursType,
    this.username,
    this.email,
    this.jobTitle,
    this.birthDay,
    this.countryKey,
    this.phone,
    this.roles,
    this.defaultLanguage,
    this.status,
    this.tags,
    this.departmentId,
    this.action,
    this.additionalPhoneNumbers,
    this.social,
    this.jobDescription,
    this.hireDate,
    this.balance,
    this.weekends,
    this.workingHours,
    this.assets,
    this.basicSalary,
    this.payrollDeductions,
    this.payrollSpecialBonus,
    this.payrolls,
  })  : totalDeductions = _calculateTotalAmount(
            basicSalary, payrollDeductions?.map((d) => d.value).toList()),
        additions = _calculateTotalAmount(
            basicSalary, payrollSpecialBonus?.map((b) => b.value).toList()),
        netSalary = _calculateNetSalary(
            basicSalary, payrollDeductions, payrollSpecialBonus);

  static double _calculateNetSalary(
    String? basicSalary,
    List<EmpPayrollDeduction>? payrollDeductions,
    List<EmpPayrollBonus>? payrollSpecialBonus,
  ) {
    if (basicSalary == null) return 0.0;

    final totalDeductions = _calculateTotalAmount(
        basicSalary, payrollDeductions?.map((d) => d.value).toList());

    final totalBonuses = _calculateTotalAmount(
      basicSalary,
      payrollSpecialBonus?.map((b) => b.value).toList(),
    );

    return double.tryParse(basicSalary)! + totalBonuses - totalDeductions;
  }

  static double _calculateTotalAmount(
      String? baseSalary, List<String?>? values) {
    if (baseSalary == null || values == null || values.isEmpty == true) {
      return 0.0;
    }
    final baseSalaryValue = double.tryParse(baseSalary) ?? 0.0;
    return values.fold(0.0, (total, value) {
      if (value?.endsWith('%') == true) {
        final percentage = double.tryParse(value!.replaceAll('%', '')) ?? 0.0;
        return total + (baseSalaryValue * (percentage / 100));
      } else {
        if (value == null || value.isEmpty == true) return total;
        return total + (double.tryParse(value) ?? 0.0);
      }
    });
  }

  factory EmployeeProfileModel.fromJson(Map<String, dynamic> json) {
    return EmployeeProfileModel(
        id: json['id'],
        avatar: json['avatar'],
        name: json['name'],
        workingHoursType: json['working_hours_type'],
        username: json['username'],
        email: json['email'],
        birthDay: json['birth_day'],
        countryKey: json['country_key'],
        // countryKey: json['country_key'] != null
        //     ? KeyValue.fromJson(json['country_key'])
        //     : null,
        phone: json['phone'],
        roles: json['roles'],
        defaultLanguage: json['default_language'] != null
            ? EmpKeyValue.fromJson(json['default_language'])
            : null,
        status: json['status'] != null
            ? EmpKeyValue.fromJson(json['status'])
            : null,
        tags: json['tags'],
        departmentId: json['department_id'] != null
            ? EmpKeyValue.fromJson(json['department_id'])
            : null,
        action: json['action'] != null
            ? Map<String, String>.from(json['action'])
            : null,
        jobTitle: json['job_title'],
        additionalPhoneNumbers: json['additional_phone_numbers'] != null
            ? List<String>.from(json['additional_phone_numbers'])
            : null,
        social: json['social'] != null
            ? EmpSocialMedia.fromJson(json['social'])
            : null,
        jobDescription: json['job_description'],
        hireDate: json['hire_date'],
        balance: json['balance'] != null
            ? List<Balance>.from(
                json['balance'].map((item) => Balance.fromJson(item)))
            : null,
        weekends: json['weekends'],
        workingHours: json['working_hours'] != null
            ? EmpWorkingHours.fromJson(json['working_hours'])
            : null,
        assets:
            json['assets'] != null ? List<String>.from(json['assets']) : null,
        basicSalary: json['basic_salary'],
        // json['basic_salary'] is num?
        //     ? (json['basic_salary'] as num?)?.toDouble()
        //     : num.tryParse(json['basic_salary'])?.toDouble(),
        payrollDeductions: json['payroll_deductions'] != null
            ? List<EmpPayrollDeduction>.from(json['payroll_deductions']
                .map((item) => EmpPayrollDeduction.fromJson(item)))
            : null,
        payrollSpecialBonus: json['payroll_special_bonus'] != null
            ? List<EmpPayrollBonus>.from(json['payroll_special_bonus']
                .map((item) => EmpPayrollBonus.fromJson(item)))
            : null,
        payrolls: json['payrolls'] != null
            ? List<EmpPayroll>.from(
                json['payrolls'].map((item) => EmpPayroll.fromJson(item)))
            : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'avatar': avatar,
      'name': name,
      'username': username,
      'email': email,
      'birth_day': birthDay,
      'country_key': countryKey,
      'phone': phone,
      'roles': roles,
      'default_language': defaultLanguage?.toJson(),
      'status': status?.toJson(),
      'tags': tags,
      'department_id': departmentId?.toJson(),
      'action': action,
      'job_title': jobTitle,
      'additional_phone_numbers': additionalPhoneNumbers,
      'social': social?.toJson(),
      'job_description': jobDescription,
      'hire_date': hireDate,
      'balance': balance?.map((item) => item.toJson()).toList(),
      'weekends': weekends,
      'working_hours': workingHours?.toJson(),
      'assets': assets,
      'basic_salary': basicSalary,
      'payroll_deductions':
          payrollDeductions?.map((item) => item.toJson()).toList(),
      'payroll_special_bonus':
          payrollSpecialBonus?.map((item) => item.toJson()).toList(),
      'payrolls': payrolls?.map((item) => item.toJson()).toList(),
      'working_hours_type': workingHoursType,
    };
  }

  EmployeeProfileModel copyWith(
      {int? id,
      String? avatar,
      String? name,
      String? username,
      String? email,
      String? birthDay,
      // KeyValue? countryKey,
      int? countryKey,
      String? phone,
      String? roles,
      EmpKeyValue? defaultLanguage,
      EmpKeyValue? status,
      String? tags,
      EmpKeyValue? departmentId,
      Map<String, String>? action,
      String? jobTitle}) {
    return EmployeeProfileModel(
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        name: name ?? this.name,
        username: username ?? this.username,
        email: email ?? this.email,
        birthDay: birthDay ?? this.birthDay,
        countryKey: countryKey ?? this.countryKey,
        phone: phone ?? this.phone,
        roles: roles ?? this.roles,
        defaultLanguage: defaultLanguage ?? this.defaultLanguage,
        status: status ?? this.status,
        tags: tags ?? this.tags,
        departmentId: departmentId ?? this.departmentId,
        action: action ?? this.action,
        jobTitle: jobTitle ?? this.jobTitle);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EmployeeProfileModel &&
        other.id == id &&
        other.avatar == avatar &&
        other.name == name &&
        other.username == username &&
        other.email == email &&
        other.birthDay == birthDay &&
        other.countryKey == countryKey &&
        other.phone == phone &&
        other.roles == roles &&
        other.defaultLanguage == defaultLanguage &&
        other.status == status &&
        other.tags == tags &&
        other.departmentId == departmentId &&
        other.action == action &&
        other.jobTitle == jobTitle &&
        other.additionalPhoneNumbers == additionalPhoneNumbers &&
        other.social == social &&
        other.jobDescription == jobDescription &&
        other.hireDate == hireDate &&
        other.balance == balance &&
        other.weekends == weekends &&
        other.workingHours == workingHours &&
        other.assets == assets &&
        other.basicSalary == basicSalary &&
        other.payrollDeductions == payrollDeductions &&
        other.payrollSpecialBonus == payrollSpecialBonus &&
        other.payrolls == payrolls;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        avatar.hashCode ^
        name.hashCode ^
        username.hashCode ^
        email.hashCode ^
        birthDay.hashCode ^
        countryKey.hashCode ^
        phone.hashCode ^
        roles.hashCode ^
        defaultLanguage.hashCode ^
        status.hashCode ^
        tags.hashCode ^
        departmentId.hashCode ^
        action.hashCode ^
        jobTitle.hashCode ^
        additionalPhoneNumbers.hashCode ^
        social.hashCode ^
        jobDescription.hashCode ^
        hireDate.hashCode ^
        balance.hashCode ^
        weekends.hashCode ^
        workingHours.hashCode ^
        assets.hashCode ^
        basicSalary.hashCode ^
        payrollDeductions.hashCode ^
        payrollSpecialBonus.hashCode ^
        payrolls.hashCode;
  }

  @override
  String toString() {
    return 'EmployeeModel(id: $id, jobTitle: $jobTitle, avatar: $avatar, name: $name, username: $username, email: $email, birthDay: $birthDay, countryKey: $countryKey, phone: $phone, roles: $roles, defaultLanguage: $defaultLanguage, status: $status, tags: $tags, departmentId: $departmentId, action: $action, additionalPhoneNumbers: $additionalPhoneNumbers, social: $social, jobDescription: $jobDescription, hireDate: $hireDate, balance: $balance, weekends: $weekends, workingHours: $workingHours, assets: $assets, basicSalary: $basicSalary, payrollDeductions: $payrollDeductions, payrollSpecialBonus: $payrollSpecialBonus, payrolls: $payrolls)';
  }
}

class EmpSocialMedia {
  final String? facebook;
  final String? twitter;
  final String? linkedin;
  final String? instagram;
  final String? youtube;
  final String? pinterest;
  final String? snapchat;
  final String? whatsapp;

  EmpSocialMedia({
    this.facebook,
    this.twitter,
    this.linkedin,
    this.instagram,
    this.youtube,
    this.pinterest,
    this.snapchat,
    this.whatsapp,
  });

  factory EmpSocialMedia.fromJson(Map<String, dynamic> json) {
    return EmpSocialMedia(
      facebook: json['facebook'],
      twitter: json['twitter'],
      linkedin: json['linkedin'],
      instagram: json['instagram'],
      youtube: json['youtube'],
      pinterest: json['pinterest'],
      snapchat: json['snapchat'],
      whatsapp: json['whatsapp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'facebook': facebook,
      'twitter': twitter,
      'linkedin': linkedin,
      'instagram': instagram,
      'youtube': youtube,
      'pinterest': pinterest,
      'snapchat': snapchat,
      'whatsapp': whatsapp,
    };
  }
}

class EmpWorkingHours {
  final String? dailyWorkingHours;
  final String? workingHoursType;

  EmpWorkingHours({
    this.dailyWorkingHours,
    this.workingHoursType,
  });

  factory EmpWorkingHours.fromJson(Map<String, dynamic> json) {
    return EmpWorkingHours(
      dailyWorkingHours: json['daily_working_hours'],
      workingHoursType: json['working_hours_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'daily_working_hours': dailyWorkingHours,
      'working_hours_type': workingHoursType,
    };
  }
}

class EmpPayrollDeduction {
  final String? title;
  final String? value;
  final bool? nextPeriodOnly;

  EmpPayrollDeduction({
    this.title,
    this.value,
    this.nextPeriodOnly,
  });

  factory EmpPayrollDeduction.fromJson(Map<String, dynamic> json) {
    return EmpPayrollDeduction(
      title: json['title'],
      value: json['value'].toString(),
      nextPeriodOnly: json['next_period_only'],
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

class EmpPayrollBonus {
  final String? title;
  final String? value;
  final bool? nextPeriodOnly;

  EmpPayrollBonus({
    this.title,
    this.value,
    this.nextPeriodOnly,
  });

  factory EmpPayrollBonus.fromJson(Map<String, dynamic> json) {
    return EmpPayrollBonus(
      title: json['title'],
      value: json['value'].toString(),
      nextPeriodOnly: json['next_period_only'],
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

class EmpPayroll {
  final int? id;
  final String? dateFrom;
  final String? dateTo;
  final String? currency;
  final double? basicSalary;
  final double? netPayable;
  final String? status;
  final List<EmpPayrollDeduction>? payrollDeductions;
  final List<EmpPayrollBonus>? payrollSpecialBonus;
  final double? payrollTotalDeductions;
  final double? payrollTotalSpecialBonus;

  EmpPayroll({
    this.id,
    this.dateFrom,
    this.dateTo,
    this.currency,
    this.basicSalary,
    this.netPayable,
    this.status,
    this.payrollDeductions,
    this.payrollSpecialBonus,
    this.payrollTotalDeductions,
    this.payrollTotalSpecialBonus,
  });

  factory EmpPayroll.fromJson(Map<String, dynamic> json) {
    return EmpPayroll(
      id: json['id'],
      dateFrom: json['date_from'],
      dateTo: json['date_to'],
      currency: json['currency'],
      basicSalary: (json['basic_salary'] != null)
          ? json['basic_salary'] is String
              ? double.tryParse(json['basic_salary'])
              : (json['basic_salary'] as int).toDouble()
          : null,
      netPayable: (json['net_payable'] != null)
          ? json['net_payable'] is String
              ? double.tryParse(json['net_payable'])
              : (json['net_payable'] as int).toDouble()
          : null,
      status: json['status'],
      payrollDeductions: json['payroll_deductions'] != null
          ? List<EmpPayrollDeduction>.from(json['payroll_deductions']
              .map((item) => EmpPayrollDeduction.fromJson(item)))
          : null,
      payrollSpecialBonus: json['payroll_special_bonus'] != null
          ? List<EmpPayrollBonus>.from(json['payroll_special_bonus']
              .map((item) => EmpPayrollBonus.fromJson(item)))
          : null,
      payrollTotalDeductions: json['payroll_total_deductions'] != null
          ? json['payroll_total_deductions'] is String
              ? double.tryParse(json['payroll_total_deductions'])
              : (json['payroll_total_deductions'] as int).toDouble()
          : null,
      payrollTotalSpecialBonus: json['payroll_total_special_bonus'] != null
          ? json['payroll_total_special_bonus'] is String
              ? double.tryParse(json['payroll_total_special_bonus'])
              : json['payroll_total_special_bonus']
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date_from': dateFrom,
      'date_to': dateTo,
      'currency': currency,
      'basic_salary': basicSalary?.toString(),
      'net_payable': netPayable?.toString(),
      'status': status,
      'payroll_deductions':
          payrollDeductions?.map((item) => item.toJson()).toList(),
      'payroll_special_bonus':
          payrollSpecialBonus?.map((item) => item.toJson()).toList(),
      'payroll_total_deductions': payrollTotalDeductions?.toString(),
      'payroll_total_special_bonus': payrollTotalSpecialBonus?.toString(),
    };
  }
}

class EmpKeyValue {
  final String? key;
  final String? value;

  EmpKeyValue({this.key, this.value});

  factory EmpKeyValue.fromJson(Map<String, dynamic> json) {
    return EmpKeyValue(
      key: json['key']?.toString(), // Ensuring the key is treated as a String
      value: json['value']
          ?.toString(), // Ensuring the value is treated as a String
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EmpKeyValue && other.key == key && other.value == value;
  }

  @override
  int get hashCode => key.hashCode ^ value.hashCode;

  @override
  String toString() => 'KeyValue(key: $key, value: $value)';
}
