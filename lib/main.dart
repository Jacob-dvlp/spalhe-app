import 'package:spalhe/pages/auth/login.dart';
import 'package:spalhe/pages/home/home.dart';
import 'package:spalhe/pages/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      enableLog: false,
      navigatorKey: Get.key,
      debugShowCheckedModeBanner: false,
      title: 'Spalhe',
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => LandingPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
