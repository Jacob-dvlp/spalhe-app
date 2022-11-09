import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:spalhe/models/followeds.model.dart';
import 'package:spalhe/models/followers.model.dart';
import 'package:spalhe/services/api.dart';

class FollowsController extends GetxController {
  FollowedModel? followeds;
  FollowerModel? follwers;

  getFollowers(int id) async {
    try {
      final res = await api.get('/follows/$id/followers');
      follwers = FollowerModel.fromJson(res.data);
      update();
    } catch (e) {}
  }

  getFolloweds(int id) async {
    try {
      final res = await api.get('/follows/$id/followeds');
      followeds = FollowedModel.fromJson(res.data);
      update();
    } catch (e) {}
  }
}
