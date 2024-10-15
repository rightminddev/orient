class AvailabilityModel {
  List<AddedProductsModel>? products;
  AvailabilityModel({this.products});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (products != null) {
      data['availabilities'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddedProductsModel {
  int? productId;
  int? quantity;

  AddedProductsModel({this.productId, this.quantity});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['quantity'] = quantity;
    return data;
  }
}
