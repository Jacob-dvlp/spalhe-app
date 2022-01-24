import 'package:spalhe/services/api.dart';
import 'package:get/get.dart';

class ExploreController extends GetxController {
  var images = [];
  var users = [];

  @override
  void onReady() {
    super.onReady();
    getImages();
    getUsers();
  }

  // FETCH POSTS DATA
  Future<void> getImages() async {
    try {
      var value = await API.get('/explore/images');
      images = value.data;
      update();
    } catch (e) {}
  }

  Future<void> getUsers() async {
    try {
      var value = await API.get('/unfollowusers');
      users = value.data;
      update();
    } catch (e) {}
  }
}
