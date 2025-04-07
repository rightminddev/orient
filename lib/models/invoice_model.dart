class InvoiceModel {
  var clientId;
  var clientName;
  var clientPhone;
  var clientMobile;
  var clientEmail;
  var clientStreet;
  var clientCity;
  var clientZip;
  var clientCountryName;
  var clientLang;
  var clientVatnumber;
  var invoiceId;
  var invoiceName;
  var invoiceDate;
  var invoiceDateOnly;
  var invoiceTime;
  var invoiceAmountUntaxed;
  var invoiceTaxAmount;
  var invoiceAmount;
  var invoiceStatus;
  var invoiceNotes;
  List<InvoiceDetails>? invoiceDetails;

  InvoiceModel(
      {this.clientId,
        this.clientName,
        this.clientPhone,
        this.clientMobile,
        this.clientEmail,
        this.clientStreet,
        this.clientCity,
        this.clientZip,
        this.clientCountryName,
        this.clientLang,
        this.clientVatnumber,
        this.invoiceId,
        this.invoiceName,
        this.invoiceDate,
        this.invoiceDateOnly,
        this.invoiceTime,
        this.invoiceAmountUntaxed,
        this.invoiceTaxAmount,
        this.invoiceAmount,
        this.invoiceStatus,
        this.invoiceNotes,
        this.invoiceDetails});

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    clientId = json['client_id'];
    clientName = json['client_name'];
    clientPhone = json['client_phone'];
    clientMobile = json['client_mobile'];
    clientEmail = json['client_email'];
    clientStreet = json['client_street'];
    clientCity = json['client_city'];
    clientZip = json['client_zip'];
    clientCountryName = json['client_country_name'];
    clientLang = json['client_lang'];
    clientVatnumber = json['client_vatnumber'];
    invoiceId = json['invoice_id'];
    invoiceName = json['invoice_name'];
    invoiceDate = json['invoice_date'];
    invoiceDateOnly = json['invoice_date_only'];
    invoiceTime = json['invoice_time'];
    invoiceAmountUntaxed = json['invoice_amount_untaxed'];
    invoiceTaxAmount = json['invoice_tax_amount'];
    invoiceAmount = json['invoice_amount'];
    invoiceStatus = json['invoice_status'] ?? "";
    invoiceNotes = json['invoice_notes'];
    if (json['invoice_details'] != null) {
      invoiceDetails = <InvoiceDetails>[];
      json['invoice_details'].forEach((v) {
        invoiceDetails!.add(new InvoiceDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['client_id'] = this.clientId;
    data['client_name'] = this.clientName;
    data['client_phone'] = this.clientPhone;
    data['client_mobile'] = this.clientMobile;
    data['client_email'] = this.clientEmail;
    data['client_street'] = this.clientStreet;
    data['client_city'] = this.clientCity;
    data['client_zip'] = this.clientZip;
    data['client_country_name'] = this.clientCountryName;
    data['client_lang'] = this.clientLang;
    data['client_vatnumber'] = this.clientVatnumber;
    data['invoice_id'] = this.invoiceId;
    data['invoice_name'] = this.invoiceName;
    data['invoice_date'] = this.invoiceDate;
    data['invoice_date_only'] = this.invoiceDateOnly;
    data['invoice_time'] = this.invoiceTime;
    data['invoice_amount_untaxed'] = this.invoiceAmountUntaxed;
    data['invoice_tax_amount'] = this.invoiceTaxAmount;
    data['invoice_amount'] = this.invoiceAmount;
    data['invoice_status'] = this.invoiceStatus;
    data['invoice_notes'] = this.invoiceNotes;
    if (this.invoiceDetails != null) {
      data['invoice_details'] =
          this.invoiceDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InvoiceDetails {
  var invoiceLineId;
  var productId;
  var partnerId;
  var productName;
  var productImgLink;
  var productQty;
  var productPrice;
  var productDiscount;
  var productPriceSubtotal;
  var productPriceTotal;
  List<MainCover>? mainCover;

  InvoiceDetails(
      {this.invoiceLineId,
        this.productId,
        this.partnerId,
        this.productName,
        this.productImgLink,
        this.productQty,
        this.productPrice,
        this.productDiscount,
        this.productPriceSubtotal,
        this.productPriceTotal,
        this.mainCover});

  InvoiceDetails.fromJson(Map<String, dynamic> json) {
    invoiceLineId = json['invoice_line_id'];
    productId = json['product_id'];
    partnerId = json['partner_id'];
    productName = json['product_name'];
    productImgLink = json['product_img_link'];
    productQty = json['product_qty'];
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
    data['invoice_line_id'] = this.invoiceLineId;
    data['product_id'] = this.productId;
    data['partner_id'] = this.partnerId;
    data['product_name'] = this.productName;
    data['product_img_link'] = this.productImgLink;
    data['product_qty'] = this.productQty;
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
  var kretalGloss444Webp;

  Sizes(
      {this.thumbnail,
        this.medium,
        this.large,
        this.s1200800,
        this.s8001200,
        this.s1200300,
        this.s3001200,
        this.kretalGloss444Webp});

  Sizes.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    medium = json['medium'];
    large = json['large'];
    s1200800 = json['1200_800'];
    s8001200 = json['800_1200'];
    s1200300 = json['1200_300'];
    s3001200 = json['300_1200'];
    kretalGloss444Webp = json['Kretal-Gloss-444_webp'];
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
    data['Kretal-Gloss-444_webp'] = this.kretalGloss444Webp;
    return data;
  }
}
