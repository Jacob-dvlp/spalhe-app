import 'package:get/get.dart';
import 'package:spalhe/components/layout/dialog/dialog.dart';
import 'package:spalhe/models/post.model.dart';
import 'package:spalhe/services/gql/hooks.dart';
import 'package:spalhe/services/gql/queries/posts.dart';
import 'package:spalhe/utils/routes.dart';

class PostItemController extends GetxController {
  PostItemController({required this.post}) {}
  PostData post = PostData();

  bool deleted = false;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  deletePost(int postId) async {
    try {
      await useMutation(DELETE_POST_MUTATION, variables: {
        'post_id': postId,
      });
      deleted = true;
      update();
      OnRoute.back();
    } catch (e) {}
  }

  reportPost(int postId) async {
    return showDialogModal(
      title: 'Denunciar publicação',
      description: 'Tem certeza que deseja denunciar essa publicação?',
      confirmText: 'Denunciar',
      onConfirm: () async {
        try {
          await useMutation(REPORT_POST_MUTATION, variables: {
            'post_id': postId,
          });
          deleted = true;
          update();
          OnRoute.back();
        } catch (e) {}
      },
    );
  }

  savePost() async {
    try {
      post.isSaved = !(post.isSaved ?? false);
      update();
      await useMutation(SAVE_POST_MUTATION, variables: {
        'post_id': post.id,
      });
    } catch (e) {
      print(e);
    }
  }

  likePost() async {
    try {
      post.isLiked = !(post.isLiked ?? false);
      post.cCount!.likes = post.cCount!.likes! + (post.isLiked! ? 1 : -1);
      update();
      await useMutation(LIKE_POST_MUTATION, variables: {
        'postId': post.id,
      });
    } catch (e) {
      print(e);
    }
  }
}
