import 'package:get/get.dart';
import 'package:spalhe/models/hashtags.model.dart';
import 'package:spalhe/services/gql/hooks.dart';
import 'package:spalhe/services/gql/queries/posts.dart';

class HashtagsController extends GetxController {
  HashtagsModel hashtags = HashtagsModel();

  @override
  void onReady() {
    getHashtags();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getHashtags() async {
    try {
      final res = await useQuery(GET_HASHTAGS);
      hashtags = HashtagsModel.fromJson(res.data!);
      update();
    } catch (e) {
      print(e);
    }
  }
}
