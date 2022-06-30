import 'package:get/get.dart';
import 'package:spalhe/models/post.model.dart';

class ProfileController extends GetxController {
  int tab = 0;

  List<PostData> mentions = [];

  getPostMentions() {}

  changeIndex(int i) {
    tab = i;
    update();
  }
}
