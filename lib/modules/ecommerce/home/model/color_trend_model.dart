class ColorTrendModel {
  bool? status;
  String? message;
  Page? page;

  ColorTrendModel({this.status, this.message, this.page});

  ColorTrendModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    page = json['page'] != null ? new Page.fromJson(json['page']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.page != null) {
      data['page'] = this.page!.toJson();
    }
    return data;
  }
}

class Page {
  int? id;
  String? title;
  String? slug;
  String? type;
  String? content;
  String? pageColor;
  List<CoverForWeb>? coverForWeb;
  String? coverForMobile;
  List? gallery;
  List<Blogs>? blogs;
  List? products;

  Page(
      {this.id,
        this.title,
        this.slug,
        this.type,
        this.content,
        this.pageColor,
        this.coverForWeb,
        this.coverForMobile,
        this.gallery,
        this.blogs,
        this.products});

  Page.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    type = json['type'];
    content = json['content'];
    pageColor = json['page_color'];
    if (json['cover_for_web'] != null) {
      coverForWeb = <CoverForWeb>[];
      json['cover_for_web'].forEach((v) {
        coverForWeb!.add(new CoverForWeb.fromJson(v));
      });
    }
    coverForMobile = json['cover_for_mobile'];
    if (json['gallery'] != null) {
      gallery = <Sizesgallery>[];
      json['gallery'].forEach((v) {
        gallery!.add(Sizesgallery.fromJson(v));
      });
    }
    if (json['blogs'] != null) {
      blogs = <Blogs>[];
      json['blogs'].forEach((v) {
        blogs!.add(new Blogs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['type'] = this.type;
    data['content'] = this.content;
    data['page_color'] = this.pageColor;
    if (this.coverForWeb != null) {
      data['cover_for_web'] = this.coverForWeb!.map((v) => v.toJson()).toList();
    }
    data['cover_for_mobile'] = this.coverForMobile;
    if (this.gallery != null) {
      data['gallery'] = this.gallery!.map((v) => v.toJson()).toList();
    }
    if (this.blogs != null) {
      data['blogs'] = this.blogs!.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CoverForWeb {
  int? id;
  String? type;
  String? title;
  String? alt;
  String? file;
  String? thumbnail;
  CoverForWebSizes? coverForWebSizes;

  CoverForWeb(
      {this.id,
        this.type,
        this.title,
        this.alt,
        this.file,
        this.thumbnail,
        this.coverForWebSizes});

  CoverForWeb.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    title = json['title'];
    alt = json['alt'];
    file = json['file'];
    thumbnail = json['thumbnail'];
    coverForWebSizes = json['sizes'] != null ? new CoverForWebSizes.fromJson(json['sizes']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['title'] = this.title;
    data['alt'] = this.alt;
    data['file'] = this.file;
    data['thumbnail'] = this.thumbnail;
    if (this.coverForWebSizes != null) {
      data['sizes'] = this.coverForWebSizes!.toJson();
    }
    return data;
  }
}

class CoverForWebSizes{
  String? thumbnail;
  String? medium;
  String? large;
  CoverForWebSizes(
      {this.thumbnail,
        this.medium,
        this.large,
      });

  CoverForWebSizes.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    medium = json['medium'];
    large = json['large'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumbnail'] = this.thumbnail;
    data['medium'] = this.medium;
    data['large'] = this.large;
    return data;
  }
}

class Sizesgallery {
  String? thumbnail;
  String? medium;
  String? large;
  Sizesgallery(
      {this.thumbnail,
        this.medium,
        this.large,
      });

  Sizesgallery.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    medium = json['medium'];
    large = json['large'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumbnail'] = this.thumbnail;
    data['medium'] = this.medium;
    data['large'] = this.large;
    return data;
  }
}

class Blogs {
  int? id;
  String? slug;
  String? tags;
  String? title;
  String? shortDescription;
  List? mainGallery;
  String? category;
  int? categoryId;
  var createdAt;
  Status? status;

  Blogs(
      {this.id,
        this.slug,
        this.tags,
        this.title,
        this.shortDescription,
        this.mainGallery,
        this.category,
        this.categoryId,
        this.createdAt,
        this.status});

  Blogs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    tags = json['tags'];
    title = json['title'];
    shortDescription = json['short_description'];
    if (json['main_gallery'] != null) {
      mainGallery = [];
      json['main_gallery'].forEach((v) {
        mainGallery!.add(SizesBlog.fromJson(v));
      });
    }
    category = json['category'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['tags'] = this.tags;
    data['title'] = this.title;
    data['short_description'] = this.shortDescription;
    if (this.mainGallery != null) {
      data['main_gallery'] = this.mainGallery!.map((v) => v.toJson()).toList();
    }
    data['category'] = this.category;
    data['category_id'] = this.categoryId;
    data['created_at'] = this.createdAt;
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    return data;
  }
}

class SizesBlog {
  String? thumbnail;
  String? medium;
  String? large;

  SizesBlog (
      {this.thumbnail,
        this.medium,
        this.large,
      });

  SizesBlog.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    medium = json['medium'];
    large = json['large'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumbnail'] = this.thumbnail;
    data['medium'] = this.medium;
    data['large'] = this.large;
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
