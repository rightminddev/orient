class PointsModel {
  int? id;
  int? userId;
  String? title;
  String? type;
  String? operation;
  int? points;
  String? data;
  int? checked;
  String? notes;
  String? createdAt;
  String? updatedAt;

  PointsModel(
      {this.id,
      this.userId,
      this.title,
      this.type,
      this.operation,
      this.points,
      this.data,
      this.checked,
      this.notes,
      this.createdAt,
      this.updatedAt});

  PointsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    type = json['type'];
    operation = json['operation'];
    points = json['points'];
    data = json['data'];
    checked = json['checked'];
    notes = json['notes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['title'] = title;
    data['type'] = type;
    data['operation'] = operation;
    data['points'] = points;
    data['data'] = this.data;
    data['checked'] = checked;
    data['notes'] = notes;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
