import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:spalhe/models/post.model.dart';
import 'package:spalhe/services/api.dart';

class PostController extends GetxController {
  PostModel? posts;
  PostModel? userPost;

  @override
  void onReady() {
    super.onReady();
    getPosts();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getPosts() async {
    try {
      final res = await api.get('/posts');
      posts = PostModel.fromJson(res.data);
      update();
    } catch (e) {
      print(e);
    }
  }

  getByUserId(int id) async {
    try {
      final res = await api.get('/posts/user/$id');
      userPost = PostModel.fromJson(res.data);
      update();
    } catch (e) {
      print(e);
    }
  }
}
