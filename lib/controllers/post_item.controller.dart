import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:spalhe/models/comments.model.dart';
import 'package:spalhe/models/post.model.dart';
import 'package:spalhe/services/api.dart';

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
      final res = await api.get('/comments/${post.id}');
      comments = CommentsModel.fromJson(res.data);
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
      post.cCount!.comments = post.cCount!.comments! + 1;
      getComments();
    } catch (e) {
      print({'comment', e});
    }
  }

  likePost(int userId) async {
    //
  }
}
