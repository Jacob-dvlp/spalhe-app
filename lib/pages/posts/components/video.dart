import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoApp extends StatefulWidget {
  final String url;
  const VideoApp(this.url, {Key? key}) : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _;

  @override
  void initState() {
    super.initState();
    _ = VideoPlayerController.network(
        'https://spalhe.s3-sa-east-1.amazonaws.com/${widget.url}')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  void handlePlayPause() {
    if (_.value.isPlaying) {
      _.pause();
    } else {
      _.play();
      // _.initialize();
    }
    setState(() {});
  }

  void handleVolume() {
    _.setVolume(_.value.volume == 0 ? 1 : 0);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _.value.isInitialized
        ? Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: AspectRatio(
                    aspectRatio: _.value.aspectRatio,
                    child: VideoPlayer(_),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          child: Icon(
                            _.value.isPlaying
                                ? FeatherIcons.pause
                                : FeatherIcons.play,
                            color: Colors.white,
                          ),
                          onTap: handlePlayPause,
                        ),
                        InkWell(
                          child: Icon(
                            _.value.volume == 0
                                ? FeatherIcons.volumeX
                                : FeatherIcons.volume2,
                            color: Colors.white,
                          ),
                          onTap: handleVolume,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container();
  }

  @override
  void dispose() {
    super.dispose();
    _.dispose();
  }
}
