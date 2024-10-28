class UpdateCartModel {
  bool? status;
  String? message;
  Cart? cart;

  UpdateCartModel({this.status, this.message, this.cart});

  UpdateCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    cart = json['cart'] != null ? new Cart.fromJson(json['cart']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.cart != null) {
      data['cart'] = this.cart!.toJson();
    }
    return data;
  }
}

class Cart {
  int? id;
  String? status;
  String? uuid;
  int? subTotal;
  int? discountTotal;
  int? feesTotal;
  int? taxesTotal;
  int? shippingCost;
  Null? appliedCoupon;
  int? total;
  List<Items>? items;

  Cart(
      {this.id,
        this.status,
        this.uuid,
        this.subTotal,
        this.discountTotal,
        this.feesTotal,
        this.taxesTotal,
        this.shippingCost,
        this.appliedCoupon,
        this.total,
        this.items});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    uuid = json['uuid'];
    subTotal = json['sub_total'];
    discountTotal = json['discount_total'];
    feesTotal = json['fees_total'];
    taxesTotal = json['taxes_total'];
    shippingCost = json['shipping_cost'];
    appliedCoupon = json['applied_coupon'];
    total = json['total'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['uuid'] = this.uuid;
    data['sub_total'] = this.subTotal;
    data['discount_total'] = this.discountTotal;
    data['fees_total'] = this.feesTotal;
    data['taxes_total'] = this.taxesTotal;
    data['shipping_cost'] = this.shippingCost;
    data['applied_coupon'] = this.appliedCoupon;
    data['total'] = this.total;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? id;
  int? productId;
  int? quantity;
  int? price;
  int? priceAfterDiscount;
  String? title;
  List<Image>? image;
  String? sku;
  String? description;
  int? isGift;
  Null? giftReason;
  int? isWishlistProduct;
  int? isPreOrdered;
  int? isRemoved;
  String? removedReason;

  Items(
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

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    price = json['price'];
    priceAfterDiscount = json['price_after_discount'];
    title = json['title'];
    if (json['image'] != null) {
      image = <Image>[];
      json['image'].forEach((v) {
        image!.add(new Image.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['price_after_discount'] = this.priceAfterDiscount;
    data['title'] = this.title;
    if (this.image != null) {
      data['image'] = this.image!.map((v) => v.toJson()).toList();
    }
    data['sku'] = this.sku;
    data['description'] = this.description;
    data['is_gift'] = this.isGift;
    data['gift_reason'] = this.giftReason;
    data['is_wishlist_product'] = this.isWishlistProduct;
    data['is_pre_ordered'] = this.isPreOrdered;
    data['is_removed'] = this.isRemoved;
    data['removed_reason'] = this.removedReason;
    return data;
  }
}

class Image {
  int? id;
  String? type;
  String? title;
  String? alt;
  String? file;
  String? thumbnail;
  Sizes? sizes;

  Image(
      {this.id,
        this.type,
        this.title,
        this.alt,
        this.file,
        this.thumbnail,
        this.sizes});

  Image.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    title = json['title'];
    alt = json['alt'];
    file = json['file'];
    thumbnail = json['thumbnail'];
    sizes = json['sizes'] != null ? new Sizes.fromJson(json['sizes']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['title'] = this.title;
    data['alt'] = this.alt;
    data['file'] = this.file;
    data['thumbnail'] = this.thumbnail;
    if (this.sizes != null) {
      data['sizes'] = this.sizes!.toJson();
    }
    return data;
  }
}

class Sizes {
  String? thumbnail;
  String? medium;
  String? large;

  Sizes({this.thumbnail, this.medium, this.large});

  Sizes.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    medium = json['medium'];
    large = json['large'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumbnail'] = this.thumbnail;
    data['medium'] = this.medium;
    data['large'] = this.large;
    return data;
  }
}
