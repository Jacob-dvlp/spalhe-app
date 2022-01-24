import 'package:spalhe/controllers/auth/auth.dart';
import 'package:spalhe/services/api.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  Map user = AuthController().auth['user'];
  int tabIndex = 0;
  List photos = [];
  List posts = [];

  @override
  void onReady() async {
    super.onReady();
    getProfile();
    getPhotos();
    getPosts();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // GET GRID POSTS
  void getPhotos() async {
    try {
      final res = await API.get('/users/${user['id']}/photos');
      photos = res.data;
      update();
    } catch (err) {
      //
    }
  }

  // GET LIST POSTS
  void getPosts() async {
    try {
      final res = await API.get('/users/${user['id']}/posts');
      posts = res.data;
      update();
    } catch (e) {
      //
    }
  }

  void getProfile() async {
    try {
      final res = await API.get('/users/${user['id']}');
      user = res.data;
      AuthController().changeUserData(user);
      update();
    } catch (e) {
      //
    }
  }

  void onChangeIndexPage(int index) {
    tabIndex = index;
    update();
  }

  void deletePost(id) async {
    try {
      await API.delete('/posts/$id');
      getPosts();
      Get.back();
    } catch (e) {
      print(e);
    }
  }

  void sharePost(id) async {
    try {
      await API.post('/reply/$id', {});
      getPosts();
    } catch (e) {
      print(e);
    }
  }

  void likePost(id) async {
    var index = posts.indexWhere((element) => id == element['id']);
    if (posts[index]['liked'] == null) {
      posts[index]['liked'] = "liked";
      posts[index]['__meta__']['likes_count'] =
          posts[index]['__meta__']['likes_count'] + 1;
    } else {
      posts[index]['liked'] = null;
      posts[index]['__meta__']['likes_count'] =
          posts[index]['__meta__']['likes_count'] - 1;
    }
    update();
    await API.post('/like', {"post_id": posts[index]['id']});
  }
}
