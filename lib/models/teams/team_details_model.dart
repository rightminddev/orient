import 'package:orient/models/general/image_model.dart';

import '../people/member_model.dart';
import '../people/owner_model.dart';

class TeamDetailsModel {
  int? id;
  String? name;
  String? about;
  int? membersCount;
  int? totalPoints;
  List<ImageModel>? image;
  OwnerModel? owner;
  List<MemberModel>? members;


  TeamDetailsModel(
      {this.id,
      this.name,
      this.about,
      this.membersCount,
      this.totalPoints,
      this.image,
      this.owner,
      this.members});

  TeamDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    about = json['about'];
    membersCount = json['members_count'];
    totalPoints = json['total_points'];
    if (json['image'] != null) {
      image = <ImageModel>[];
      json['image'].forEach((v) {
        image!.add(ImageModel.fromJson(v));
      });
    }
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
    data['members_count'] = membersCount;
    data['total_points'] = totalPoints;
    if (image != null) {
      data['image'] = image!.map((v) => v.toJson()).toList();
    }
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
