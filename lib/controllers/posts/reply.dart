import 'package:spalhe/services/api.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ReplyController extends GetxController {
  final id;
  ReplyController(this.id);
  var replys = [];
  final textController = TextEditingController();

  @override
  void onReady() {
    super.onReady();
    getReplys();
  }

  void getReplys() {
    API.get('/reply/$id').then((value) {
      replys = value.data;
      update();
    }).catchError((err) {});
  }

  void reply() async {
    try {
      await API.post('/reply/$id', {
        "text": textController.text,
      });
      textController.text = '';
      getReplys();
    } catch (e) {}
  }
}
