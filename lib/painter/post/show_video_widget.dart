import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ShowVideoWidget extends StatefulWidget {
  final bool showControls;
  final String post;
  const ShowVideoWidget({required this.showControls, super.key, required this.post});

  @override
  State<ShowVideoWidget> createState() => _ShowVideoWidgetState();
}

class _ShowVideoWidgetState extends State<ShowVideoWidget> {
  VideoPlayerController? controller;
  bool isPlay = false;

  @override
  void initState() {
    controller  = VideoPlayerController.networkUrl(Uri.parse(widget.post));
    controller!.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: ChewieController(
          videoPlayerController: controller!,
          autoPlay: false,
          customControls: widget.showControls
              ? null
              : Center(
                  child: GestureDetector(
                    onTap: () {
                      if (isPlay) {
                        controller!.pause();
                        isPlay = false;
                      } else {
                        controller!.play();
                        isPlay = true;
                      }
                      setState(() {});
                    },
                    child: !isPlay ? const Icon(Icons.play_circle) : null,
                  ),
                ),
          looping: false,
          showControls: true),
    );
  }
}
