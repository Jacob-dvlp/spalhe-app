import 'package:get/get.dart';
import 'package:spalhe/models/comment_reply.model.dart';
import 'package:spalhe/models/comments.model.dart';
import 'package:spalhe/services/gql/hooks.dart';
import 'package:spalhe/services/gql/queries/comments.dart';

class CommentsController extends GetxController {
  CommentsModel commentsList = CommentsModel();
  CommentReplyModel repliesList = CommentReplyModel();

  List<IComment>? get comments => commentsList.getCommentsPost?.data ?? [];
  List<AllRepliesByCommentId>? get replies =>
      repliesList.allRepliesByCommentId ?? [];

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  toggleLike(commentId, [postId]) async {
    try {
      await useMutation(TOGGLE_LIKE_COMMENT, variables: {
        'comment_id': commentId,
      });
      await getComments(postId);
    } catch (e) {}
  }

  getComments(postId) async {
    try {
      final res = await useQuery(GET_COMMENTS_POST, variables: {
        'post_id': postId,
        'filters': {'page': 1}
      });
      commentsList = CommentsModel.fromJson(res.data!);
      update();
    } catch (e) {}
  }

  getRepliesComments(commentId) async {
    try {
      final res = await useQuery(GET_ALL_REPLIES_COMMENT_QUERY, variables: {
        'comment_id': commentId,
      });
      repliesList = CommentReplyModel.fromJson(res.data!);
      update();
    } catch (e) {}
  }

  String replyCommentText = '';
  replyComment(commentId, [postId]) async {
    final newText = replyCommentText;
    replyCommentText = '';
    update();
    await useMutation(REPLY_COMMENT_MUTATION, variables: {
      'comment_id': commentId,
      'text': newText,
    });
    await getRepliesComments(commentId);
    await getComments(postId);
  }

  String comment = '';
  commentPost(postId) async {
    try {
      await useMutation(COMMENT_POST_MUTATION, variables: {
        'post_id': postId,
        'data': {
          'text': comment,
        }
      });
      await getComments(postId);
    } catch (e) {}
  }
}
