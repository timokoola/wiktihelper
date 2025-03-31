import 'package:flutter/material.dart';
import 'package:wiktihelper/core/config/app_config.dart';
import 'package:wiktihelper/core/theme/app_theme.dart';
import 'package:wiktihelper/shared/models/wiktionary_result.dart';
import 'package:wiktihelper/shared/widgets/search_box.dart';
import 'package:wiktihelper/shared/widgets/wiktionary_result_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WiktionaryResult _currentResult = WiktionaryResult(
    title: '',
    extract: '',
    source: '',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConfig.appName),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            SearchBox(
              onResult: (result) {
                setState(() {
                  _currentResult = result;
                });
              },
            ),
            WiktionaryResultCard(result: _currentResult),
          ],
        ),
      ),
    );
  }
}
