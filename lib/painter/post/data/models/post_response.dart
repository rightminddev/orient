
class PostResponse {
  final bool status;
  final String message;
  final String create;
  final int count;
  final List<SocialPost> data;

  PostResponse({
    required this.status,
    required this.message,
    required this.create,
    required this.count,
    required this.data,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json) {
    return PostResponse(
      status: json['status'],
      message: json['message']??'',
      create: json['create']??'',
      count: json['count'],
      data: List<SocialPost>.from(json['data'].map((item) => SocialPost.fromJson(item))),
    );
  }
}

class SocialPost {
  final int id;
  final String content;
  final List<Media> video;
  final List<Media> image;
  final String? imag;
  final User user;
  final int userId;
  final SocialGroup socialGroup;
  final int socialGroupId;
  final int commentsCount;
  final int emotionsCount;
  final String? userEmotion;

  SocialPost( {
    required this.id,
    required this.content,
    required this.video,
    required this.image,
    required this.imag,
    required this.user,
    required this.userId,
    required this.socialGroup,
    required this.socialGroupId,
    required this.commentsCount,
    required this.emotionsCount,
    this.userEmotion,
  });



  factory SocialPost.fromJson(Map<String, dynamic> json) {
    return SocialPost(
      id: json['id'],
      content: json['content']??'',
      video: json['video'] is List
          ? List<Media>.from(json['video'].map((item) => Media.fromJson(item)))
          : [],
      imag: json['image'] is String ? json['image'] : '',
      image: json['image'] is List
          ? List<Media>.from(json['image'].map((item) => Media.fromJson(item)))
          : [],
      user: User.fromJson(json['user']),
      userId: json['user_id'],
      socialGroup: SocialGroup.fromJson(json['socialGroup']),
      socialGroupId: json['social_group_id'],
      commentsCount: json['comments_count'],
      emotionsCount: json['emotions_count'],
      userEmotion: json['user_emotion']??'',
    );
  }
}

class Media {
  final int id;
  final String type;
  final String title;
  final String alt;
  final String file;
  final String thumbnail;
  final MediaSizes sizes;

  Media({
    required this.id,
    required this.type,
    required this.title,
    required this.alt,
    required this.file,
    required this.thumbnail,
    required this.sizes,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json['id'],
      type: json['type']??'',
      title: json['title']??'',
      alt: json['alt']??'',
      file: json['file']??'',
      thumbnail: json['thumbnail']??'',
      sizes: json['sizes'] is Map<String, dynamic> ? MediaSizes.fromJson(json['sizes']) : MediaSizes.empty(),
    );
  }
}

class MediaSizes {
  final String thumbnail;
  final String medium;
  final String large;
  final String size1200x800;
  final String size800x1200;
  final String size1200x300;
  final String size300x1200;
  final String webpFile;

  MediaSizes({
    required this.thumbnail,
    required this.medium,
    required this.large,
    required this.size1200x800,
    required this.size800x1200,
    required this.size1200x300,
    required this.size300x1200,
    required this.webpFile,
  });

  factory MediaSizes.fromJson(Map<String, dynamic> json) {
    return MediaSizes(
      thumbnail: json['thumbnail']??'',
      medium: json['medium']??'',
      large: json['large']??'',
      size1200x800: json['1200_800']??'',
      size800x1200: json['800_1200']??'',
      size1200x300: json['1200_300']??'',
      size300x1200: json['300_1200']??'',
      webpFile: json['Monthly-WP--Desktop---Ipad-.zip---Calendar-5.png_webp'] ?? '',
    );
  }

  factory MediaSizes.empty() {
    return MediaSizes(
      thumbnail: '',
      medium: '',
      large: '',
      size1200x800: '',
      size800x1200: '',
      size1200x300: '',
      size300x1200: '',
      webpFile: '',
    );
  }
}

class User {
  final int id;
  final String? avatar;
  final String name;
  final String? username;
  final String? email;
  final String? birthDay;
  final CountryKey countryKey;
  final String? phone;
  final String roles;
  final Language defaultLanguage;
  final Status status;
  final String tags;

  User({
    required this.id,
    this.avatar,
    required this.name,
    this.username,
    this.email,
    this.birthDay,
    required this.countryKey,
    this.phone,
    required this.roles,
    required this.defaultLanguage,
    required this.status,
    required this.tags,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      avatar: json['avatar']??'',
      name: json['name']??'',
      username: json['username']??'',
      email: json['email']??'',
      birthDay: json['birth_day']??'',
      countryKey: CountryKey.fromJson(json['country_key']),
      phone: json['phone']??'',
      roles: json['roles']??'',
      defaultLanguage: Language.fromJson(json['default_language']),
      status: Status.fromJson(json['status']),
      tags: json['tags']??'',
    );
  }
}

class CountryKey {
  final String? key;
  final String? value;

  CountryKey({this.key, this.value});

  factory CountryKey.fromJson(Map<String, dynamic> json) {
    return CountryKey(
      key: json['key'],
      value: json['value'],
    );
  }
}

class Language {
  final String? key;
  final String? value;

  Language({this.key, this.value});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      key: json['key'],
      value: json['value'],
    );
  }
}

class Status {
  final String? key;
  final String? value;

  Status({this.key, this.value});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      key: json['key'],
      value: json['value'],
    );
  }
}

class SocialGroup {
  final int id;
  final String title;
  final String imag;
  final List<Media> image;

  SocialGroup({
    required this.id,
    required this.title,
    required this.image,
    required this.imag,
  });

