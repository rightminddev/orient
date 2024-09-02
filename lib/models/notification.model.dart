class NotificationModel {
  final int? id;
  final String? title;
  final List<Thumbnail>? mainThumbnail;
  final List<Gallery>? mainGallery;
  final String? content;
  final List<SendType>? sendType;
  final PType? ptype;
  final PFor? pfor;
  final List<PForValue>? pforValue;
  final List<dynamic>? pforUserRoles;
  final List<PForUser>? pforUsers;
  final List<dynamic>? pforUsersWhen;
  final CommentStatus? commentStatus;
  final dynamic customWidgets;
  final String? createdAt;
  final Status? status;
  final String? scheduleDate;
  final Action? action;

  NotificationModel({
    this.id,
    this.title,
    this.mainThumbnail,
    this.mainGallery,
    this.content,
    this.sendType,
    this.ptype,
    this.pfor,
    this.pforValue,
    this.pforUserRoles,
    this.pforUsers,
    this.pforUsersWhen,
    this.commentStatus,
    this.customWidgets,
    this.createdAt,
    this.status,
    this.scheduleDate,
    this.action,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      mainThumbnail: (json['main_thumbnail'] as List<dynamic>?)
          ?.map((item) => Thumbnail.fromJson(item))
          .toList(),
      mainGallery: (json['main_gallery'] as List<dynamic>?)
          ?.map((item) => Gallery.fromJson(item))
          .toList(),
      content: json['content'] as String?,
      sendType: (json['send_type'] as List<dynamic>?)
          ?.map((item) => SendType.fromJson(item))
          .toList(),
      ptype: json['ptype'] != null ? PType.fromJson(json['ptype']) : null,
      pfor: json['pfor'] != null ? PFor.fromJson(json['pfor']) : null,
      pforValue: (json['pfor_value'] as List<dynamic>?)
          ?.map((item) => PForValue.fromJson(item))
          .toList(),
      pforUserRoles: json['pfor_user_roles'] as List<dynamic>?,
      pforUsers: (json['pfor_users'] as List<dynamic>?)
          ?.map((item) => PForUser.fromJson(item))
          .toList(),
      pforUsersWhen: json['pfor_users_when'] as List<dynamic>?,
      commentStatus: json['comment_status'] != null
          ? CommentStatus.fromJson(json['comment_status'])
          : null,
      customWidgets: json['custom_widgets'],
      createdAt: json['created_at'] as String?,
      status: json['status'] != null ? Status.fromJson(json['status']) : null,
      scheduleDate: json['schedule_date'] as String?,
      action: json['action'] != null ? Action.fromJson(json['action']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'main_thumbnail': mainThumbnail?.map((item) => item.toJson()).toList(),
      'main_gallery': mainGallery?.map((item) => item.toJson()).toList(),
      'content': content,
      'send_type': sendType?.map((item) => item.toJson()).toList(),
      'ptype': ptype?.toJson(),
      'pfor': pfor?.toJson(),
      'pfor_value': pforValue?.map((item) => item.toJson()).toList(),
      'pfor_user_roles': pforUserRoles,
      'pfor_users': pforUsers?.map((item) => item.toJson()).toList(),
      'pfor_users_when': pforUsersWhen,
      'comment_status': commentStatus?.toJson(),
      'custom_widgets': customWidgets,
      'created_at': createdAt,
      'status': status?.toJson(),
      'schedule_date': scheduleDate,
      'action': action?.toJson(),
    };
  }
}

class Thumbnail {
  final int? id;
  final String? type;
  final String? title;
  final String? alt;
  final String? file;
  final String? thumbnail;
  final Sizes? sizes;

  Thumbnail({
    this.id,
    this.type,
    this.title,
    this.alt,
    this.file,
    this.thumbnail,
    this.sizes,
  });

  factory Thumbnail.fromJson(Map<String, dynamic> json) {
    return Thumbnail(
      id: json['id'] as int?,
      type: json['type'] as String?,
      title: json['title'] as String?,
      alt: json['alt'] as String?,
      file: json['file'] as String?,
      thumbnail: json['thumbnail'] as String?,
      sizes: json['sizes'] != null ? Sizes.fromJson(json['sizes']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'alt': alt,
      'file': file,
      'thumbnail': thumbnail,
      'sizes': sizes?.toJson(),
    };
  }
}

class Gallery {
  final int? id;
  final String? type;
  final String? title;
  final String? alt;
  final String? file;
  final String? thumbnail;
  final Sizes? sizes;

  Gallery({
    this.id,
    this.type,
    this.title,
    this.alt,
    this.file,
    this.thumbnail,
    this.sizes,
  });

  factory Gallery.fromJson(Map<String, dynamic> json) {
    return Gallery(
      id: json['id'] as int?,
      type: json['type'] as String?,
      title: json['title'] as String?,
      alt: json['alt'] as String?,
      file: json['file'] as String?,
      thumbnail: json['thumbnail'] as String?,
      sizes: json['sizes'] != null ? Sizes.fromJson(json['sizes']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'alt': alt,
      'file': file,
      'thumbnail': thumbnail,
      'sizes': sizes?.toJson(),
    };
  }
}

class Sizes {
  final String? thumbnail;
  final String? medium;
  final String? large;
  final String? s1200800;
  final String? s8001200;
  final String? s1200300;
  final String? s3001200;
  final String? webp;

  Sizes({
    this.thumbnail,
    this.medium,
    this.large,
    this.s1200800,
    this.s8001200,
    this.s1200300,
    this.s3001200,
    this.webp,
  });

  factory Sizes.fromJson(Map<String, dynamic> json) {
    return Sizes(
      thumbnail: json['thumbnail'] as String?,
      medium: json['medium'] as String?,
      large: json['large'] as String?,
      s1200800: json['1200_800'] as String?,
      s8001200: json['800_1200'] as String?,
      s1200300: json['1200_300'] as String?,
      s3001200: json['300_1200'] as String?,
      webp: json['agent-65026_webp'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'thumbnail': thumbnail,
      'medium': medium,
      'large': large,
      '1200_800': s1200800,
      '800_1200': s8001200,
      '1200_300': s1200300,
      '300_1200': s3001200,
      'agent-65026_webp': webp,
    };
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
  final String? key;
  final String? value;

  PForUser({this.key, this.value});

  factory PForUser.fromJson(Map<String, dynamic> json) {
    return PForUser(
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
