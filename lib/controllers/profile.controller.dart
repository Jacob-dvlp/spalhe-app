import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:spalhe/models/auth.dart';
import 'package:spalhe/models/user.model.dart';
import 'package:spalhe/services/api.dart';
import 'package:spalhe/services/gql/hooks.dart';
import 'package:spalhe/services/gql/queries/user.dart';

class ProfileController extends GetxController {
  static final box = GetStorage();
  AuthModel auth = AuthModel.fromJson(box.read('auth') ?? {});
  UserModel profile = UserModel();
  int tab = 0;

  @override
  void onReady() {
    super.onReady();
    if (auth.user != null) {
      profile = auth.user!;
      update();
    }
  }

  getUser(int userId) async {
    try {
      final res = await useQuery(GET_USER_QUERY, variables: {
        'id': userId,
      });
      profile = UserModel.fromJson(res.data?['getUser']);
      update();
    } catch (e) {}
  }

  follow(int userId) async {
    try {
      await api.post(
        '/follows',
        data: {"user_id": userId},
      );
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
    tab = 0;
  }
}
