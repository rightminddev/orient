class TermsAndConditionsModel {
  bool? status;
  String? message;
  Page? page;

  TermsAndConditionsModel({this.status, this.message, this.page});

  TermsAndConditionsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    page = json['page'] != null ? Page.fromJson(json['page']) : null;
  }
}

class Page {
  int? id;
  String? title;
  String? slug;
  String? type;
  String? content;

  Page({this.id, this.title, this.slug, this.type, this.content});

  Page.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    type = json['type'];
    content = json['content'];
  }
}