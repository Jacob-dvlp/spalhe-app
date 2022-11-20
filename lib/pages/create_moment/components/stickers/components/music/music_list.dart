import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spalhe/components/layout/image/image.dart';
import 'package:spalhe/pages/create_moment/controller/create_moment.controller.dart';

class MusicList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreateMomentController>();
    final debouncer = new Debouncer(delay: Duration(milliseconds: 500));

    onPlayMusic(String url) async {
      final player = AudioPlayer();
      await player.setUrl(url);
      await player.play();
      // await player.pause();
    }

    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: TextField(
                onChanged: (value) {
                  debouncer.call(() {
                    controller.getMusics(value);
                  });
                },
                keyboardType: TextInputType.multiline,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: 'Pesquise sua música'.tr,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  filled: true,
                  fillColor: Get.theme.scaffoldBackgroundColor.withOpacity(0.2),
                ),
              ),
            ),
          ),
          Expanded(
            child: GetBuilder<CreateMomentController>(
              init: CreateMomentController(),
              builder: (controller) {
                final musics = controller.musics;

                return ListView(
                  padding: EdgeInsets.all(20),
                  children: List.generate(
                    musics.length,
                    (index) => InkWell(
                      onTap: () => onPlayMusic(musics[index].preview!),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            ImageNetwork(
                              src: musics[index].album?.cover,
                              width: 60,
                              height: 60,
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    musics[index].title ?? '',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    musics[index].album?.title ?? '',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                FeatherIcons.playCircle,
                                color: Colors.white,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
