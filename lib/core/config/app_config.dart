class AppConfig {
  static const String appName = 'WiktiHelper';
  static const String appVersion = '1.0.0';
  
  // API Configuration
  static const String baseUrl = 'https://api.example.com'; // Replace with your API URL
  static const int apiTimeout = 30000; // 30 seconds
  
  // Feature Flags
  static const bool enableAnalytics = true;
  static const bool enableCrashlytics = true;
  
  // Cache Configuration
  static const int cacheMaxAge = 3600; // 1 hour in seconds
  static const int maxCacheSize = 50 * 1024 * 1024; // 50 MB
} 