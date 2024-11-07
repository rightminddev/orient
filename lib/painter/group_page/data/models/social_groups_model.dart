class SocialGroupsModel {
  bool? status;
  String? message;
  String? create;
  int? count;
  List<Data>? data;

  SocialGroupsModel(
      {this.status, this.message, this.create, this.count, this.data});

  SocialGroupsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    create = json['create'];
    count = json['count'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  String? title;
  List<Image>? image;
  int? postsCount;

  Data({this.id, this.title, this.image, this.postsCount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['image'] != null) {
      image = <Image>[];
      json['image'].forEach((v) {
        image!.add( Image.fromJson(v));
      });
    }
    postsCount = json['posts_count'];
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
    sizes = json['sizes'] != null ? Sizes.fromJson(json['sizes']) : null;
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
  String? monthlyWPDesktopIpadWebp;

  Sizes(
      {this.thumbnail,
        this.medium,
        this.large,
        this.s1200800,
        this.s8001200,
        this.s1200300,
        this.s3001200,
        this.monthlyWPDesktopIpadWebp});

  Sizes.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    medium = json['medium'];
    large = json['large'];
    s1200800 = json['1200_800'];
    s8001200 = json['800_1200'];
    s1200300 = json['1200_300'];
    s3001200 = json['300_1200'];
    monthlyWPDesktopIpadWebp = json['Monthly-WP--Desktop---Ipad-_webp'];
  }
}