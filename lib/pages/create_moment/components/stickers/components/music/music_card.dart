import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spalhe/components/layout/image/image.dart';
import 'package:spalhe/pages/create_moment/components/stickers/components/music/cardImageMusic.dart';
import 'package:spalhe/pages/create_moment/models/item_moment.model.dart';

class MusicController extends GetxController {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;

  onPlay(url) {
    if (!audioPlayer.playerState.playing) {
      audioPlayer.play();
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      isPlaying = true;
      audioPlayer.stop();
      audioPlayer.setUrl(url);
      audioPlayer.play();
    });
  }
}

class MusicCardMoment extends StatelessWidget {
  final MusicModel music;

  final controller = Get.put(MusicController());

  MusicCardMoment({required this.music}) {
    if (!controller.isPlaying) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        controller.onPlay(music.url);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            controller.onPlay(music.url);
          },
          child: Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CardImageMusic(),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: ImageNetwork(
                        src: music.preview ?? '',
                        width: 65,
                        height: 65,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      music.title ?? '',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      music.artistName ?? '',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                SizedBox(width: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
