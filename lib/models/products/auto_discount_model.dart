class AutoDiscountModel {
  int? id;
  int? discountId;
  String? discountType;
  int? discountValue;
  String? isFreeShipping;
  int? maxValue;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  AutoDiscountModel(
      {this.id,
      this.discountId,
      this.discountType,
      this.discountValue,
      this.isFreeShipping,
      this.maxValue,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  AutoDiscountModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    discountId = json['discount_id'];
    discountType = json['discount_type'];
    discountValue = json['discount_value'];
    isFreeShipping = json['is_free_shipping'];
    maxValue = json['max_value'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['discount_id'] = discountId;
    data['discount_type'] = discountType;
    data['discount_value'] = discountValue;
    data['is_free_shipping'] = isFreeShipping;
    data['max_value'] = maxValue;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
