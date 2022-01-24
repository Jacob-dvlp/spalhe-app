import 'package:spalhe/services/api.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  final id;
  PostController(this.id);
  var post = {};
  var comments = [];
  final textController = TextEditingController();

  @override
  void onReady() {
    super.onReady();
    getPost();
    getComments();
  }

  @override
  void onClose() {
    super.onClose();
  }

  bool postLoading = true;
  bool postError = false;
  void getPost() async {
    try {
      var value = await API.get('/posts/$id');
      post = value.data;
      postLoading = false;
      update();
    } catch (e) {
      print('erro');
      postLoading = false;
      postError = true;
      update();
    }
  }

  void getComments() async {
    try {
      var res = await API.get('/comments/$id');
      comments = res.data;
      update();
    } catch (e) {
      //
    }
  }

  void comment() async {
    try {
      var res = await API.post('/comments', {
        "text": textController.text,
        "post_id": id,
      });
      print(res);
      textController.text = '';
      getComments();
    } catch (e) {
      print(e);
    }
  }
}
