import 'package:collection/collection.dart';

class CompanyTreeNodeModel {
  final String avatar;
  final String name;
  final int id;
  final String? departmentId;
  final String? jobTitle;
  final List<int> next;

  CompanyTreeNodeModel({
    required this.avatar,
    required this.name,
    required this.id,
    this.departmentId,
    this.jobTitle,
    required this.next,
  });

  factory CompanyTreeNodeModel.fromJson(Map<String, dynamic> json) {
    return CompanyTreeNodeModel(
      avatar: json['avatar'] as String,
      name: json['name'] as String,
      id: json['id'] as int,
      departmentId: json['department_id'] as String?,
      jobTitle: json['job_title'] as String?,
      next: List<int>.from(json['next'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'avatar': avatar,
      'name': name,
      'id': id,
      'department_id': departmentId,
      'job_title': jobTitle,
      'next': next,
    };
  }

  CompanyTreeNodeModel copyWith({
    String? avatar,
    String? name,
    int? id,
    String? departmentId,
    String? jobTitle,
    List<int>? next,
  }) {
    return CompanyTreeNodeModel(
      avatar: avatar ?? this.avatar,
      name: name ?? this.name,
      id: id ?? this.id,
      departmentId: departmentId ?? this.departmentId,
      jobTitle: jobTitle ?? this.jobTitle,
      next: next ?? this.next,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CompanyTreeNodeModel &&
        other.avatar == avatar &&
        other.name == name &&
        other.id == id &&
        other.departmentId == departmentId &&
        other.jobTitle == jobTitle &&
        const ListEquality().equals(other.next, next);
  }

  @override
  int get hashCode {
    return avatar.hashCode ^
        name.hashCode ^
        id.hashCode ^
        departmentId.hashCode ^
        jobTitle.hashCode ^
        next.hashCode;
  }

  @override
  String toString() {
    return 'CompanyStructure(avatar: $avatar, name: $name, id: $id, departmentId: $departmentId, jobTitle: $jobTitle, next: $next)';
  }
}
