import '../products/add_product_model.dart';

class RequestModel {
  List<AddedProductsModel>? items;
  var name;
  RequestModel({this.items,required this.name});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (items != null) {
      data[name] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
