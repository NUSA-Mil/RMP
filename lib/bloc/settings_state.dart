part of 'settings_bloc.dart';

class SettingsState {
  final bool isDarkTheme;
  final String userName;
  final bool showHints;

  SettingsState({
    this.isDarkTheme = false,
    this.userName = '',
    this.showHints = true,
  });

  SettingsState copyWith({
    bool? isDarkTheme,
    String? userName,
    bool? showHints,
  }) {
    return SettingsState(
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      userName: userName ?? this.userName,
      showHints: showHints ?? this.showHints,
    );
  }
}