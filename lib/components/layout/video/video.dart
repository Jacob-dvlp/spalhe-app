import 'package:flutter/material.dart';
import 'package:spalhe/theme/colors.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerComponent extends StatefulWidget {
  final String videoUrl;
  final double? aspect;
  const VideoPlayerComponent({
    Key? key,
    required this.videoUrl,
    this.aspect = 16 / 9,
  }) : super(key: key);

  @override
  State<VideoPlayerComponent> createState() => VideoPlayerState();
}

class VideoPlayerState extends State<VideoPlayerComponent> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.videoUrl)..initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: AspectRatio(
            aspectRatio: widget.aspect ?? 16 / 9,
            child: VideoPlayer(
              _controller,
            ),
          ),
        ),
        VideoProgressIndicator(
          _controller,
          allowScrubbing: true,
          colors: VideoProgressColors(
            playedColor: primary,
            bufferedColor: primary.withOpacity(0.2),
            backgroundColor: Colors.grey.shade300,
          ),
          padding: EdgeInsets.all(10),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              icon: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            )
          ],
        )
      ],
    );
  }
}
