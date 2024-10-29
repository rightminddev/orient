import 'dart:convert';

// To parse this JSON data, you can use `PageModel.fromJson(jsonData)`.
ColorTrendModel pageModelFromJson(String str) => ColorTrendModel.fromJson(json.decode(str));

class ColorTrendModel {
  final bool status;
  final String message;
  final Page page;

  ColorTrendModel({
    required this.status,
    required this.message,
    required this.page,
  });

  factory ColorTrendModel.fromJson(Map<String, dynamic> json) => ColorTrendModel(
    status: json["status"],
    message: json["message"],
    page: Page.fromJson(json["page"]),
  );
}

class Page {
  final int id;
  final String title;
  final String slug;
  final String type;
  final String content;
  final String pageColor;
  final List<Image> coverForWeb;
  final List<dynamic> coverForMobile;
  final List<Image> gallery;
  final List<Blog> blogs;
  final List<Product> products;

  Page({
    required this.id,
    required this.title,
    required this.slug,
    required this.type,
    required this.content,
    required this.pageColor,
    required this.coverForWeb,
    required this.coverForMobile,
    required this.gallery,
    required this.blogs,
    required this.products,
  });

  factory Page.fromJson(Map<String, dynamic> json) => Page(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    type: json["type"],
    content: json["content"],
    pageColor: json["page_color"],
    coverForWeb:
    List<Image>.from(json["cover_for_web"].map((x) => Image.fromJson(x))),
    coverForMobile: List<dynamic>.from(json["cover_for_mobile"].map((x) => x)),
    gallery: List<Image>.from(json["gallery"].map((x) => Image.fromJson(x))),
    blogs: List<Blog>.from(json["blogs"].map((x) => Blog.fromJson(x))),
    products:
    List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );
}

class Image {
  final int id;
  final String type;
  final String title;
  final String alt;
  final String file;
  final String thumbnail;
  final Sizes sizes;

  Image({
    required this.id,
    required this.type,
    required this.title,
    required this.alt,
    required this.file,
    required this.thumbnail,
    required this.sizes,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"],
    type: json["type"],
    title: json["title"],
    alt: json["alt"],
    file: json["file"],
    thumbnail: json["thumbnail"],
    sizes: Sizes.fromJson(json["sizes"]),
  );
}

class Sizes {
  final String thumbnail;
  final String medium;
  final String large;
  final String size1200x800;
  final String size800x1200;
  final String size1200x300;
  final String size300x1200;
  final String webpVersion;

  Sizes({
    required this.thumbnail,
    required this.medium,
    required this.large,
    required this.size1200x800,
    required this.size800x1200,
    required this.size1200x300,
    required this.size300x1200,
    required this.webpVersion,
  });

  factory Sizes.fromJson(Map<String, dynamic> json) => Sizes(
    thumbnail: json["thumbnail"],
    medium: json["medium"],
    large: json["large"],
    size1200x800: json["1200_800"],
    size800x1200: json["800_1200"],
    size1200x300: json["1200_300"],
    size300x1200: json["300_1200"],
    webpVersion: json["Vector--1-.jpg_webp"],
  );
}

class Blog {
  final int id;
  final String slug;
  final String tags;
  final String title;
  final String shortDescription;
  final List<Image> mainGallery;
  final List<Image> mainThumbnail;
  final String category;
  final int categoryId;
  final DateTime? createdAt;
  final Status status;

  Blog({
    required this.id,
    required this.slug,
    required this.tags,
    required this.title,
    required this.shortDescription,
    required this.mainGallery,
    required this.mainThumbnail,
    required this.category,
    required this.categoryId,
    this.createdAt,
    required this.status,
  });

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
    id: json["id"],
    slug: json["slug"],
    tags: json["tags"],
    title: json["title"],
    shortDescription: json["short_description"],
    mainGallery: List<Image>.from(
        json["main_gallery"].map((x) => Image.fromJson(x))),
    mainThumbnail: List<Image>.from(
        json["main_thumbnail"].map((x) => Image.fromJson(x))),
    category: json["category"],
    categoryId: json["category_id"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    status: Status.fromJson(json["status"]),
  );
}

class Product {
  final int id;
  final String title;
  final ProductType type;
  final int regularPrice;
  final int? sellPrice;
  final int price;
  final String shortDescription;
  final String description;
  final List<Image> mainCover;
  final List<dynamic> images;
  final List<Pdf> pdf;
  final List<dynamic> threeDModel;
  final List<dynamic> image360Panorama;
  final String? videos;
  final Status stockStatus;
  final int quantity;
  final int width;
  final int height;
  final int length;
  final int weight;
  final String sku;
  final Status status;

  Product({
    required this.id,
    required this.title,
    required this.type,
    required this.regularPrice,
    this.sellPrice,
    required this.price,
    required this.shortDescription,
    required this.description,
    required this.mainCover,
    required this.images,
    required this.pdf,
    required this.threeDModel,
    required this.image360Panorama,
    this.videos,
    required this.stockStatus,
    required this.quantity,
    required this.width,
    required this.height,
    required this.length,
    required this.weight,
    required this.sku,
    required this.status,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    type: ProductType.fromJson(json["type"]),
    regularPrice: json["regular_price"],
    sellPrice: json["sell_price"],
    price: json["price"],
    shortDescription: json["short_description"],
    description: json["description"],
    mainCover:
    List<Image>.from(json["main_cover"].map((x) => Image.fromJson(x))),
    images: List<dynamic>.from(json["images"].map((x) => x)),
    pdf: List<Pdf>.from(json["pdf"].map((x) => Pdf.fromJson(x))),
    threeDModel: List<dynamic>.from(json["three_d_model"].map((x) => x)),
    image360Panorama:
    List<dynamic>.from(json["image_360_panorama"].map((x) => x)),
    videos: json["videos"],
    stockStatus: Status.fromJson(json["stock_status"]),
    quantity: json["quantity"],
    width: json["width"],
    height: json["height"],
    length: json["length"],
    weight: json["weight"],
    sku: json["sku"],
    status: Status.fromJson(json["status"]),
  );
}

class ProductType {
  final String key;
  final String value;

  ProductType({
    required this.key,
    required this.value,
  });

  factory ProductType.fromJson(Map<String, dynamic> json) => ProductType(
    key: json["key"],
    value: json["value"],
  );
}

class Pdf {
  final int id;
  final String type;
  final String title;
  final String alt;
  final String file;
  final String thumbnail;

  Pdf({
    required this.id,
    required this.type,
    required this.title,
    required this.alt,
    required this.file,
    required this.thumbnail,
  });

  factory Pdf.fromJson(Map<String, dynamic> json) => Pdf(
    id: json["id"],
    type: json["type"],
    title: json["title"],
    alt: json["alt"],
    file: json["file"],
    thumbnail: json["thumbnail"],
  );
}

class Status {
  final String key;
  final String value;

  Status({
    required this.key,
    required this.value,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    key: json["key"],
    value: json["value"],
  );
}
