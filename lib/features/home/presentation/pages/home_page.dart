import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiktihelper/features/home/presentation/providers/home_provider.dart';
import 'package:wiktihelper/shared/widgets/search_box.dart';
import 'package:wiktihelper/shared/widgets/wiktionary_result_card.dart';
import 'package:wiktihelper/shared/widgets/language_selector.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<HomeProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                const SizedBox(height: 24),
                const Text(
                  'Wiktionary Helper',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Search for word definitions',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),
                LanguageSelector(
                  selectedLanguage: provider.selectedLanguage,
                  onLanguageChanged: (language) {
                    provider.setLanguage(language);
                    if (provider.currentResult != null) {
                      provider.searchWord(provider.currentResult!.title);
                    }
                  },
                ),
                const SizedBox(height: 16),
                SearchBox(
                  onSearch: provider.searchWord,
                  isLoading: provider.isLoading,
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (provider.currentResult != null)
                          WiktionaryResultCard(
                            result: provider.currentResult!,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
} 