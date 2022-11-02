import 'package:get/get.dart';
import 'package:graphql/client.dart';
import 'package:spalhe/models/notification.model.dart';
import 'package:spalhe/services/gql/hooks.dart';
import 'package:spalhe/services/gql/queries/notifications.dart';

class NotificationController extends GetxController {
  NotificationModel dataNotification = NotificationModel();

  List<INotification> get notifications =>
      dataNotification.getNotifications?.data ?? [];

  @override
  void onReady() {
    super.onReady();
    getNotifications();
  }

  @override
  void onClose() {
    super.onClose();
  }

  readAll() async {
    try {
      await useMutation(gql(r"""mutation {readAllNotifications}"""));
      await getNotifications();
    } catch (e) {
      print(e);
    }
  }

  getNotifications() async {
    try {
      final res = await useQuery(NOTIFICATION_QUERY, variables: {
        "filters": {},
      });
      dataNotification = NotificationModel.fromJson(res.data!);
      update();
    } catch (e) {
      print(e);
    }
  }
}
