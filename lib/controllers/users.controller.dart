import 'package:get/get.dart';
import 'package:spalhe/models/users.model.dart';
import 'package:spalhe/services/gql/hooks.dart';
import 'package:spalhe/services/gql/queries/user.dart';

class UserController extends GetxController {
  UsersModel? users;
  UsersModel? blockedUsers;

  @override
  void onReady() {
    getUsers();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getUsers({Map? filters}) async {
    try {
      final res = await useQuery(GET_USERS_QUERY, variables: {
        'filters': filters ?? {},
        'filter_follows': true,
      });
      users = UsersModel.fromJson(res.data?['getUsers']);
      update();
    } catch (e) {
      print(e);
    }
  }

  getBlockedUsers({Map? filters}) async {
    try {
      final res = await useQuery(GET_BLOCKED_USERS_QUERY, variables: {
        'filters': filters ?? {},
      });
      blockedUsers = UsersModel.fromJson(res.data?['getBlockedUsers']);
      update();
    } catch (e) {
      print(e);
    }
  }

  blockUser(int userId) async {
    try {
      await useMutation(BLOCK_USER_MUTATION, variables: {
        'user_id': userId,
      });
      await getBlockedUsers();
    } catch (e) {}
  }

  followUser(userId, [index]) async {
    try {
      if (index != null) {
        if (users!.data![index].followed == 'following') {
          users!.data![index].followed = 'not_following';
        } else {
          users!.data![index].followed = 'following';
        }
        users = users;
        update();
      }
      await useMutation(FOLLOW_USER_MUTATION, variables: {
        "followed_id": userId,
      });

      if (index == null) {
        getUsers();
      }
    } catch (e) {
      print(e);
    }
  }
}
