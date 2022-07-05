import 'package:get/get.dart';
import 'package:spalhe/models/users.model.dart';
import 'package:spalhe/services/gql/hooks.dart';
import 'package:spalhe/services/gql/queries/user.dart';

class UserController extends GetxController {
  UsersModel? users;

  @override
  void onReady() {
    getUsers();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getUsers() async {
    try {
      final res = await useQuery(GET_USERS_QUERY, variables: {
        'filters': {},
        'filter_follows': true,
      });
      users = UsersModel.fromJson(res.data?['getUsers']);
      update();
    } catch (e) {
      print(e);
    }
  }
}
