class SingleProductModel {
  bool? status;
  String? message;
  Product? product;

  SingleProductModel({this.status, this.message, this.product});

   SingleProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? sku;
  String? stockStatus;
  String? title;
  String? description;
  var shortDescription;
  List<MainCover>? mainCover;
  int? length;
  int? width;
  int? height;
  var weight;
  String? status;
  String? type;
  var searchQueries;
  var purchaseNote;
  var videos;
  List<Null>? images;
  List<Null>? threeDModel;
  List<Null>? image360Panorama;
  List<Null>? pdf;
  int? quantity;
  var limitOrderPurchases;
  var limitOrderPurchasesTime;
  var limitOrderPurchasesTimeCount;
  int? reviewRate;
  int? reviewCount;
  int? commentsCount;
  var price_before_discount;
  var price_after_discount;
  AutoDiscount? autoDiscount;
  var manualDiscount;
  int? parentId;
  var brandId;
  int? shippingClassId;
  int? categoryId;

  Product(
      {this.id,
        this.sku,
        this.stockStatus,
        this.title,
        this.description,
        this.shortDescription,
        this.mainCover,
        this.length,
        this.width,
        this.height,
        this.weight,
        this.status,
        this.type,
        this.searchQueries,
        this.purchaseNote,
        this.videos,
        this.images,
        this.threeDModel,
        this.image360Panorama,
        this.pdf,
        this.quantity,
        this.limitOrderPurchases,
        this.limitOrderPurchasesTime,
        this.limitOrderPurchasesTimeCount,
        this.reviewRate,
        this.reviewCount,
        this.commentsCount,
        this.price_before_discount,
        this.price_after_discount,
        this.autoDiscount,
        this.manualDiscount,
        this.parentId,
        this.brandId,
        this.shippingClassId,
        this.categoryId});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'];
    stockStatus = json['stock_status'];
    title = json['title'];
    description = json['description'];
    shortDescription = json['short_description'];
    if (json['main_cover'] != null) {
      mainCover = <MainCover>[];
      json['main_cover'].forEach((v) {
        mainCover!.add(new MainCover.fromJson(v));
      });
    }
    length = json['length'];
    width = json['width'];
    height = json['height'];
    weight = json['weight'];
    status = json['status'];
    type = json['type'];
    searchQueries = json['search_queries'];
    purchaseNote = json['purchase_note'];
    videos = json['videos'];
    quantity = json['quantity'];
    limitOrderPurchases = json['limit_order_purchases'];
    limitOrderPurchasesTime = json['limit_order_purchases_time'];
    limitOrderPurchasesTimeCount = json['limit_order_purchases_time_count'];
    reviewRate = json['review_rate'];
    reviewCount = json['review_count'];
    commentsCount = json['comments_count'];
    price_before_discount = json['price_before_discount'];
    price_after_discount = json['price_after_discount'];
    autoDiscount = json['auto_discount'] != null
        ? new AutoDiscount.fromJson(json['auto_discount'])
        : null;
    manualDiscount = json['manual_discount'];
    parentId = json['parent_id'];
    brandId = json['brand_id'];
    shippingClassId = json['shipping_class_id'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sku'] = this.sku;
    data['stock_status'] = this.stockStatus;
    data['title'] = this.title;
    data['description'] = this.description;
    data['short_description'] = this.shortDescription;
    if (this.mainCover != null) {
      data['main_cover'] = this.mainCover!.map((v) => v.toJson()).toList();
    }
    data['length'] = this.length;
    data['width'] = this.width;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['status'] = this.status;
    data['type'] = this.type;
    data['search_queries'] = this.searchQueries;
    data['purchase_note'] = this.purchaseNote;
    data['videos'] = this.videos;
    data['quantity'] = this.quantity;
    data['limit_order_purchases'] = this.limitOrderPurchases;
    data['limit_order_purchases_time'] = this.limitOrderPurchasesTime;
    data['limit_order_purchases_time_count'] =
        this.limitOrderPurchasesTimeCount;
    data['review_rate'] = this.reviewRate;
    data['review_count'] = this.reviewCount;
    data['comments_count'] = this.commentsCount;
    data['price_after_discount'] = this.price_after_discount;
    data['price_before_discount'] = this.price_before_discount;
    if (this.autoDiscount != null) {
      data['auto_discount'] = this.autoDiscount!.toJson();
    }
    data['manual_discount'] = this.manualDiscount;
    data['parent_id'] = this.parentId;
    data['brand_id'] = this.brandId;
    data['shipping_class_id'] = this.shippingClassId;
    data['category_id'] = this.categoryId;
    return data;
  }
}

class MainCover {
  int? id;
  String? type;
  String? title;
  String? alt;
  String? file;
  String? thumbnail;
  Sizes? sizes;

  MainCover(
      {this.id,
        this.type,
        this.title,
        this.alt,
        this.file,
        this.thumbnail,
        this.sizes});

  MainCover.fromJson(Map<String, dynamic> json) {
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
  String? s1200800;
  String? s8001200;
  String? s1200300;
  String? s3001200;
  String? image9Webp;
  String? image9PngWebp;

  Sizes(
      {this.thumbnail,
        this.medium,
        this.large,
        this.s1200800,
        this.s8001200,
        this.s1200300,
        this.s3001200,
        this.image9Webp,
        this.image9PngWebp});

  Sizes.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    medium = json['medium'];
    large = json['large'];
    s1200800 = json['1200_800'];
    s8001200 = json['800_1200'];
    s1200300 = json['1200_300'];
    s3001200 = json['300_1200'];
    image9Webp = json['Image--9-_webp'];
    image9PngWebp = json['Image--9-.png_webp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumbnail'] = this.thumbnail;
    data['medium'] = this.medium;
    data['large'] = this.large;
    data['1200_800'] = this.s1200800;
    data['800_1200'] = this.s8001200;
    data['1200_300'] = this.s1200300;
    data['300_1200'] = this.s3001200;
    data['Image--9-_webp'] = this.image9Webp;
    data['Image--9-.png_webp'] = this.image9PngWebp;
    return data;
  }
}

class AutoDiscount {
  int? id;
  int? discountId;
  String? discountType;
  int? discountValue;
  String? isFreeShipping;
  var maxValue;
  int? createdBy;
  var updatedBy;
  String? createdAt;
  String? updatedAt;
  var deletedAt;

  AutoDiscount(
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

  AutoDiscount.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['discount_id'] = this.discountId;
    data['discount_type'] = this.discountType;
    data['discount_value'] = this.discountValue;
    data['is_free_shipping'] = this.isFreeShipping;
    data['max_value'] = this.maxValue;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
