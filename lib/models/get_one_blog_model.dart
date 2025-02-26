class GetOneBlogModel {
  bool? status;
  String? message;
  String? create;
  Item? item;

  GetOneBlogModel({this.status, this.message, this.create, this.item});

  GetOneBlogModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    create = json['create'];
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['create'] = this.create;
    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    return data;
  }
}

class Item {
  int? id;
  String? slug;
  String? title;
  String? shortDescription;
  String? content;
  List<MainGallery>? mainGallery;
  List<MainThumbnail>? mainThumbnail;
  Category? category;
  int? categoryId;
  String? createdAt;
  Status? status;
  String? createdDate;

  Item(
      {this.id,
        this.slug,
        this.title,
        this.shortDescription,
        this.content,
        this.mainGallery,
        this.mainThumbnail,
        this.category,
        this.categoryId,
        this.createdAt,
        this.status,
        this.createdDate});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    shortDescription = json['short_description'];
    content = json['content'];
    if (json['main_gallery'] != null) {
      mainGallery = <MainGallery>[];
      json['main_gallery'].forEach((v) {
        mainGallery!.add(new MainGallery.fromJson(v));
      });
    }
    if (json['main_thumbnail'] != null) {
      mainThumbnail = <MainThumbnail>[];
      json['main_thumbnail'].forEach((v) {
        mainThumbnail!.add(new MainThumbnail.fromJson(v));
      });
    }
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['title'] = this.title;
    data['short_description'] = this.shortDescription;
    data['content'] = this.content;
    if (this.mainGallery != null) {
      data['main_gallery'] = this.mainGallery!.map((v) => v.toJson()).toList();
    }
    if (this.mainThumbnail != null) {
      data['main_thumbnail'] =
          this.mainThumbnail!.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['category_id'] = this.categoryId;
    data['created_at'] = this.createdAt;
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    data['created_date'] = this.createdDate;
    return data;
  }
}

class MainGallery {
  int? id;
  String? type;
  String? title;
  String? alt;
  String? file;
  String? thumbnail;
  Sizes? sizes;

  MainGallery(
      {this.id,
        this.type,
        this.title,
        this.alt,
        this.file,
        this.thumbnail,
        this.sizes});

  MainGallery.fromJson(Map<String, dynamic> json) {
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
class MainThumbnailCategory {
  int? id;
  String? type;
  String? title;
  String? alt;
  String? file;
  String? thumbnail;
  Sizes? sizes;

  MainThumbnailCategory(
      {this.id,
        this.type,
        this.title,
        this.alt,
        this.file,
        this.thumbnail,
        this.sizes});

  MainThumbnailCategory.fromJson(Map<String, dynamic> json) {
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
class MainThumbnail {
  int? id;
  String? type;
  String? title;
  String? alt;
  String? file;
  String? thumbnail;
  Sizes? sizes;

  MainThumbnail(
      {this.id,
        this.type,
        this.title,
        this.alt,
        this.file,
        this.thumbnail,
        this.sizes});

  MainThumbnail.fromJson(Map<String, dynamic> json) {
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

class Category {
  int? id;
  String? title;
  List<MainThumbnailCategory>? mainThumbnail;

  Category({this.id, this.title, this.mainThumbnail});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['main_thumbnail'] != null) {
      mainThumbnail = <MainThumbnailCategory>[];
      json['main_thumbnail'].forEach((v) {
        mainThumbnail!.add(new MainThumbnailCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.mainThumbnail != null) {
      data['main_thumbnail'] =
          this.mainThumbnail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Status {
  String? key;
  String? value;

  Status({this.key, this.value});

  Status.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}
