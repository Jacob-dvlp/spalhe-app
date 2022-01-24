import 'package:spalhe/controllers/auth/auth.dart';
import 'package:spalhe/services/api.dart';

import 'package:get/get.dart';

class NotificationsController extends GetxController {
  var user = AuthController().auth['user'];
  List notifications = [];

  @override
  void onReady() async {
    super.onReady();
    await getAllNotifications();
    getNotificationsWS();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getTotal() {
    return notifications
        .where((el) => el['view'].toString() == '0')
        .length
        .toString();
  }

  void clearNotifications() async {
    var list = [];
    notifications.forEach((item) {
      item['view'] = '1';
      list.add(item);
    });
    notifications = list;
    update();
    await API.put('/notifications/update', {});
  }

  Future<void> getAllNotifications() async {
    try {
      var value = await API.get('/notifications');
      notifications = value.data;
      update();
    } catch (err) {
      print(err);
    }
  }

  Future<void> getNotificationsWS() async {
    // await socket.connect();
    // var sock = await socket.subscribe('notification:${user['id']}');
    // sock.on('message', (data) {
    //   notifications.insert(0, data);
    //   update();
    // });
  }
}
