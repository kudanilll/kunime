import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:get/get.dart';
=======
>>>>>>> 0a9065c99c02dc8b063f4a742cc31243c113bc56
import 'package:kunime/routes.dart';
import 'package:kunime/utils/theme_data.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return GetMaterialApp(
=======
    return MaterialApp(
>>>>>>> 0a9065c99c02dc8b063f4a742cc31243c113bc56
      title: 'Kunime',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      // themeMode: ThemeMode.light,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        scrollbars: true,
      ),
      initialRoute: Routes.splash,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
