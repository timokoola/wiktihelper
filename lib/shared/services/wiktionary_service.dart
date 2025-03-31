import 'dart:convert';
import 'package:http/http.dart' as http;

class WiktionaryService {
  static const String _baseUrl = 'https://en.wiktionary.org/w/api.php';
  static const String _finnishBaseUrl = 'https://fi.wiktionary.org/w/api.php';

  Future<Map<String, dynamic>> searchWord(String word) async {
    // Try English Wiktionary first
    final englishResult = await _searchInWiktionary(word, _baseUrl);
    if (englishResult != null) {
      return englishResult;
    }

    // If not found in English, try Finnish Wiktionary
    return await _searchInWiktionary(word, _finnishBaseUrl) ?? 
           {'error': 'Word not found in either English or Finnish Wiktionary'};
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
    
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final pages = data['query']['pages'];
        final firstPage = pages[pages.keys.first];
        
        if (firstPage['extract'] != null) {
          return {
            'title': firstPage['title'],
            'extract': firstPage['extract'],
            'source': baseUrl.contains('fi.wiktionary.org') ? 'fi' : 'en',
          };
        }
      }
    } catch (e) {
      print('Error fetching from Wiktionary: $e');
    }
    return null;
  }
} 