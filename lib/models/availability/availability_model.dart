import '../products/add_product_model.dart';

class AvailabilityModel {
  List<AddedProductsModel>? items;
  AvailabilityModel({this.items});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (items != null) {
      data['availabilities'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
