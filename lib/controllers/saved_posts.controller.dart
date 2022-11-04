import 'package:get/get.dart';
import 'package:spalhe/models/post.model.dart';
import 'package:spalhe/services/gql/hooks.dart';
import 'package:spalhe/services/gql/queries/posts.dart';

class SavedPostsController extends GetxController {
  List<PostData> _savedPosts = <PostData>[];
  List<PostData> get savedPosts => _savedPosts;
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getPosts();
    super.onReady();
  }

  setLoading(bool value) {
    isLoading = value;
    update();
  }

  getPosts() async {
    try {
      setLoading(true);
      final res = await useQuery(GET_SAVED_POSTS, variables: {
        "filters": {
          "per_page": 50,
        },
      });
      final data = res.data?['getSavedPosts'];
      _savedPosts = data['data']
          .map<PostData>((post) => PostData.fromJson(post))
          .toList();
      setLoading(false);
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }
}
