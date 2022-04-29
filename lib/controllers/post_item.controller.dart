import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:spalhe/models/comments.model.dart';
import 'package:spalhe/models/post.model.dart';
import 'package:spalhe/services/api.dart';

class PostItemController extends GetxController {
  PostItemController({required this.post});
  PostData post;
  List<CommentsModel>? comments;

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
      final res = await api.get('/comments/${post.id}');
      List<CommentsModel> list = [];
      for (int i = 0; res.data.length > i; i++) {
        list.add(CommentsModel.fromJson(res.data[i]));
      }
      comments = list;
      update();
    } catch (e) {
      print({'allComments', e});
    }
  }

  String comment = '';
  commentPost() async {
    try {
      await api.post('/comments/${post.id}', data: {
        "text": comment,
      });
      getComments();
    } catch (e) {
      print({'comment', e});
    }
  }

  likePost(int userId) async {
    try {
      await api.get('/likes/${post.id}');
      final isLiked =
          (post.likes ?? []).indexWhere((el) => el.userId == userId);
      if (isLiked == -1) {
        final like = Likes(userId: userId);
        post.likes!.add(like);
      } else {
        post.likes!.removeWhere((el) => el.userId == userId);
      }
      update();
    } catch (e) {
      print(e);
    }
  }
}
