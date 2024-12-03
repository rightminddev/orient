class GroupResponse {
  bool status;
  var message;
  var create;
  var count;
  List<Group> data;

  GroupResponse({
    required this.status,
    required this.message,
    required this.create,
    required this.count,
    required this.data,
  });

  // Factory constructor to create object from JSON
  factory GroupResponse.fromJson(Map<String, dynamic> json) {
    return GroupResponse(
      status: json['status'],
      message: json['message'],
      create: json['create'],
      count: json['count'],
      data: List<Group>.from(json['data'].map((group) => Group.fromJson(group))),
    );
  }
}

class Group {
  var id;
  var title;
  var image; // Can be an empty string or image data
  List<ImageData>? imageData;
  var postsCount;

  Group({
    required this.id,
    required this.title,
    this.image,
    this.imageData,
    required this.postsCount,
  });

  // Factory constructor to create object from JSON
  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      title: json['title'],
      image: json['image'] is String ? json['image'] : null,
      imageData: json['image'] is List
          ? List<ImageData>.from(json['image'].map((i) => ImageData.fromJson(i)))
          : null,
      postsCount: json['posts_count'],
    );
  }
}

class ImageData {
  var id;
  var type;
  var title;
  var alt;
  var file;
  ImageSizes sizes;

  ImageData({
    required this.id,
    required this.type,
    required this.title,
    required this.alt,
    required this.file,
    required this.sizes,
  });

  // Factory constructor to create object from JSON
  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      alt: json['alt'],
      file: json['file'],
      sizes: ImageSizes.fromJson(json['sizes']),
    );
  }
}

class ImageSizes {
  var thumbnail;
  var medium;
  var large;
  var size1200x800;
  var size800x1200;
  var size1200x300;
  var size300x1200;
  var webp;

  ImageSizes({
    required this.thumbnail,
    required this.medium,
    required this.large,
    required this.size1200x800,
    required this.size800x1200,
    required this.size1200x300,
    required this.size300x1200,
    required this.webp,
  });

  // Factory constructor to create object from JSON
  factory ImageSizes.fromJson(Map<String, dynamic> json) {
    return ImageSizes(
      thumbnail: json['thumbnail'],
      medium: json['medium'],
      large: json['large'],
      size1200x800: json['1200_800'],
      size800x1200: json['800_1200'],
      size1200x300: json['1200_300'],
      size300x1200: json['300_1200'],
      webp: json['Monthly-WP--Desktop---Ipad-_webp'],
    );
  }
}
