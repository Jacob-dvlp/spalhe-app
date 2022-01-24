import 'package:spalhe/services/api.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  Map user;
  UserController(this.user);
  int tabIndex = 0;
  var photos = [];
  var posts = [];

  @override
  void onReady() {
    super.onReady();
    getProfile();
    getPhotos();
    getPosts();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void followUser() {
    API.post('/follow/${user['id']}', {}).then((value) {
      user['followed'] = true;
      update();
    });
  }

  void unfollowUser() {
    API.post('/unfollow/${user['id']}', {}).then((value) {
      user['followed'] = null;
      update();
    });
  }

  // GET GRID POSTS
  void getPhotos() {
    API.get('/users/${user['id']}/photos').then((value) {
      photos = value.data;
      update();
    });
  }

  // GET LIST POSTS
  void getPosts() {
    API.get('/users/${user['id']}/posts').then((value) {
      posts = value.data;
      update();
    });
  }

  void getProfile() {
    API.get('/users/${user['id']}').then((value) {
      user = value.data;
      update();
    });
  }

  void onChangeIndexPage(int index) {
    tabIndex = index;
    update();
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
