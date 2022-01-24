import 'dart:io';

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  VideoController({required this.url});

  late VideoPlayerController controller;
  final File url;

  @override
  void onReady() {
    super.onReady();
    controller = VideoPlayerController.file(url);
    controller.initialize();
  }
}
