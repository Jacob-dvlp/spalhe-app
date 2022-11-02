import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:spalhe/models/hashtags.model.dart';
import 'package:spalhe/models/post.model.dart';
import 'package:spalhe/services/gql/hooks.dart';
import 'package:spalhe/services/gql/queries/posts.dart';

class HashtagsController extends GetxController {
  HashtagsModel hashtags = HashtagsModel();
  PostModel posts = PostModel();

  @override
  void onReady() {
    getHashtags();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getPostsByHashTags(String hashtags) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        posts = PostModel();
        update();
      });
      final res = await useQuery(GET_POSTS_BY_HASHTAG, variables: {
        'hashtag': hashtags,
      });
      posts = PostModel.fromJson(res.data!['getPostsByHashtags']);
      update();
    } catch (e) {
      print(e);
    }
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
