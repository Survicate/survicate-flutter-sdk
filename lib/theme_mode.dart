/// The theme mode for survey appearance.
enum ThemeMode {
  /// Enforces light theme.
  light,

  /// Enforces dark theme.
  dark,

  /// Automatically follows the system light/dark UI modes.
  auto,
}

extension ThemeModeExtension on ThemeMode {
  String get name {
    switch (this) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.auto:
        return 'auto';
    }
  }
}
