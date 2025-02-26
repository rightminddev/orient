import 'package:orient/models/products/add_product_model.dart';

class AvailableModel {
  List<AddedProductsModel>? availabilities;
  AvailableModel({this.availabilities});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (availabilities != null) {
      data['availabilities'] = availabilities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}