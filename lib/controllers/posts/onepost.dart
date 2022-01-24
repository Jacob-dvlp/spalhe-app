import 'package:spalhe/controllers/posts/posts.dart';
import 'package:spalhe/services/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnePostController extends GetxController {
  PostsController postsController = Get.put(PostsController());
  final post;
  List likes = [];
  OnePostController({this.post});
  bool deleted = false;
  int currentSlide = 0;

  @override
  void onReady() {
    super.onReady();
    getLikes();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void deletePost(id) async {
    try {
      await API.delete('/posts/$id');
      postsController.getPosts();
      deleted = true;
      update();
      Get.back();
    } catch (e) {
      print(e);
    }
  }

  void addCurrentSlide(page) {
    currentSlide = int.parse(page.toString());
    update();
  }

  void sharePost(id) async {
    try {
      await API.post('/share/$id', {});
      postsController.getPosts();
      Get.snackbar(
        'Sucesso',
        'Você compartilhou essa publicação no seu perfil',
        backgroundColor: Colors.greenAccent,
        colorText: Colors.white,
        margin: EdgeInsets.all(14),
      );
    } catch (e) {
      Get.snackbar(
        'Desculpe',
        'Não foi possivel compartilhar essa publicação',
        margin: EdgeInsets.all(14),
      );
    }
  }

  void likePost(id) async {
    if (post['liked'] == null) {
      post['liked'] = "liked";
      post['__meta__']['likes_count'] = post['__meta__']['likes_count'] + 1;
    } else {
      post['liked'] = null;
      post['__meta__']['likes_count'] = post['__meta__']['likes_count'] - 1;
    }
    update();
    await API.post('/like', {"post_id": post['id']});
  }

  getLikes() async {
    try {
      var res = await API.get('likes/${post['id']}');
      likes = res.data;
      update();
    } catch (e) {
      //
    }
  }
}
