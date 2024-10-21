import '../general/image_model.dart';
import '../people/member_model.dart';
import '../people/owner_model.dart';

class TeamModel {
  int? id;
  String? name;
  String? about;
  int? membersCount;
  List<ImageModel>? image;
  int? ownerId;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? points;
  String? pointsUpdatedAt;
  OwnerModel? owner;
  List<MemberModel>? members;

  TeamModel({
    this.id,
    this.name,
    this.about,
    this.image,
    this.ownerId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.points,
    this.pointsUpdatedAt,
    this.owner,
    this.members,
  });

  TeamModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    about = json['about'];
    image = json['image'];
    ownerId = json['owner_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    points = json['points'];
    pointsUpdatedAt = json['points_updated_at'];
    owner = json['owner'] != null ? OwnerModel.fromJson(json['owner']) : null;
    if (json['members'] != null) {
      members = <MemberModel>[];
      json['members'].forEach((v) {
        members!.add(MemberModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['about'] = about;
    data['image'] = image;
    data['owner_id'] = ownerId;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['points'] = points;
    data['points_updated_at'] = pointsUpdatedAt;
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
