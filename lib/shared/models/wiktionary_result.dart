class WiktionaryResult {
  final String title;
  final String extract;
  final String source;
  final String? error;

  WiktionaryResult({
    required this.title,
    required this.extract,
    required this.source,
    this.error,
  });

  factory WiktionaryResult.fromJson(Map<String, dynamic> json) {
    return WiktionaryResult(
      title: json['title'] ?? '',
      extract: json['extract'] ?? '',
      source: json['source'] ?? '',
      error: json['error'],
    );
  }

  bool get hasError => error != null;
} 