class AppConstants {
  // App information
  static const String appName = 'Woofy';
  static const String appVersion = '1.0.0';
  
  // Route names
  static const String homeRoute = '/';
  static const String searchRoute = '/search';
  static const String profileRoute = '/profile';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  
  // Search configurations
  static const int searchResultsLimit = 20;
  static const int searchDebounceMs = 500;
  
  // Image configurations
  static const int maxImageSizeMB = 5;
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png', 'webp'];
  
  // Pagination
  static const int defaultPageSize = 10;
  static const int maxPageSize = 50;
}