class EmployeeModel {
  final int? id;
  final String? avatar;
  final String? jobTitle;
  final String? name;
  final String? username;
  final String? email;
  final String? birthDay;
  final EmployeeKeyValue? countryKey;
  final String? phone;
  final String? roles;
  final EmployeeKeyValue? defaultLanguage;
  final EmployeeKeyValue? status;
  final String? tags;
  final EmployeeAction? action;

  EmployeeModel(
      {this.id,
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
      this.jobTitle});

  // Factory constructor to create an instance from a JSON map
  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'] as int?,
      avatar: json['avatar'] as String?,
      name: json['name'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      birthDay: json['birth_day'] as String?,
      countryKey: json['country_key'] != null
          ? EmployeeKeyValue.fromJson(
              json['country_key'] as Map<String, dynamic>)
          : null,
      phone: json['phone'] as String?,
      roles: json['roles'] as String?,
      defaultLanguage: json['default_language'] != null
          ? EmployeeKeyValue.fromJson(
              json['default_language'] as Map<String, dynamic>)
          : null,
      status: json['status'] != null
          ? EmployeeKeyValue.fromJson(json['status'] as Map<String, dynamic>)
          : null,
      tags: json['tags'] as String?,
      action: json['action'] != null
          ? EmployeeAction.fromJson(json['action'] as Map<String, dynamic>)
          : null,
      jobTitle: json['job_title'] as String?,
    );
  }

  // Method to convert an instance to a JSON map
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
      'job_title': jobTitle,
    };
  }

  // Overriding the toString method for better debugging output
  @override
  String toString() {
    return 'UserModel(id: $id, avatar: $avatar, name: $name, username: $username, email: $email, birthDay: $birthDay, countryKey: $countryKey, phone: $phone, roles: $roles, defaultLanguage: $defaultLanguage, status: $status, tags: $tags, action: $action)';
  }

  // Overriding equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EmployeeModel) return false;
    return other.id == id &&
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
        other.action == action;
  }

  // Overriding the hashCode method
  @override
  int get hashCode {
    return Object.hash(
      id,
      avatar,
      name,
      username,
      email,
      birthDay,
      countryKey,
      phone,
      roles,
      defaultLanguage,
      status,
      tags,
      action,
    );
  }
}

// Helper class for key-value pairs
class EmployeeKeyValue {
  final dynamic key;
  final String? value;

  EmployeeKeyValue({this.key, this.value});

  factory EmployeeKeyValue.fromJson(Map<String, dynamic> json) {
    return EmployeeKeyValue(
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

// Action class
class EmployeeAction {
  final String? edit;
  final String? delete;

  EmployeeAction({this.edit, this.delete});

  factory EmployeeAction.fromJson(Map<String, dynamic> json) {
    return EmployeeAction(
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
