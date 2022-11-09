import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:spalhe/theme/colors.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerComponent extends StatefulWidget {
  final String videoUrl;
  final double? aspect;
  const VideoPlayerComponent({
    Key? key,
    required this.videoUrl,
    this.aspect = 8 / 9,
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
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: VideoPlayer(
            _controller,
          ),
        ),
        Column(
          children: [
            VideoProgressIndicator(
              _controller,
              allowScrubbing: true,
              colors: VideoProgressColors(
                playedColor: primary,
                bufferedColor: primary.withOpacity(0.2),
                backgroundColor: Colors.grey.shade300,
              ),
              padding: EdgeInsets.all(0),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _controller
                        .setVolume(_controller.value.volume == 0 ? 100 : 0);
                  });
                },
                icon: Icon(
                  _controller.value.volume == 0
                      ? FeatherIcons.volume2
                      : FeatherIcons.volumeX,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
