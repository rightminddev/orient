import '../stores/permissions_model.dart';

class ManagersModel {
  int? id;
  String? user;
  int? userId;
  String? store;
  int? storeId;
  List<PermissionsModel>? permissions;

  ManagersModel(
      {this.id,
      this.user,
      this.userId,
      this.store,
      this.storeId,
      this.permissions});

  ManagersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    userId = json['user_id'];
    store = json['store'];
    storeId = json['store_id'];
    if (json['permissions'] != null) {
      permissions = <PermissionsModel>[];
      json['permissions'].forEach((v) {
        permissions!.add(PermissionsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user'] = user;
    data['user_id'] = userId;
    data['store'] = store;
    data['store_id'] = storeId;
    if (permissions != null) {
      data['permissions'] = permissions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
