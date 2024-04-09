import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:menu_log/firebase_options.dart';

import 'helper/theme_helper.dart';
import 'multi_bloc_provider.dart';
import 'utils/string_constant.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MultiBlocProviderClass(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 755),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          title: 'Menu Log',
          theme: ThemeHelper()
              .generateAppTheme(context, AppThemeState.app_theme_light),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
