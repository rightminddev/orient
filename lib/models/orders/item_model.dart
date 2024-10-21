import '../general/image_model.dart';

class ItemModel {
  int? id;
  int? productId;
  int? quantity;
  int? price;
  int? priceAfterDiscount;
  String? title;
  List<ImageModel>? image;
  String? sku;
  String? description;
  int? isGift;
  String? giftReason;
  int? isWishlistProduct;
  int? isPreOrdered;
  int? isRemoved;
  String? removedReason;

  ItemModel(
      {this.id,
      this.productId,
      this.quantity,
      this.price,
      this.priceAfterDiscount,
      this.title,
      this.image,
      this.sku,
      this.description,
      this.isGift,
      this.giftReason,
      this.isWishlistProduct,
      this.isPreOrdered,
      this.isRemoved,
      this.removedReason});

  ItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    price = json['price'];
    priceAfterDiscount = json['price_after_discount'];
    title = json['title'];
    if (json['image'] != null) {
      image = <ImageModel>[];
      json['image'].forEach((v) {
        image!.add(ImageModel.fromJson(v));
      });
    }
    sku = json['sku'];
    description = json['description'];
    isGift = json['is_gift'];
    giftReason = json['gift_reason'];
    isWishlistProduct = json['is_wishlist_product'];
    isPreOrdered = json['is_pre_ordered'];
    isRemoved = json['is_removed'];
    removedReason = json['removed_reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['quantity'] = quantity;
    data['price'] = price;
    data['price_after_discount'] = priceAfterDiscount;
    data['title'] = title;
    if (image != null) {
      data['image'] = image!.map((v) => v.toJson()).toList();
    }
    data['sku'] = sku;
    data['description'] = description;
    data['is_gift'] = isGift;
    data['gift_reason'] = giftReason;
    data['is_wishlist_product'] = isWishlistProduct;
    data['is_pre_ordered'] = isPreOrdered;
    data['is_removed'] = isRemoved;
    data['removed_reason'] = removedReason;
    return data;
  }
}
