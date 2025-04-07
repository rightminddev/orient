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
