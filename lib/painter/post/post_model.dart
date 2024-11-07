enum MediaType { image, video }

class MediaItem {
  final String url;
  final MediaType type; // Either image or video

  MediaItem({required this.url, required this.type});
}

class PostModel {
  final List<MediaItem> mediaItems;

  PostModel({

    required this.mediaItems,
  });
}
