import '../products/add_product_model.dart';

class RequestModel {
  List<AddedProductsModel>? items;
  RequestModel({this.items});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
