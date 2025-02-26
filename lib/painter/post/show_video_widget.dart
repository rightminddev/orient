import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ShowVideoWidget extends StatefulWidget {
  final bool showControls;
  final String post;

  ShowVideoWidget({required this.showControls, super.key, required this.post});

  @override
  State<ShowVideoWidget> createState() => _ShowVideoWidgetState();
}

class _ShowVideoWidgetState extends State<ShowVideoWidget> {
  VideoPlayerController? _controller;
  late ChewieController _chewieController;
  bool _isPlay = false;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
    _controller!.addListener(() {
      if (_controller!.value.hasError) {
        print('Video player error: ${_controller!.value.errorDescription}');
      }
    });

  }

  Future<void> _initializeVideoPlayer() async {
    _controller = VideoPlayerController.network(widget.post,videoPlayerOptions: VideoPlayerOptions(
      mixWithOthers: false,allowBackgroundPlayback: true),);
    await _controller!.initialize();
    setState(() {
      _isInitialized = true;
    });

    _chewieController = ChewieController(
      videoPlayerController: _controller!,
      autoPlay: false,
      customControls: widget.showControls
          ? null
          : GestureDetector(
        onTap: () {
          setState(() {
            if (_isPlay) {
              _controller!.pause();
            } else {
              _controller!.play();
            }
            _isPlay = !_isPlay;
          });
        },
        child: Center(
          child: !_isPlay
              ? const Icon(Icons.play_circle, size: 64, color: Colors.white)
              : null,
        ),
      ),
      looping: false,
      showControls: widget.showControls,
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }
    return Chewie(
      controller: _chewieController,
    );
  }
}
