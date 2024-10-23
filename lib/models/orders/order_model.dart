import 'package:orient/models/orders/item_model.dart';

import 'shipping_info_model.dart';

class OrderModel {
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
  List<ItemModel>? items;
  ShippingInfoModel? shippingInfo;
  String? customerName;
  int? customerId;
  OrderModel({
    this.id,
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
    this.items,
    this.shippingInfo,
    this.customerName,
    this.customerId,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
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
    if (json['items'] != null) {
      items = <ItemModel>[];
      json['items'].forEach((v) {
        items!.add(ItemModel.fromJson(v));
      });
    }
    shippingInfo = json['shipping_info'] != null
        ? ShippingInfoModel.fromJson(json['shipping_info'])
        : null;
    customerName = json['customer_name'];
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['merchant_status'] = merchantStatus;
    data['uuid'] = uuid;
    data['sub_total'] = subTotal;
    data['discount_total'] = discountTotal;
    data['fees_total'] = feesTotal;
    data['taxes_total'] = taxesTotal;
    data['shipping_cost'] = shippingCost;
    data['total'] = total;
    data['date'] = date;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (shippingInfo != null) {
      data['shipping_info'] = shippingInfo!.toJson();
    }
    data['customer_name'] = customerName;
    data['customer_id'] = customerId;
    return data;
  }
}
