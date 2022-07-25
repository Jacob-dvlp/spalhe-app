import 'package:get/get.dart';
import 'package:spalhe/models/post.model.dart';
import 'package:spalhe/services/gql/hooks.dart';
import 'package:spalhe/services/gql/queries/explore.dart';

class ExploreController extends GetxController {
  PostModel? postMedias;

  @override
  void onReady() {
    super.onReady();
    getPostMedia();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getPostMedia() async {
    try {
      final res = await useQuery(EXPLORE_MEDIAS_QUERY, variables: {
        "filters": {},
      });
      postMedias = PostModel.fromJson(res.data?['getExploreMedias']);
      update();
    } catch (e) {
      print(e);
    }
  }
}
