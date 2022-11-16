import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:spalhe/models/auth.dart';
import 'package:spalhe/models/user.model.dart';
import 'package:spalhe/services/gql/hooks.dart';
import 'package:spalhe/services/gql/queries/user.dart';

class ProfileController extends GetxController {
  UserModel profile = UserModel();
  int tab = 0;
  bool showMoreUsers = false;
  bool isLoading = false;

  @override
  void onReady() {
    super.onReady();
  }

  toggleShowMoreUsers() {
    showMoreUsers = !showMoreUsers;
    update();
  }

  setLoading(bool value) {
    isLoading = value;
    update();
  }

  blockUser(int userId) async {
    try {
      await useMutation(BLOCK_USER_MUTATION, variables: {
        'user_id': userId,
      });
      Get.back();
      Get.back();
    } catch (e) {}
  }

  getUser(int userId) async {
    try {
      // profile = UserModel();
      setLoading(true);
      final res = await useQuery(GET_USER_QUERY, variables: {
        "id": userId,
      });
      profile = UserModel.fromJson(res.data?['getUser']);
      setLoading(false);
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

  Future<UserModel> getUserByUsername(String username) async {
    try {
      profile = UserModel();
      setLoading(true);
      final res = await useQuery(GET_USER_BY_USERNAME_QUERY, variables: {
        "username": username,
      });
      profile = UserModel.fromJson(res.data?['getUserByUsername']);
      setLoading(false);
      return profile;
    } catch (e) {
      setLoading(false);
      print(e);
      throw e;
    }
  }

  follow(int userId) async {
    try {
      await useMutation(FOLLOW_USER_MUTATION, variables: {
        "followed_id": userId,
      });

      getUser(userId);
    } catch (e) {
      print(e);
    }
  }

  changeIndex(int i) {
    tab = i;
    update();
  }

  reset() {
    profile = UserModel();
    tab = 0;
  }
}
