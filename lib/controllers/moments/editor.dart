import 'dart:io';
import 'package:spalhe/controllers/posts/posts.dart';
import 'package:spalhe/services/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

class EditorController extends GetxController {
  ScreenshotController screenshotController = ScreenshotController();
  PostsController postsController = Get.put(PostsController());
  final ValueNotifier<Matrix4> imageview = ValueNotifier(Matrix4.identity());
  var textEnable = false;
  List texts = [];
  final textController = TextEditingController();
  List<Matrix4> positions = [];
  List scalesRotation = [];
  List colors = [
    Colors.white,
    Colors.grey[900],
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.blue
  ];
  var colorSelected = 0;

  @override
  void onClose() {
    super.onClose();
    textController.dispose();
  }

  var loading = false;
  void createMoment() async {
    loading = true;
    update();
    try {
      const String dirPath = 'Tests/Photos/Spalhe';
      await Directory(dirPath).create(recursive: true);
      var image = await screenshotController.capture(
        pixelRatio: 1.5,
      );
      List images = [];
      images.add({'path': image?.first});
      await API.uploadMultiples('/upload/moments', images);
      Get.back();
      Get.back();
      postsController.getMoments();
      loading = false;
      update();
    } catch (e) {
      loading = false;
      update();
    }
  }

  void setTextEnable() {
    textEnable = !textEnable;
    update();
  }

  void updateImageView(m) {
    imageview.value = m;
    update();
  }

  void selectColor(index) {
    colorSelected = index;
    update();
  }

  void addText() {
    Matrix4 matrix = Matrix4.identity();
    positions.add(matrix);
    texts.add({'text': textController.text, 'color': colorSelected});
    textController.text = '';
    textEnable = false;
    update();
  }

  void changePositionText(index, pos) {
    positions[index] = pos;
    update();
  }

  void changeScaleRotationText(index, pos) {
    Matrix4 matrix = Matrix4.identity();
    if (!!pos) matrix = pos;
    scalesRotation[index] = matrix;
    update();
  }

  void removeText(index) {
    texts.removeAt(index);
    positions.removeAt(index);
    update();
  }
}
