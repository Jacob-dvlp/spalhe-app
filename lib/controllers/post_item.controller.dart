import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:spalhe/models/likes_in_post.model.dart';
import 'package:spalhe/models/post.model.dart';
import 'package:spalhe/services/gql/hooks.dart';
import 'package:spalhe/services/gql/queries/posts.dart';

class PostItemController extends GetxController {
  PostItemController({required this.post}) {}
  PostData post = PostData();
  LikesInPostModel userLikes = LikesInPostModel();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  likePost() async {
    try {
      print(post.id);
      post.isLiked = !(post.isLiked ?? false);
      post.cCount!.likes = post.cCount!.likes! + (post.isLiked! ? 1 : -1);
      update();
      await useMutation(LIKE_POST_MUTATION, variables: {
        'postId': post.id,
      });
    } catch (e) {}
  }

  getLikesInPost() async {
    try {
      final res = await useQuery(GET_POST_LIKES_QUERY, variables: {
        'id': post.id,
      });
      userLikes = LikesInPostModel.fromJson(res.data!);
      update();
    } catch (e) {
      print(e);
    }
  }
}
