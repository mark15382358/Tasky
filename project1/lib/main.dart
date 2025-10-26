import 'package:flutter/material.dart';
import 'package:project1/core/services/preferences_manager.dart';
import 'package:project1/core/theme/dark_theme.dart';
import 'package:project1/core/theme/light_theme.dart';
import 'package:project1/core/theme/theme_controller.dart';
import 'package:project1/features/navigation/main_screen.dart';
import 'package:project1/features/welcome/welcomescreen.dart';

ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.dark);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesManager().init(); // مهم جدًا
  ThemeController().init();
  String? username = PreferencesManager().getString("username");
  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.username});
  final String? username;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeNotifier,
      builder: (context, ThemeMode value, Widget? child) {
        return MaterialApp(
          title: "Tasky",
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: value,
          home: username == null ? Welcomescreen() : MainScreen(),
        );
      },
    );
  }
}
