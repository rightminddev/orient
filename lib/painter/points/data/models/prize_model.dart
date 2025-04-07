class PrizeModel {
  bool? status;
  String? message;
  List<String>? prizes;

  PrizeModel({this.status, this.message, this.prizes});

  PrizeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    prizes = json['prizes'].cast<String>();
  }
}