import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:spalhe/pages/loader/loader.dart';
import 'package:spalhe/providers/auth.dart';
import 'package:spalhe/providers/tabs.dart';
import 'package:spalhe/theme/dark.dart';
import 'package:spalhe/theme/light.dart';
import 'package:spalhe/utils/routes.dart';
import 'package:stories_editor/stories_editor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...StoriesEditorProvider().providers,
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TabsProvider()),
      ],
      child: MaterialApp(
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
