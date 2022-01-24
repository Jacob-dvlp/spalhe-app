import 'dart:math';

import 'package:spalhe/controllers/auth/auth.dart';
import 'package:spalhe/pages/profile/profile.dart';
import 'package:spalhe/pages/user/user.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simple_moment/simple_moment.dart';

class Utils {
  static final user = Get.put(AuthController()).auth['user'];

  static date(date) {
    Moment.setLocaleGlobally(LocalePtBr());
    DateFormat df = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime dateTime = df.parse(date);
    var moment = Moment.now();
    return moment.from(dateTime);
  }

  static routeUser(u) {
    if (u['id'] == user['id']) {
      Get.to(ProfilePage());
    } else {
      Get.to(UserPage(user: u));
    }
  }

  final _chars = 'abcdefghijklmnopqrstywxz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(
        Iterable.generate(
          length,
          (_) => _chars.codeUnitAt(
            _rnd.nextInt(_chars.length),
          ),
        ),
      );
}
