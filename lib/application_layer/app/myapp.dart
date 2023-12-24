// ignore_for_file: deprecated_member_use

import 'package:task_manger/application_layer/service/localizetion/translate.dart';
import 'package:task_manger/presentation_layer/components/nav_bar.dart';
import 'package:task_manger/presentation_layer/resources/routes_pages.dart';
import 'package:task_manger/presentation_layer/src/get_packge.dart';
import 'package:task_manger/presentation_layer/src/style_packge.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final TabAppController themeController = Get.put(TabAppController());
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        translations: MyTranslation(),
        locale: const Locale('en'),
        theme: themeController.isDarkMode.value ? darkTheme : lightTheme,
        // home: TestScreen(),
        getPages: getPage,
      ),
    );
  }
}

final ThemeData lightTheme = ThemeData(
  backgroundColor: Color(0xffFFFFFF),
  // backgroundColor:
  primarySwatch: Colors.blue,
  colorScheme: ColorScheme.light(
    background: Color(0xffFFFFFF),
    onPrimary: Color(0xFF7206FC),
    secondary: Color(0xff1F222A),
    surface: Color(0xFFF9F9F9),
  ),
  primaryColor: Color(0xFF7206FC),
  brightness: Brightness.light,
  iconTheme: IconThemeData(
    color: Color(0xff1F222A),
  ),
  appBarTheme: AppBarTheme(backgroundColor: Color(0xffFFFFFF)),
);

final ThemeData darkTheme = ThemeData(
  backgroundColor: Color(0xff1F222A),
  colorScheme: ColorScheme.dark(
    background: Color(0xff1F222A),
    onPrimary: Color(0xFF7206FC),
    secondary: Color(0xffFFFFFF),
    surface: Color(0xFF1F222A),
  ),
  primaryColor: Color(0xFF7206FC),
  primarySwatch: Colors.blue,
  brightness: Brightness.dark,
  iconTheme: IconThemeData(
    color: Color(0xffFFFFFF),
  ),
  appBarTheme: AppBarTheme(backgroundColor: Color(0xff1F222A)),
);
