import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:spalhe/models/followeds.model.dart';
import 'package:spalhe/models/followers.model.dart';
import 'package:spalhe/services/gql/hooks.dart';
import 'package:spalhe/services/gql/queries/follows.dart';

class FollowsController extends GetxController {
  FollowedModel? followedsData;
  FollowerModel? follwersData;

  List<FollowedData> get followeds => followedsData?.getFollowed?.data ?? [];
  List<FollowerData> get followers => follwersData?.getFollowers?.data ?? [];

  bool isLoading = false;

  setLoading(bool value) {
    isLoading = value;
    update();
  }

  getFollowers(int id) async {
    try {
      setLoading(true);
      final res = await useQuery(GET_FOLLOWERS_QUERY, variables: {
        "user_id": id,
        "filters": {"order_by": "created_at"}
      });
      follwersData = FollowerModel.fromJson(res.data!);
      setLoading(false);
    } catch (e) {
      setLoading(false);
    }
  }

  getFolloweds(int id) async {
    try {
      setLoading(true);
      final res = await useQuery(GET_FOLLOWEDS_QUERY, variables: {
        "user_id": id,
        "filters": {"order_by": "created_at"}
      });
      followedsData = FollowedModel.fromJson(res.data!);
      setLoading(false);
    } catch (e) {
      setLoading(false);
    }
  }
}
