class FaqModel {
  bool? status;
  String? message;
  Page? page;

  FaqModel({this.status, this.message, this.page});

  FaqModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    page = json['page'] != null ? new Page.fromJson(json['page']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.page != null) {
      data['page'] = this.page!.toJson();
    }
    return data;
  }
}

class Page {
  int? id;
  String? title;
  String? slug;
  List<Questions>? questions;

  Page({this.id, this.title, this.slug, this.questions});

  Page.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  String? question;
  String? answer;

  Questions({this.question, this.answer});

  Questions.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['answer'] = this.answer;
    return data;
  }
}
