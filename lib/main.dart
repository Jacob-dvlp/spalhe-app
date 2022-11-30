import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:spalhe/constants/translator.dart';
import 'package:spalhe/controllers/settings.controller.dart';
import 'package:spalhe/firebase_options.dart';
import 'package:spalhe/pages/loader/loader.dart';
import 'package:spalhe/theme/dark.dart';
import 'package:spalhe/theme/light.dart';
import 'package:spalhe/utils/routes.dart';

void main() async {
  await GetStorage.init();
  await WidgetsFlutterBinding.ensureInitialized();
  final theme = GetStorage().read('theme') ?? 'dark';
  SettingsController().changeTheme(theme);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await OneSignal.shared.setAppId("e888ff4c-1b79-4b66-82d1-5a73c713f22d");
  OneSignal.shared.promptUserForPushNotificationPermission();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: GetMaterialApp(
        translations: TransalationsMessages(),
        locale: Get.deviceLocale,
        fallbackLocale: Locale('en', 'US'),
        defaultGlobalState: true,
        navigatorKey: customRoute,
        debugShowCheckedModeBanner: false,
        title: 'Spalhe',
        themeMode: ThemeMode.system,
        theme: themeLight(context),
        darkTheme: themeDark(context),
        home: LoaderPage(),
      ),
    );
  }
}
