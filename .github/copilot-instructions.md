# AI Coding Agent Instructions for Flutter Project

## Project Overview
This is a Flutter application project. When working on this codebase, follow these guidelines to be immediately productive.

## Development Environment Setup
- **Flutter SDK**: Use `flutter doctor` to verify installation and dependencies
- **Build Commands**: 
  - `flutter pub get` - Install dependencies
  - `flutter run` - Run in debug mode
  - `flutter build apk` or `flutter build ios` - Build for production
- **Testing**: `flutter test` for unit tests, `flutter integration_test` for integration tests

## Project Structure Patterns
When the project is initialized, expect this structure:
- `lib/` - Main application code
  - `main.dart` - Application entry point
  - `screens/` or `pages/` - UI screens/pages
  - `widgets/` - Reusable UI components
  - `models/` - Data models and entities
  - `services/` - API calls, business logic
  - `utils/` - Helper functions and utilities
- `test/` - Unit and widget tests
- `integration_test/` - Integration tests
- `pubspec.yaml` - Dependencies and project configuration

## Code Generation & Dependencies
- Always run `flutter pub get` after modifying `pubspec.yaml`
- For code generation (if using build_runner): `flutter packages pub run build_runner build`
- Hot reload with `r` in terminal, hot restart with `R`

## Flutter-Specific Conventions
- **State Management**: Check `pubspec.yaml` for state management solution (Provider, Riverpod, Bloc, etc.)
- **Navigation**: Use `Navigator.push`/`Navigator.pop` or named routes defined in `MaterialApp`
- **Theming**: Look for `ThemeData` configuration in `main.dart` or dedicated theme files
- **Responsive Design**: Use `MediaQuery.of(context)` for screen dimensions

## Testing Patterns
- Widget tests in `test/` directory mirroring `lib/` structure
- Use `testWidgets()` for widget testing
- Use `group()` to organize related tests
- Mock external dependencies using `mockito` or similar packages

## Platform-Specific Considerations
- **Android**: Configuration in `android/app/build.gradle` and `android/app/src/main/AndroidManifest.xml`
- **iOS**: Configuration in `ios/Runner/Info.plist` and Xcode project
- Use `Platform.isAndroid` or `Platform.isIOS` for platform-specific code

## Common Flutter Packages Integration
When adding features, consider these common patterns:
- HTTP requests: `http` or `dio` packages
- Local storage: `shared_preferences` or `hive`
- Navigation: `go_router` for advanced routing
- Images: `cached_network_image` for network images
- Forms: `flutter_form_builder` for complex forms

## Debugging & Performance
- Use `flutter logs` to view device logs
- `flutter inspector` for widget tree analysis
- Profile performance with `flutter run --profile`
- Use `debugPrint()` instead of `print()` for debugging output

## Key Files to Reference
- `pubspec.yaml` - Dependencies and project metadata
- `lib/main.dart` - App entry point and initial setup
- `analysis_options.yaml` - Linting rules (if present)