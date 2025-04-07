class ImageModel {
  int? id;
  String? type;
  String? title;
  String? alt;
  String? file;
  String? thumbnail;

  ImageModel({
    this.id,
    this.type,
    this.title,
    this.alt,
    this.file,
    this.thumbnail,
  });

  ImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    title = json['title'];
    alt = json['alt'];
    file = json['file'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['title'] = title;
    data['alt'] = alt;
    data['file'] = file;
    data['thumbnail'] = thumbnail;

    return data;
  }
}
