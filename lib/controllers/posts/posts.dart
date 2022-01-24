import 'package:spalhe/services/api.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PostsController extends GetxController {
  List posts = [];
  List moments = [];
  List images = [];
  TextEditingController textController = TextEditingController();
  List momentViews = [];

  @override
  void onReady() {
    super.onReady();
    getPosts();
    getMoments();
  }

  @override
  void onClose() {
    super.onClose();
    textController.dispose();
  }

  addMomentView(moment) {
    momentViews.add(moment);
    update();
  }

  Future<void> getPosts() async {
    try {
      loading = true;
      update();
      var value = await API.get('/posts');
      posts = value.data['data'];
      loading = false;
      update();
    } catch (e) {
      loading = false;
      update();
    }
  }

  Future<void> getMoments() async {
    API.get('/moments').then((value) {
      moments = value.data;
      update();
    }).catchError((err) {
      //
    });
  }

  var loading = false;
  void post() async {
    try {
      if (textController.text.isEmpty && images.isEmpty) return;
      loading = true;
      update();
      final res = await API.post('/posts', {
        "text": textController.text,
      });
      if (images.isNotEmpty) {
        try {
          await API.uploadMultiples(
            '/upload/posts/${res.data['id']}',
            images,
          );
          images = [];
        } catch (err) {}
      }
      Get.back();
      textController.text = '';
      loading = false;
      update();
      getPosts();
    } catch (err) {
      loading = false;
      update();
    }
  }

  final picker = ImagePicker();
  Future getImageFile() async {
    await picker.pickImage(source: ImageSource.gallery).then((res) {
      if (res != null) {
        final img = {"path": res.path};
        images.add(img);
      }
      update();
    });
  }

  Future getVideoFile() async {
    await picker.pickVideo(source: ImageSource.gallery).then((res) {
      if (res != null) {
        final img = {"path": res.path};
        images.add(img);
      }
      update();
    });
  }

  void removeImage(index) {
    images.removeAt(index);
    update();
  }
}
