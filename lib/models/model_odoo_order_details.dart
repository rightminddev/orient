class OdooOrderDetailsModel {
  var status;
  var message;
  Order? order;

  OdooOrderDetailsModel({this.status, this.message, this.order});

  OdooOrderDetailsModel.fromJson(Map<String, dynamic> json) {
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
  var clientId;
  var clientName;
  var clientMobile;
  var partnerShippingId;
  var partnerAddressName;
  var clientEmail;
  var clientStreet;
  var statesOfOrder;
  var clientStreet2;
  var salesPersonAssist;
  var orderNotes;
  var clientCity;
  var clientStateName;
  var clientCountryName;
  var salesOrderId;
  var salesOrderName;
  var salesOrderDate;
  var salesOrderDateOnly;
  var salesOrderTime;
  var salesOrderAmountUntaxed;
  var salesOrderTaxAmount;
  var salesOrderBeforeDiscountAmount;
  var salesOrderDiscountAmount;
  var salesOrderAmount;
  var salesOrderMargin;
  var salesStatus;
  var salesOrderOrderStatus;
  var salesOrderSalesperson;
  var saleEachOrderCount;
  List<SalesOrderDetails>? salesOrderDetails;
  var invoiceCountEachOrder;

  Order(
      {this.clientId,
        this.clientName,
        this.clientMobile,
        this.partnerShippingId,
        this.partnerAddressName,
        this.clientEmail,
        this.clientStreet,
        this.statesOfOrder,
        this.clientStreet2,
        this.salesPersonAssist,
        this.orderNotes,
        this.clientCity,
        this.clientStateName,
        this.clientCountryName,
        this.salesOrderId,
        this.salesOrderName,
        this.salesOrderDate,
        this.salesOrderDateOnly,
        this.salesOrderTime,
        this.salesOrderAmountUntaxed,
        this.salesOrderTaxAmount,
        this.salesOrderBeforeDiscountAmount,
        this.salesOrderDiscountAmount,
        this.salesOrderAmount,
        this.salesOrderMargin,
        this.salesStatus,
        this.salesOrderOrderStatus,
        this.salesOrderSalesperson,
        this.saleEachOrderCount,
        this.salesOrderDetails,
        this.invoiceCountEachOrder});

  Order.fromJson(Map<String, dynamic> json) {
    clientId = json['client_id'];
    clientName = json['client_name'];
    clientMobile = json['client_mobile'];
    partnerShippingId = json['partner_shipping_id'];
    partnerAddressName = json['partner_address_name'];
    clientEmail = json['client_email'];
    clientStreet = json['client_street'];
    statesOfOrder = json['states_of_order'];
    clientStreet2 = json['client_street2'];
    salesPersonAssist = json['sales_person_assist'];
    orderNotes = json['order_notes'];
    clientCity = json['client_city'];
    clientStateName = json['client_state_name'];
    clientCountryName = json['client_country_name'];
    salesOrderId = json['sales_order_id'];
    salesOrderName = json['sales_order_name'];
    salesOrderDate = json['sales_order_date'];
    salesOrderDateOnly = json['sales_order_date_only'];
    salesOrderTime = json['sales_order_time'];
    salesOrderAmountUntaxed = json['sales_order_amount_untaxed'];
    salesOrderTaxAmount = json['sales_order_tax_amount'];
    salesOrderBeforeDiscountAmount = json['sales_order_before_discount_amount'];
    salesOrderDiscountAmount = json['sales_order_discount_amount'];
    salesOrderAmount = json['sales_order_amount'];
    salesOrderMargin = json['sales_order_margin'];
    salesStatus = json['sales_status'];
    salesOrderOrderStatus = json['sales_order_order_status'];
    salesOrderSalesperson = json['sales_order_salesperson'];
    saleEachOrderCount = json['sale_each_order_count'];
    if (json['sales_order_details'] != null) {
      salesOrderDetails = <SalesOrderDetails>[];
      json['sales_order_details'].forEach((v) {
        salesOrderDetails!.add(new SalesOrderDetails.fromJson(v));
      });
    }
    invoiceCountEachOrder = json['invoice_count_each_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['client_id'] = this.clientId;
    data['client_name'] = this.clientName;
    data['client_mobile'] = this.clientMobile;
    data['partner_shipping_id'] = this.partnerShippingId;
    data['partner_address_name'] = this.partnerAddressName;
    data['client_email'] = this.clientEmail;
    data['client_street'] = this.clientStreet;
    data['states_of_order'] = this.statesOfOrder;
    data['client_street2'] = this.clientStreet2;
    data['sales_person_assist'] = this.salesPersonAssist;
    data['order_notes'] = this.orderNotes;
    data['client_city'] = this.clientCity;
    data['client_state_name'] = this.clientStateName;
    data['client_country_name'] = this.clientCountryName;
    data['sales_order_id'] = this.salesOrderId;
    data['sales_order_name'] = this.salesOrderName;
    data['sales_order_date'] = this.salesOrderDate;
    data['sales_order_date_only'] = this.salesOrderDateOnly;
    data['sales_order_time'] = this.salesOrderTime;
    data['sales_order_amount_untaxed'] = this.salesOrderAmountUntaxed;
    data['sales_order_tax_amount'] = this.salesOrderTaxAmount;
    data['sales_order_before_discount_amount'] =
        this.salesOrderBeforeDiscountAmount;
    data['sales_order_discount_amount'] = this.salesOrderDiscountAmount;
    data['sales_order_amount'] = this.salesOrderAmount;
    data['sales_order_margin'] = this.salesOrderMargin;
    data['sales_status'] = this.salesStatus;
    data['sales_order_order_status'] = this.salesOrderOrderStatus;
    data['sales_order_salesperson'] = this.salesOrderSalesperson;
    data['sale_each_order_count'] = this.saleEachOrderCount;
    if (this.salesOrderDetails != null) {
      data['sales_order_details'] =
          this.salesOrderDetails!.map((v) => v.toJson()).toList();
    }
    data['invoice_count_each_order'] = this.invoiceCountEachOrder;
    return data;
  }
}

class SalesOrderDetails {
  var saleLineId;
  List<Taxes>? taxes;
  var productId;
  var productName;
  var productQty;
  var productQtyDelivered;
  var reservedQuantity;
  var productQtyInvoiced;
  var unitOfMeasureId;
  var unitOfMeasureName;
  var productPrice;
  var productDiscount;
  var productPriceSubtotal;
  var productPriceTotal;
  List<MainCover>? mainCover;

  SalesOrderDetails(
      {this.saleLineId,
        this.taxes,
        this.productId,
        this.productName,
        this.productQty,
        this.productQtyDelivered,
        this.reservedQuantity,
        this.productQtyInvoiced,
        this.unitOfMeasureId,
        this.unitOfMeasureName,
        this.productPrice,
        this.productDiscount,
        this.productPriceSubtotal,
        this.productPriceTotal,
        this.mainCover});

  SalesOrderDetails.fromJson(Map<String, dynamic> json) {
    saleLineId = json['sale_line_id'];
    if (json['taxes'] != null) {
      taxes = <Taxes>[];
      json['taxes'].forEach((v) {
        taxes!.add(new Taxes.fromJson(v));
      });
    }
    productId = json['product_id'];
    productName = json['product_name'];
    productQty = json['product_qty'];
    productQtyDelivered = json['product_qty_delivered'];
    reservedQuantity = json['reserved_quantity'];
    productQtyInvoiced = json['product_qty_invoiced'];
    unitOfMeasureId = json['unit_of_measure_id'];
    unitOfMeasureName = json['unit_of_measure_name'];
    productPrice = json['product_price'];
    productDiscount = json['product_discount'];
    productPriceSubtotal = json['product_price_subtotal'];
    productPriceTotal = json['product_price_total'];
    if (json['main_cover'] != null) {
      mainCover = <MainCover>[];
      json['main_cover'].forEach((v) {
        mainCover!.add(new MainCover.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sale_line_id'] = this.saleLineId;
    if (this.taxes != null) {
      data['taxes'] = this.taxes!.map((v) => v.toJson()).toList();
    }
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_qty'] = this.productQty;
    data['product_qty_delivered'] = this.productQtyDelivered;
    data['reserved_quantity'] = this.reservedQuantity;
    data['product_qty_invoiced'] = this.productQtyInvoiced;
    data['unit_of_measure_id'] = this.unitOfMeasureId;
    data['unit_of_measure_name'] = this.unitOfMeasureName;
    data['product_price'] = this.productPrice;
    data['product_discount'] = this.productDiscount;
    data['product_price_subtotal'] = this.productPriceSubtotal;
    data['product_price_total'] = this.productPriceTotal;
    if (this.mainCover != null) {
      data['main_cover'] = this.mainCover!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Taxes {
  var taxId;
  var taxName;

  Taxes({this.taxId, this.taxName});

  Taxes.fromJson(Map<String, dynamic> json) {
    taxId = json['tax_id'];
    taxName = json['tax_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tax_id'] = this.taxId;
    data['tax_name'] = this.taxName;
    return data;
  }
}

class MainCover {
  var id;
  var type;
  var title;
  var alt;
  var file;
  var thumbnail;
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
  var thumbnail;
  var medium;
  var large;
  var s1200800;
  var s8001200;
  var s1200300;
  var s3001200;
  var superGlaze711Webp;
  var superGlaze711WebpWebp;
  var superGlaze711;

  Sizes(
      {this.thumbnail,
        this.medium,
        this.large,
        this.s1200800,
        this.s8001200,
        this.s1200300,
        this.s3001200,
        this.superGlaze711Webp,
        this.superGlaze711WebpWebp,
        this.superGlaze711,});

  Sizes.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    medium = json['medium'];
    large = json['large'];
    s1200800 = json['1200_800'];
    s8001200 = json['800_1200'];
    s1200300 = json['1200_300'];
    s3001200 = json['300_1200'];
    superGlaze711Webp = json['Super-glaze-711_webp'];
    superGlaze711WebpWebp = json['Super-glaze-711.webp_webp'];
    superGlaze711 = json['Super-glaze-711_'];
    superGlaze711Webp = json['Super-glaze-711.webp_'];
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
    data['Super-glaze-711_webp'] = this.superGlaze711Webp;
    data['Super-glaze-711.webp_webp'] = this.superGlaze711WebpWebp;
    data['Super-glaze-711_'] = this.superGlaze711;
    data['Super-glaze-711.webp_'] = this.superGlaze711Webp;
    return data;
  }
}
