import '../general/image_model.dart';
import '../people/member_model.dart';
import '../people/owner_model.dart';

class TeamModel {
  int? id;
  String? name;
  String? about;
  int? membersCount;
  List<Image>? image;
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
    if (json['image'] != null) {
      image = <Image>[];
      json['image'].forEach((v) {
        image!.add(new Image.fromJson(v));
      });
    }
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
    if (this.image != null) {
      data['image'] = this.image!.map((v) => v.toJson()).toList();
    }
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
  String? s1200800;
  String? s8001200;
  String? s1200300;
  String? s3001200;
  String? aboutOud23908Webp;
  String? aboutOud23908JpgWebp;

  Sizes(
      {this.thumbnail,
        this.medium,
        this.large,
        this.s1200800,
        this.s8001200,
        this.s1200300,
        this.s3001200,
        this.aboutOud23908Webp,
        this.aboutOud23908JpgWebp});

  Sizes.fromJson(Map<String, dynamic> json) {
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