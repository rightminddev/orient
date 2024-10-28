class PivotModel {
  int? teamId;
  int? userId;
  String? status;

  PivotModel({this.teamId, this.userId, this.status});

  PivotModel.fromJson(Map<String, dynamic> json) {
    teamId = json['team_id'];
    userId = json['user_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['team_id'] = teamId;
    data['user_id'] = userId;
    data['status'] = status;
    return data;
  }
}
