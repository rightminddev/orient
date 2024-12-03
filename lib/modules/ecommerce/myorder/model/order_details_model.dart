class OrderDetailsModel {
  bool? status;
  String? message;
  Order? order;

  OrderDetailsModel({this.status, this.message, this.order});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    return data;
  }
}

class Order {
  int? id;
  String? status;
  String? merchantStatus;
  String? uuid;
  int? subTotal;
  int? discountTotal;
  int? feesTotal;
  int? taxesTotal;
  int? shippingCost;
  int? total;
  String? date;
  ShippingInfo? shippingInfo;
  PaymentGateway? paymentGateway;
  String? customerName;
  int? customerId;
  List<Items>? items;

  Order(
      {this.id,
        this.status,
        this.merchantStatus,
        this.uuid,
        this.subTotal,
        this.discountTotal,
        this.feesTotal,
        this.taxesTotal,
        this.shippingCost,
        this.total,
        this.date,
        this.shippingInfo,
        this.paymentGateway,
        this.customerName,
        this.customerId,
        this.items});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    merchantStatus = json['merchant_status'];
    uuid = json['uuid'];
    subTotal = json['sub_total'];
    discountTotal = json['discount_total'];
    feesTotal = json['fees_total'];
    taxesTotal = json['taxes_total'];
    shippingCost = json['shipping_cost'];
    total = json['total'];
    date = json['date'];
    shippingInfo = json['shipping_info'] != null
        ? new ShippingInfo.fromJson(json['shipping_info'])
        : null;
    paymentGateway = json['payment_gateway'] != null
        ? new PaymentGateway.fromJson(json['payment_gateway'])
        : null;
    customerName = json['customer_name'];
    customerId = json['customer_id'];
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
    data['merchant_status'] = this.merchantStatus;
    data['uuid'] = this.uuid;
    data['sub_total'] = this.subTotal;
    data['discount_total'] = this.discountTotal;
    data['fees_total'] = this.feesTotal;
    data['taxes_total'] = this.taxesTotal;
    data['shipping_cost'] = this.shippingCost;
    data['total'] = this.total;
    data['date'] = this.date;
    if (this.shippingInfo != null) {
      data['shipping_info'] = this.shippingInfo!.toJson();
    }
    if (this.paymentGateway != null) {
      data['payment_gateway'] = this.paymentGateway!.toJson();
    }
    data['customer_name'] = this.customerName;
    data['customer_id'] = this.customerId;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShippingInfo {
  int? id;
  String? type;
  int? zoneId;
  String? zone;
  int? countryId;
  String? country;
  int? stateId;
  String? state;
  int? cityId;
  String? city;
  int? shippingCost;
  String? addressText;

  ShippingInfo(
      {this.id,
        this.type,
        this.zoneId,
        this.zone,
        this.countryId,
        this.country,
        this.stateId,
        this.state,
        this.cityId,
        this.city,
        this.shippingCost,
        this.addressText});

  ShippingInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    zoneId = json['zone_id'];
    zone = json['zone'];
    countryId = json['country_id'];
    country = json['country'];
    stateId = json['state_id'];
    state = json['state'];
    cityId = json['city_id'];
    city = json['city'];
    shippingCost = json['shipping_cost'];
    addressText = json['address_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['zone_id'] = this.zoneId;
    data['zone'] = this.zone;
    data['country_id'] = this.countryId;
    data['country'] = this.country;
    data['state_id'] = this.stateId;
    data['state'] = this.state;
    data['city_id'] = this.cityId;
    data['city'] = this.city;
    data['shipping_cost'] = this.shippingCost;
    data['address_text'] = this.addressText;
    return data;
  }
}

class PaymentGateway {
  int? id;
  String? title;
  List<Logo>? logo;

  PaymentGateway({this.id, this.title, this.logo});

  PaymentGateway.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['logo'] != null) {
      logo = <Logo>[];
      json['logo'].forEach((v) {
        logo!.add(new Logo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.logo != null) {
      data['logo'] = this.logo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Logo {
  int? id;
  String? type;
  String? title;
  String? alt;
  String? file;
  String? thumbnail;
  Sizes? sizes;

  Logo(
      {this.id,
        this.type,
        this.title,
        this.alt,
        this.file,
        this.thumbnail,
        this.sizes});

  Logo.fromJson(Map<String, dynamic> json) {
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

  Sizes(
      {this.thumbnail,
        this.medium,
        this.large,
        this.s1200800,
        this.s8001200,
        this.s1200300,
        this.s3001200});

  Sizes.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    medium = json['medium'];
    large = json['large'];
    s1200800 = json['1200_800'];
    s8001200 = json['800_1200'];
    s1200300 = json['1200_300'];
    s3001200 = json['300_1200'];
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
    return data;
  }
}

class Items {
  int? id;
  int? productId;
  int? quantity;
  int? priceBeforeDiscount;
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
        this.priceBeforeDiscount,
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
    priceBeforeDiscount = json['price_before_discount'];
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
    data['price_before_discount'] = this.priceBeforeDiscount;
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
  SizesImage? sizes;

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
    sizes = json['sizes'] != null ? new SizesImage.fromJson(json['sizes']) : null;
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

class SizesImage {
  String? thumbnail;
  String? medium;
  String? large;
  String? s1200800;
  String? s8001200;
  String? s1200300;
  String? s3001200;
  String? aboutOud23908Webp;
  String? aboutOud23908JpgWebp;

  SizesImage(
      {this.thumbnail,
        this.medium,
        this.large,
        this.s1200800,
        this.s8001200,
        this.s1200300,
        this.s3001200,
        this.aboutOud23908Webp,
        this.aboutOud23908JpgWebp});

  SizesImage.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    medium = json['medium'];
    large = json['large'];
    s1200800 = json['1200_800'];
    s8001200 = json['800_1200'];
    s1200300 = json['1200_300'];
    s3001200 = json['300_1200'];
    aboutOud23908Webp = json['About-Oud-23908_webp'];
    aboutOud23908JpgWebp = json['About-Oud-23908.jpg_webp'];
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
    data['About-Oud-23908_webp'] = this.aboutOud23908Webp;
    data['About-Oud-23908.jpg_webp'] = this.aboutOud23908JpgWebp;
    return data;
  }
}
