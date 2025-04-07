
class NotificationSingleModel {
  final int? id;
  final String? title;
  final List<Thumbnail>? mainThumbnail;
  final List<FileModel>? mainGallery;
  final String? content;
  final List<SendType>? sendType;
  final PType? ptype;
  final PFor? pfor;
  final List<PForValue>? pforValue;
  // final List<dynamic>? pforUserRoles;
  final List<PForUser>? pforUsers;
  // final List<dynamic>? pforUsersWhen;
  final CommentStatus? commentStatus;
  // final dynamic customWidgets;
  final String? createdAt;
  final Status? status;
  final String? scheduleDate;
  final Action? action;
  bool? seen;
  NotificationSingleModel({
    this.id,
    this.title,
    this.mainThumbnail,
    this.mainGallery,
    this.content,
    this.sendType,
    this.ptype,
    this.pfor,
    this.pforValue,
    // this.pforUserRoles,
    this.pforUsers,
    // this.pforUsersWhen,
    this.commentStatus,
    // this.customWidgets,
    this.createdAt,
    this.status,
    this.scheduleDate,
    this.action,
    this.seen,
  });

  factory NotificationSingleModel.fromJson(Map<String, dynamic> json) {
    return NotificationSingleModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      mainThumbnail: (json['main_thumbnail'] as List<dynamic>?)
          ?.map((item) => Thumbnail.fromJson(item))
          .toList(),
      mainGallery: (json['main_gallery'] as List<dynamic>?)
          ?.map((item) => FileModel.fromJson(item))
          .toList(),
      content: json['content'] as String?,
      // sendType: (json['send_type'] as List<dynamic>?)
      //     ?.map((item) => SendType.fromJson(item))
      //     .toList(),
      // ptype: json['ptype'] != null ? PType.fromJson(json['ptype']) : null,
      // pfor: json['pfor'] != null ? PFor.fromJson(json['pfor']) : null,
      // pforValue: (json['pfor_value'] as List<dynamic>?)
      //     ?.map((item) => PForValue.fromJson(item))
      //     .toList(),
      // pforUserRoles: json['pfor_user_roles'] as List<dynamic>?,
      // pforUsers: (json['pfor_users'] as List<dynamic>?)
      //     ?.map((item) => PForUser.fromJson(item))
      //     .toList(),
      // pforUsersWhen: json['pfor_users_when'] as List<dynamic>?,
      // commentStatus: json['comment_status'] != null
      //     ? CommentStatus.fromJson(json['comment_status'])
      //     : null,
      // customWidgets: json['custom_widgets'],
      createdAt: json['created_at'] as String?,
      //status: json['status'] != null ? Status.fromJson(json['status']) : null,
      //scheduleDate: json['schedule_date'] as String?,
      //action: json['action'] != null ? Action.fromJson(json['action']) : null,
      seen: json['seen'] as bool?,
    );
  }
}

class Thumbnail {
  final int? id;
  final String? type;
  final String? title;
  final String? alt;
  final String? file;
  final String? thumbnail;

  Thumbnail({
    this.id,
    this.type,
    this.title,
    this.alt,
    this.file,
    this.thumbnail,
  });

  factory Thumbnail.fromJson(Map<String, dynamic> json) {
    return Thumbnail(
      id: json['id'] as int?,
      type: json['type'] as String?,
      title: json['title'] as String?,
      alt: json['alt'] as String?,
      file: json['file'] as String?,
      thumbnail: json['thumbnail'] as String?,
    );
  }
}

class SendType {
  final String? key;
  final String? value;

  SendType({this.key, this.value});

  factory SendType.fromJson(Map<String, dynamic> json) {
    return SendType(
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

class PType {
  final String? key;
  final String? value;

  PType({this.key, this.value});

  factory PType.fromJson(Map<String, dynamic> json) {
    return PType(
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

class PFor {
  final String? key;
  final String? value;

  PFor({this.key, this.value});

  factory PFor.fromJson(Map<String, dynamic> json) {
    return PFor(
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

class PForValue {
  final String? value;
  final String? label;

  PForValue({this.value, this.label});

  factory PForValue.fromJson(Map<String, dynamic> json) {
    return PForValue(
      value: json['value'] as String?,
      label: json['label'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'label': label,
    };
  }
}

class PForUser {
  final int? key;
  final String? value;

  PForUser({this.key, this.value});

  factory PForUser.fromJson(Map<String, dynamic> json) {
    return PForUser(
      key: json['key'] is int? ? json['key'] : int.tryParse(json['key']) ?? 0,
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

class CommentStatus {
  final String? key;
  final String? value;

  CommentStatus({this.key, this.value});

  factory CommentStatus.fromJson(Map<String, dynamic> json) {
    return CommentStatus(
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

class FileModel {
  int? id;
  String? type;
  String? title;
  String? alt;
  String? file;
  String? thumbnail;

  FileModel({
    this.id,
    this.type,
    this.title,
    this.alt,
    this.file,
    this.thumbnail,
  });

  FileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    title = json['title'];
    alt = json['alt'];
    file = json['file'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['title'] = title;
    data['alt'] = alt;
    data['file'] = file;
    data['thumbnail'] = thumbnail;

    return data;
  }
}
