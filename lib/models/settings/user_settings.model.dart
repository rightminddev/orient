import 'app_settings_model.dart';

class UserSettingsModel extends AppSettingsModel {
  final int? userId;

  /// count od non-seen notifications
  final int? newNotificationCount;
  final String? name;
  final String? email;
  final String? phone;
  final DateTime? birthDate;
  final DateTime? emailVerifiedAt;
  final DateTime? phoneVerifiedAt;
  final List<String>? permissions;
  final List<String>? role;
  final String? photo;
  final List<dynamic>? emergencyContacts;
  final dynamic departmentInfo;
  final List<dynamic>? departments;
  final Map<String, dynamic>? managers;
  final Map<String, dynamic>? teamleaders;
  final List<dynamic>? approvalOfSubDepartments;
  final List<dynamic>? isManagerIn;
  final List<dynamic>? isTeamleaderIn;
  final bool? topManagement;
  final dynamic departmentId;
  final List<String>? profileInfoElements;
  final dynamic jobProfile;
  final dynamic policies;
  final dynamic contracts;
  final dynamic insuranceNumber;
  final dynamic asset;
  final Map<String, dynamic>? avFingerprint;
  final UserTeam? userTeam;
  final Map<String, dynamic>? avFingerprintLocations;

  UserSettingsModel({
    required super.lastUpdateDate,
    this.userId,
    this.newNotificationCount,
    this.name,
    this.email,
    this.phone,
    this.birthDate,
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
    this.permissions,
    this.role,
    this.photo,
    this.emergencyContacts,
    this.departmentInfo,
    this.departments,
    this.managers,
    this.teamleaders,
    this.approvalOfSubDepartments,
    this.isManagerIn,
    this.isTeamleaderIn,
    this.topManagement,
    this.departmentId,
    this.profileInfoElements,
    this.jobProfile,
    this.policies,
    this.contracts,
    this.insuranceNumber,
    this.asset,
    this.avFingerprint,
    this.userTeam,
    this.avFingerprintLocations,
  });

  factory UserSettingsModel.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(String? dateString) {
      if (dateString == null) return null;
      try {
        return DateTime.parse(dateString);
      } catch (e) {
        return null;
      }
    }

    return UserSettingsModel(
      lastUpdateDate: json['last_update_date'],
      userId: json['user_id'] as int?,
      newNotificationCount: json['new_notification_count'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      birthDate: parseDate(json['birthday'] as String?),
      emailVerifiedAt: parseDate(json['email_verified_at'] as String?),
      phoneVerifiedAt: parseDate(json['phone_verified_at'] as String?),
      permissions: (json['permissions'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      role: (json['role'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      photo: json['photo'] as String?,
      emergencyContacts: json['emergency_contacts'] as List<dynamic>?,
      departmentInfo: json['department_info'],
      departments: json['departments'] as List<dynamic>?,
      managers: json['managers'] as Map<String, dynamic>?,
      teamleaders: json['teamleaders'] as Map<String, dynamic>?,
      approvalOfSubDepartments:
      json['approval_of_sub_departments'] as List<dynamic>?,
      isManagerIn: json['is_manager_in'] as List<dynamic>?,
      isTeamleaderIn: json['is_teamleader_in'] as List<dynamic>?,
      topManagement: json['top_management'] as bool?,
      departmentId: json['department_id'],
      profileInfoElements: (json['profile_info_elements'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      jobProfile: json['job_profile'],
      policies: json['policies'],
      contracts: json['contracts'],
      insuranceNumber: json['insurance_number'],
      asset: json['asset'],
      avFingerprint: json['av_fingerprint'] as Map<String, dynamic>?,
      userTeam: json['user_team'] != null
          ? UserTeam.fromJson(json['user_team'])
          : null,
      avFingerprintLocations: json['av_fingerprint_locations'] as Map<String, dynamic>?,
    );
  }


  @override
  Map<String, dynamic> toJson() {
    String? formatDate(DateTime? date) {
      return date?.toIso8601String();
    }

    return {
      'last_update_date': lastUpdateDate,
      'user_id': userId,
      'new_notification_count': newNotificationCount,
      'name': name,
      'email': email,
      'phone': phone,
      'birthday': birthDate != null ? formatDate(birthDate) : null,
      'email_verified_at':
          emailVerifiedAt != null ? formatDate(emailVerifiedAt) : null,
      'phone_verified_at':
          phoneVerifiedAt != null ? formatDate(phoneVerifiedAt) : null,
      'permissions': permissions,
      'role': role,
      'photo': photo,
      'emergency_contacts': emergencyContacts,
      'department_info': departmentInfo,
      'departments': departments,
      'managers': managers,
      'teamleaders': teamleaders,
      'approval_of_sub_departments': approvalOfSubDepartments,
      'is_manager_in': isManagerIn,
      'is_teamleader_in': isTeamleaderIn,
      'top_management': topManagement,
      'department_id': departmentId,
      'profile_info_elements': profileInfoElements,
      'job_profile': jobProfile,
      'policies': policies,
      'contracts': contracts,
      'insurance_number': insuranceNumber,
      'asset': asset,
      'av_fingerprint': avFingerprint,
      'user_team': userTeam?.toJson(),
      'av_fingerprint_locations': avFingerprintLocations,
    };
  }
}
class UserTeam {
  final int? id;
  final String? name;
  final String? about;
  final int? points;
  final String? permssion;

  UserTeam({this.id, this.name, this.about, this.points, this.permssion,});

  factory UserTeam.fromJson(Map<String, dynamic> json) {
    return UserTeam(
      name: json['name'],
      id: json['id'],
      about: json['about'],
      points: json['points'],
      permssion: json['permssion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'about': about,
      'points' : points,
      'permssion': permssion,
    };
  }
}