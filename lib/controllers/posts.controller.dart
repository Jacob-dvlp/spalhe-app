import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spalhe/models/post.model.dart';
import 'package:spalhe/services/api.dart';
import 'package:spalhe/services/gql/hooks.dart';
import 'package:spalhe/services/gql/queries/posts.dart';
import 'package:spalhe/utils/routes.dart';

class PostController extends GetxController {
  List<AutocompletePrediction>? locations = [];
  final picker = ImagePicker();
  PostModel posts = PostModel();
  PostModel userPost = PostModel();
  PostModel postMedias = PostModel();
  PostModel mentions = PostModel();
  bool loading = true;

  List<XFile> images = [];
  List<XFile> videos = [];
  Map postData = {};

  @override
  void onReady() {
    getPosts();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  setLoading(bool value) {
    loading = value;
    update();
  }

  getPostsPaginated({Map? filters}) async {
    try {
      final res = await useQuery(GET_POSTS_QUERY, variables: {
        "filters": filters ?? {},
      });
      PostModel postsData = PostModel.fromJson(res.data?['getPosts']);
      posts.meta = postsData.meta;
      if (postsData.data?.isEmpty == true) {
        setLoading(false);
        return;
      }
      posts.data = [...posts.data ?? [], ...postsData.data!];
      setLoading(false);
    } catch (e) {
      print(e);
      setLoading(false);
    }
  }

  getPosts() async {
    try {
      setLoading(true);
      final res = await useQuery(GET_POSTS_QUERY, variables: {
        "filters": {},
      });
      posts = PostModel.fromJson(res.data?['getPosts']);
      setLoading(false);
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

  getPostMedia(int userId) async {
    try {
      final res = await useQuery(GET_POST_MEDIA_QUERY, variables: {
        "user_id": userId,
        "filters": {},
      });
      postMedias = PostModel.fromJson(res.data?['getPostMedias']);
      update();
    } catch (e) {
      print(e);
    }
  }

  getPostMentions(int userId) async {
    try {
      final res = await useQuery(GET_POST_MENTIONS_QUERY, variables: {
        "user_id": userId,
        "filters": {},
      });
      mentions = PostModel.fromJson(res.data?['getPostMentions']);
      update();
    } catch (e) {
      print(e);
    }
  }

  getUserPosts(int id) async {
    try {
      userPost = PostModel();
      setLoading(true);
      final res = await useMutation(GET_USER_POSTS_QUERY, variables: {
        'user_id': id,
        'filters': {},
      });
      userPost = PostModel.fromJson(res.data?['getUserPosts']);
      setLoading(false);
    } catch (e) {
      print(e);
      setLoading(false);
    }
  }

  void clearPost() {
    postData = {};
    images = [];
    videos = [];
    update();
  }

  void addImages() async {
    final XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      requestFullMetadata: false,
    );
    if (file == null) {
      return;
    }
    images.add(file);
    update();
  }

  void addVideos() async {
    final file = await picker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: Duration(seconds: 30),
    );
    if (file == null) {
      return;
    }
    videos.add(file);
    update();
  }

  bool postLoading = false;
  void createPost() async {
    try {
      postLoading = true;
      update();
      final res = await useMutation(
        CREATE_POST_MUTATION,
        variables: {
          "data": postData,
        },
      );

      final medias = [...images, ...videos];
      if (medias.isNotEmpty) {
        for (int i = 0; medias.length > i; i++) {
          dio.FormData formData = dio.FormData.fromMap({
            "files": await dio.MultipartFile.fromFile(
              medias[i].path,
              filename: medias[i].name,
            ),
          });
          try {
            await api.post(
              '/posts/${res.data?['createPost']?['id']}/upload',
              data: formData,
            );
          } catch (e) {
            print(e);
          }
        }
      }

      await getPosts();
      postLoading = false;
      clearPost();
      update();
      OnRoute.back();
    } catch (e) {
      print(e);
      postLoading = false;
      update();
    }
  }

  setData(key, value) {
    if (key == 'location') {
      locations = [];
    }
    postData[key] = value;
    update();
  }

  clearLocation() {
    setData('location', null);
  }

  reset() {
    userPost = PostModel();
    postMedias = PostModel();
    mentions = PostModel();
    loading = true;
    images = [];
    videos = [];
    postData = {};
    postLoading = false;
  }

  getPlaces(String text) async {
    try {
      var googlePlace = GooglePlace("AIzaSyDKaVsPe3W7MgICv6kUx4PiG8LwnezD-_8");
      var result =
          await googlePlace.queryAutocomplete.get(text, language: 'pt');
      locations = result?.predictions;
      update();
    } catch (e) {}
  }
}
