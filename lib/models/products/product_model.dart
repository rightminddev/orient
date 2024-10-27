import 'auto_discount_model.dart';
import 'main_cover_model.dart';

class ProductModel {
  int? id;
  String? sku;
  String? stockStatus;
  int? stock;
  String? title;
  String? description;
  String? shortDescription;
  List<MainCoverModel>? mainCover;
  int? reviewRate;
  int? reviewCount;
  int? regularPrice;
  int? sellPrice;
  int? price;
  AutoDiscountModel? autoDiscount;
  int? parentId;
  int? brandId;
  int? shippingClassId;
  int? categoryId;
  String? merchantsUnit;
  int? merchantsPrice;

  ProductModel(
      {this.id,
      this.sku,
      this.stockStatus,
      this.stock,
      this.title,
      this.description,
      this.shortDescription,
      this.mainCover,
      this.reviewRate,
      this.reviewCount,
      this.regularPrice,
      this.sellPrice,
      this.price,
      this.autoDiscount,
      this.parentId,
      this.brandId,
      this.shippingClassId,
      this.categoryId,
      this.merchantsUnit,
      this.merchantsPrice});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'];
    stockStatus = json['stock_status'];
    stock = json['stock'];
    title = json['title'];
    description = json['description'];
    shortDescription = json['short_description'];
    if (json['main_cover'] != null) {
      mainCover = <MainCoverModel>[];
      json['main_cover'].forEach((v) {
        mainCover!.add(MainCoverModel.fromJson(v));
      });
    }

    reviewRate = json['review_rate'];
    reviewCount = json['review_count'];
    regularPrice = json['regular_price'];
    sellPrice = json['sell_price'];
    price = json['price'];
    autoDiscount = json['auto_discount'] != null
        ? AutoDiscountModel.fromJson(json['auto_discount'])
        : null;
    parentId = json['parent_id'];
    brandId = json['brand_id'];
    shippingClassId = json['shipping_class_id'];
    categoryId = json['category_id'];
    merchantsUnit = json['merchants_unit'];
    merchantsPrice = json['merchants_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sku'] = sku;
    data['stock_status'] = stockStatus;
    data['stock'] = stock;
    data['title'] = title;
    data['description'] = description;
    data['short_description'] = shortDescription;
    if (mainCover != null) {
      data['main_cover'] = mainCover!.map((v) => v.toJson()).toList();
    }

    data['review_rate'] = reviewRate;
    data['review_count'] = reviewCount;
    data['regular_price'] = regularPrice;
    data['sell_price'] = sellPrice;
    data['price'] = price;
    if (autoDiscount != null) {
      data['auto_discount'] = autoDiscount!.toJson();
    }
    data['parent_id'] = parentId;
    data['brand_id'] = brandId;
    data['shipping_class_id'] = shippingClassId;
    data['category_id'] = categoryId;
    data['merchants_unit'] = merchantsUnit;
    data['merchants_price'] = merchantsPrice;
    return data;
  }
}
