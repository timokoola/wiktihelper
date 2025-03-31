import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wiktihelper/shared/models/wiktionary_result.dart';

class ShareService {
  static Future<void> shareWiktionaryResult(WiktionaryResult result) async {
    final url = _getWiktionaryUrl(result);
    final text = 'Check out the definition of "${result.title}" on Wiktionary:\n$url';
    
    try {
      await Share.share(text);
      HapticFeedback.mediumImpact();
    } catch (e) {
      debugPrint('Error sharing: $e');
    }
  }

  static String _getWiktionaryUrl(WiktionaryResult result) {
    final baseUrl = result.source == 'en' 
        ? 'https://en.wiktionary.org/wiki'
        : 'https://fi.wiktionary.org/wiki';
    
    final encodedWord = Uri.encodeComponent(result.title);
    return '$baseUrl/$encodedWord';
  }
} 