import 'package:flutter/material.dart';
import 'package:wiktihelper/shared/models/wiktionary_result.dart';
import 'package:wiktihelper/shared/services/wiktionary_service.dart';

class HomeProvider extends ChangeNotifier {
  final WiktionaryService _service;
  bool _isLoading = false;
  WiktionaryResult? _currentResult;
  String _selectedLanguage = 'en';

  HomeProvider(this._service);

  bool get isLoading => _isLoading;
  WiktionaryResult? get currentResult => _currentResult;
  String get selectedLanguage => _selectedLanguage;

  void setLanguage(String language) {
    _selectedLanguage = language;
    notifyListeners();
  }

  Future<void> searchWord(String word) async {
    if (word.isEmpty) {
      _currentResult = null;
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final result = await _service.searchWord(word, _selectedLanguage);
      _currentResult = result;
    } catch (e) {
      _currentResult = WiktionaryResult(
        title: word,
        extract: '',
        source: _selectedLanguage,
        error: 'Failed to fetch definition: $e',
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
} 