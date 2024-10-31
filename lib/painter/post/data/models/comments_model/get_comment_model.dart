class GetCommentModel {
  bool? status;
  String? message;
  List<Comments>? comments;

  GetCommentModel({this.status, this.message, this.comments});

  GetCommentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
  }
}

class Comments {
  int? id;
  String? content;
  String? createdAt;
  String? updatedAt;

  Comments(
      {this.id,
        this.content,
        this.createdAt,
        this.updatedAt});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}