  factory SocialGroup.fromJson(Map<String, dynamic> json) {
    return SocialGroup(
      id: json['id'],
      title: json['title']??'',
      image: json['image'] is List
      ? List<Media>.from(json['image'].map((item) => Media.fromJson(item))): [],
      imag: json['image'] is String ? json['image'] : "",
    );
  }
}




// class PostResponse {
//   final bool status;
//   final String message;
//   final String create;
//   final int count;
//   final List<Post> data;
//
//   PostResponse({
//     required this.status,
//     required this.message,
//     required this.create,
//     required this.count,
//     required this.data,
//   });
//
//   factory PostResponse.fromJson(Map<String, dynamic> json) {
//     return PostResponse(
//       status: json['status'],
//       message: json['message']??"",
//       create: json['create']??"",
//       count: json['count'],
//       data: List<Post>.from(json['data'].map((post) => Post.fromJson(post))),
//     );
//   }
// }
//
// class Post {
//   final int id;
//   final String content;
//   // final String video;
//   // final List<VideoData>? videoData;
//   final String? image;
//   final List<ImageData>? imageData;
//   final User user;
//   final int userId;
//   final SocialGroup socialGroup;
//   final int socialGroupId;
//   final int commentsCount;
//   final int emotionsCount;
//   final String? userEmotion;
//
//   Post({
//     required this.id,
//     required this.content,
//     // required this.video,
//     // required this.videoData,
//     required this.image,
//     required this.imageData,
//     required this.user,
//     required this.userId,
//     required this.socialGroup,
//     required this.socialGroupId,
//     required this.commentsCount,
//     required this.emotionsCount,
//     this.userEmotion,
//   });
//
//   factory Post.fromJson(Map<String, dynamic> json) {
//     return Post(
//       id: json['id'],
//       content: json['content']??"",
//       // video: json['video'] is String ? json['video'] : '',
//       // videoData: json['video'] is List
//       //     ? List<VideoData>.from(json['video'].map((i) => VideoData.fromJson(i)))
//       //     : null,
//       image: json['image'] is String ? json['image'] : '',
//       imageData: json['image'] is List
//           ? List<ImageData>.from(json['image'].map((i) => ImageData.fromJson(i)))
//           : null,
//       user: User.fromJson(json['user']),
//       userId: json['user_id'],
//       socialGroup: SocialGroup.fromJson(json['socialGroup']),
//       socialGroupId: json['social_group_id'],
//       commentsCount: json['comments_count'],
//       emotionsCount: json['emotions_count'],
//       userEmotion: json['user_emotion']??"",
//     );
//   }
// }
//
// class ImageData {
//   final int id;
//   final String type;
//   final String title;
//   final String alt;
//   final String file;
//   final String thumbnail;
//   ImageSizes sizes;
//
//   ImageData({
//     required this.id,
//     required this.type,
//     required this.title,
//     required this.alt,
//     required this.file,
//     required this.thumbnail,
//     required this.sizes,
//   });
//
//   factory ImageData.fromJson(Map<String, dynamic> json) {
//     return ImageData(
//         id: json['id'],
//         type: json['type']??"",
//         title: json['title']??"",
//         alt: json['alt']??"",
//         file: json['file']??"",
//         thumbnail: json['thumbnail']??"",
//         sizes: ImageSizes.fromJson(json['sizes'])
//     );
//   }
// }
//
//
// // class VideoData {
// //   final int id;
// //   final String type;
// //   final String title;
// //   final String alt;
// //   final String file;
// //   final String thumbnail;
// //   VideoData({
// //     required this.id,
// //     required this.type,
// //     required this.title,
// //     required this.alt,
// //     required this.file,
// //     required this.thumbnail,
// //   });
// //
// //   factory VideoData.fromJson(Map<String, dynamic> json) {
// //     return VideoData(
// //         id: json['id'],
// //         type: json['type']??"",
// //         title: json['title']??"",
// //         alt: json['alt']??"",
// //         file: json['file']??"",
// //         thumbnail: json['thumbnail']??"",
// //     );
// //   }
// // }
//
// class ImageSizes {
//   String thumbnail;
//   String medium;
//   String large;
//   String size1200x800;
//   String size800x1200;
//   String size1200x300;
//   String size300x1200;
//   String webp;
//
//   ImageSizes({
//     required this.thumbnail,
//     required this.medium,
//     required this.large,
//     required this.size1200x800,
//     required this.size800x1200,
//     required this.size1200x300,
//     required this.size300x1200,
//     required this.webp,
//   });
//
//   // Factory constructor to create object from JSON
//   factory ImageSizes.fromJson(Map<String, dynamic> json) {
//     return ImageSizes(
//       thumbnail: json['thumbnail']??"",
//       medium: json['medium']??"",
//       large: json['large']??"",
//       size1200x800: json['1200_800']??"",
//       size800x1200: json['800_1200']??"",
//       size1200x300: json['1200_300']??"",
//       size300x1200: json['300_1200']??"",
//       webp: json['Monthly-WP--Desktop---Ipad-_webp']??"",
//     );
//   }
// }
// class User {
//   final int id;
//   final String? avatar;
//   final String name;
//   final String? username;
//
//   User({
//     required this.id,
//     this.avatar,
//     required this.name,
//     this.username,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       avatar: json['avatar']??"",
//       name: json['name']??"",
//       username: json['username']??"",
//     );
//   }
// }
//
// class SocialGroup {
//   final int id;
//   final String title;
//   final String? image;
//
//   SocialGroup({
//     required this.id,
//     required this.title,
//     this.image,
//   });
//
//   factory SocialGroup.fromJson(Map<String, dynamic> json) {
//     return SocialGroup(
//       id: json['id'],
//       title: json['title']??"",
//       image: json['image']??"",
//     );
//   }
// }
