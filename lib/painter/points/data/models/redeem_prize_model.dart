class RedeemPrizeModel {
  bool? status;
  String? message;
  int? id;
  String? show;

  RedeemPrizeModel({this.status, this.message, this.id, this.show});

  RedeemPrizeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    id = json['id'];
    show = json['show'];
  }
}