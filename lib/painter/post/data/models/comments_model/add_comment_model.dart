class AddCommentModel {
  bool? status;
  String? message;
  Comment? comment;

  AddCommentModel({this.status, this.message, this.comment});

  AddCommentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    comment =
    json['comment'] != null ? Comment.fromJson(json['comment']) : null;
  }
}

class Comment {
  int? id;
  String? content;
  String? createdAt;
  String? updatedAt;

  Comment(
      {this.id,
        this.content,
        this.createdAt,
        this.updatedAt});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}