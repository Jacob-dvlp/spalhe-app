import 'package:get/get.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:spalhe/models/post.model.dart';
import 'package:spalhe/services/gql/hooks.dart';
import 'package:spalhe/services/gql/queries/liked_posts.dart';

class LikedPostsController extends GetxController {
  PostModel postsData = PostModel();
  List<PostData> get posts => postsData.data ?? [];

  @override
  void onInit() {
    super.onInit();
    final AuthController authController = Get.put(AuthController());
    getLikedPosts(authController.auth.user?.id, {});
  }

  getLikedPosts(userId, filters) async {
    try {
      final res = await useQuery(GET_LIKED_POSTS_QUERY, variables: {
        'user_id': userId,
        'filters': filters ?? {},
      });
      postsData = PostModel.fromJson(res.data?['getLikedPosts']);

      update();
    } catch (e) {
      print(e);
    }
  }
}
