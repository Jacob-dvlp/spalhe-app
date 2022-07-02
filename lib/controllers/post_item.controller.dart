import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:spalhe/models/comments.model.dart';
import 'package:spalhe/models/post.model.dart';
import 'package:spalhe/services/gql/hooks.dart';
import 'package:spalhe/services/gql/queries/posts.dart';

class PostItemController extends GetxController {
  PostItemController({required this.post});
  PostData post;
  CommentsModel? comments;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getComments() async {
    try {
      final res = await useQuery(GET_POST_COMMENTS_QUERY, variables: {
        'post_id': post.id,
        'filters': {'page': 1}
      });
      comments = CommentsModel.fromJson(res.data?['getCommentsPost']);
      update();
    } catch (e) {}
  }

  String comment = '';
  commentPost() async {
    try {
      await useMutation(COMMENT_POST_MUTATION, variables: {
        'post_id': post.id,
        'data': {
          'text': comment,
        }
      });
      post.cCount!.comments = post.cCount!.comments! + 1;
      getComments();
    } catch (e) {}
  }

  likePost() async {
    try {
      post.isLiked = !(post.isLiked ?? false);
      post.cCount!.likes = post.cCount!.likes! + (post.isLiked! ? 1 : -1);
      update();
      await useMutation(LIKE_POST_MUTATION, variables: {
        'postId': post.id,
      });
    } catch (e) {}
  }
}
