import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/pages/create_moment/models/item_moment.model.dart';
import 'package:spalhe/utils/routes.dart';

class CreateMomentController extends GetxController {
  Matrix4 currentImage = Matrix4.identity();
  List<ItemMoment> items = [];

  void onUpdateCurrentImage(m) {
    currentImage = m;
    update();
  }

  onUpdateItemPosition(int index, Matrix4 m) {
    items[index].position = m;
    update();
  }

  addItem(ItemMoment item) {
    items.add(item);
    update();
    OnRoute.back();
  }
}
