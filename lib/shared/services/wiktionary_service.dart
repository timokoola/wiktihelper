import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wiktihelper/shared/models/wiktionary_result.dart';

class WiktionaryService {
  static const String _baseUrl = 'https://en.wiktionary.org/w/api.php';
  static const String _finnishBaseUrl = 'https://fi.wiktionary.org/w/api.php';
  static const String _spanishBaseUrl = 'https://es.wiktionary.org/w/api.php';
  static const String _swedishBaseUrl = 'https://sv.wiktionary.org/w/api.php';

  static const Map<String, String> _languageUrls = {
    'en': _baseUrl,
    'fi': _finnishBaseUrl,
    'es': _spanishBaseUrl,
    'sv': _swedishBaseUrl,
  };

  static const Map<String, String> _languageNames = {
    'en': 'English',
    'fi': 'Finnish',
    'es': 'Spanish',
    'sv': 'Swedish',
  };

  Future<WiktionaryResult> searchWord(String word, String language) async {
    final baseUrl = _languageUrls[language] ?? _baseUrl;
    
    try {
      final result = await _searchInWiktionary(word, baseUrl);
      if (result != null) {
        return WiktionaryResult(
          title: result['title'],
          extract: result['extract'],
          source: language,
        );
      }
      
      return WiktionaryResult(
        title: word,
        extract: '',
        source: language,
        error: 'Word not found in ${_languageNames[language] ?? 'English'} Wiktionary',
      );
    } catch (e) {
      return WiktionaryResult(
        title: word,
        extract: '',
        source: language,
        error: 'Error fetching from Wiktionary: $e',
      );
    }
  }

  Future<Map<String, dynamic>?> _searchInWiktionary(String word, String baseUrl) async {
    final queryParams = {
      'action': 'query',
      'format': 'json',
      'prop': 'extracts',
      'explaintext': 'true',
      'titles': word,
      'origin': '*',
    };

    final uri = Uri.parse(baseUrl).replace(queryParameters: queryParams);
    
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final pages = data['query']['pages'];
      final firstPage = pages[pages.keys.first];
      
      if (firstPage['extract'] != null) {
        return {
          'title': firstPage['title'],
          'extract': firstPage['extract'],
        };
      }
    }
    return null;
  }
} 