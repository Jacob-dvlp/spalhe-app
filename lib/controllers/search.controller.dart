import 'package:get/get.dart';
import 'package:spalhe/models/users.model.dart';
import 'package:spalhe/services/gql/hooks.dart';
import 'package:spalhe/services/gql/queries/user.dart';

class SearchController extends GetxController {
  UsersModel? users;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getUsers(String search) async {
    try {
      final res = await useQuery(GET_USERS_QUERY, variables: {
        'filters': {
          "search": search,
        },
        'filter_follows': false,
      });
      users = UsersModel.fromJson(res.data?['getUsers']);
      update();
    } catch (e) {
      print(e);
    }
  }
}
