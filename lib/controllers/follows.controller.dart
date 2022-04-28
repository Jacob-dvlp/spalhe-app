import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:spalhe/models/followeds.model.dart';
import 'package:spalhe/models/followers.model.dart';
import 'package:spalhe/services/api.dart';

class FollowsController extends GetxController {
  FollowedsModel? followeds;
  FollowersModel? follwers;
  FollowedsModel? myFolloweds;
  FollowersModel? myFollwers;

  FollowsController() {
    getMyFollowers();
  }

  getMyFollowers() async {
    try {
      final res = await api.get('/follows/followers');
      myFollwers = FollowersModel.fromJson(res.data);
      update();
    } catch (e) {}
  }

  getFollowers(int id) async {
    try {
      final res = await api.get('/follows/$id/followers');
      follwers = FollowersModel.fromJson(res.data);
      update();
    } catch (e) {}
  }

  getFolloweds(int id) async {
    try {
      final res = await api.get('/follows/$id/followeds');
      followeds = FollowedsModel.fromJson(res.data);
      update();
    } catch (e) {}
  }
}
