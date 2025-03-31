import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiktihelper/core/config/app_config.dart';
import 'package:wiktihelper/core/theme/app_theme.dart';
import 'package:wiktihelper/features/home/presentation/pages/home_page.dart';
import 'package:wiktihelper/features/home/presentation/providers/home_provider.dart';
import 'package:wiktihelper/shared/services/wiktionary_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(WiktionaryService()),
      child: MaterialApp(
        title: AppConfig.appName,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const HomePage(),
      ),
    );
  }
}
