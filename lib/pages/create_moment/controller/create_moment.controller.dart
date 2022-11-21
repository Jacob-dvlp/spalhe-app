import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spalhe/pages/create_moment/models/item_moment.model.dart';
import 'package:spalhe/pages/create_moment/models/music_moment.dart';
import 'package:spalhe/services/gql/hooks.dart';
import 'package:spalhe/services/gql/queries/moment.dart';
import 'package:spalhe/utils/debouncer.dart';
import 'package:spalhe/utils/routes.dart';

class CreateMomentController extends GetxController {
  final player = AudioPlayer();
  Matrix4 currentImage = Matrix4.identity();
  List<ItemMoment> items = [];
  final debounce = new Debouncer(milliseconds: 2000);
  final debounce2 = new Debouncer(milliseconds: 100);
  MusicMomentModel musicsList = MusicMomentModel();
  List<IMusicMoment> get musics => musicsList.searchMusicMoment?.data ?? [];
  bool showDelete = false;
  bool largerDelete = false;

  @override
  void onInit() {
    super.onInit();
    getMusics();
  }

  bool isPlaying = false;
  int playingIndex = 0;

  onBackAndStop() {
    if (isPlaying) {
      player.stop();
      isPlaying = false;
    }
    Get.back();
  }

  onPlayMusic(String url, [index]) async {
    if (isPlaying && playingIndex == index) {
      player.stop();
      isPlaying = false;
    } else {
      playingIndex = index;
      player.setUrl(url);
      player.play();
      isPlaying = true;
    }
    update();
  }

  getMusics([String? search]) async {
    final res = await useQuery(GET_MUSICS_QUERY, variables: {
      'search': search ?? '',
    });
    musicsList = MusicMomentModel.fromJson(res.data!);
    update();
  }

  changeShowDelete(bool value) {
    showDelete = value;
    update();
  }

  changeLargerDelete(bool value) {
    largerDelete = value;
    update();
  }

  onUpdateCurrentImage(m) {
    currentImage = m;
    update();
  }

  onUpdateItemPosition(int index, Matrix4 m) {
    items[index].position = m;
    update();
  }

  removeItem(int index) {
    items.removeAt(index);
    update();
  }

  addItem(ItemMoment item) {
    items.add(item);
    update();
    OnRoute.back();
  }
}
