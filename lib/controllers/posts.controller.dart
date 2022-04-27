import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spalhe/models/post.model.dart';
import 'package:spalhe/services/api.dart';

class PostController extends GetxController {
  final picker = ImagePicker();
  PostModel? posts;
  PostModel? userPost;

  List<XFile> images = [];
  List<XFile> videos = [];

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

  void clearPost() {
    images = [];
    update();
  }

  void addImages() async {
    final XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
      maxHeight: 500,
    );
    if (file == null) {
      return;
    }
    images.add(file);
    update();
  }

  void addVideos() async {
    final file = await picker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: Duration(seconds: 30),
    );
    if (file == null) {
      return;
    }
    videos.add(file);
    update();
  }
}
