import 'package:get/get.dart';
import 'package:spalhe/models/likes_in_post.model.dart';
import 'package:spalhe/services/gql/hooks.dart';
import 'package:spalhe/services/gql/queries/posts.dart';

class LikesInPostController extends GetxController {
  LikesInPostModel userLikes = LikesInPostModel();
  bool loading = false;

  setLoading(bool value) {
    loading = value;
    update();
  }

  getLikesInPost(postId) async {
    try {
      userLikes = LikesInPostModel();
      setLoading(true);
      final res = await useQuery(GET_POST_LIKES_QUERY, variables: {
        'id': postId,
      });
      userLikes = LikesInPostModel.fromJson(res.data!);
      setLoading(false);
    } catch (e) {
      print(e);
      setLoading(false);
    }
  }
}
