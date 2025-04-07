class CopounModel {
  bool? status;
  String? message;

  CopounModel({this.status, this.message});

  CopounModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}