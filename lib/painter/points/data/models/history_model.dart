class HistoryModel {
  bool? status;
  String? message;
  List<History>? history;

  HistoryModel({this.status, this.message, this.history});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history!.add(History.fromJson(v));
      });
    }
  }
}

class History {
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

  History(
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
        this.updatedAt
      });

  History.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    type = json['type'];
    operation = json['operation'];
    points = json['points'];
    data = json['data'];
    checked = json['checked'];
    notes = json['notes']??'';
    createdAt = json['created_at']??'';
    updatedAt = json['updated_at']??'';
  }
}