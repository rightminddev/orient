class MemberModel {
  int? id;
  String? name;
  String? phone;
  String? avatarUrl;
  Pivot? pivot;

  MemberModel({this.id, this.name, this.phone, this.avatarUrl, this.pivot});

  MemberModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    avatarUrl = json['avatar_url'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['avatar_url'] = this.avatarUrl;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? teamId;
  int? userId;
  String? status;

  Pivot({this.teamId, this.userId, this.status});

  Pivot.fromJson(Map<String, dynamic> json) {
    teamId = json['team_id'];
    userId = json['user_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_id'] = this.teamId;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    return data;
  }
}
