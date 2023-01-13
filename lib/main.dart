import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo/db/db_helper.dart';
import 'package:todo/ui/pages/home_page.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/services/theme_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.intDb();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Themes.light,
      darkTheme: Themes.darke,
      themeMode: ThemeServices().Theme,
      home: HomePage(),
    );
  }
}
