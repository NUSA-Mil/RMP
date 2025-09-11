import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  static const _isDarkThemeKey = 'isDarkTheme';
  static const _userNameKey = 'userName';
  static const _showHintsKey = 'showHints';

  SettingsBloc() : super(SettingsState()) {
    on<LoadSettings>(_onLoadSettings);
    on<ToggleTheme>(_onToggleTheme);
    on<UpdateName>(_onUpdateName);
    on<ToggleHints>(_onToggleHints);
  }

  Future<void> _onLoadSettings(LoadSettings event, Emitter<SettingsState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkTheme = prefs.getBool(_isDarkThemeKey) ?? false;
    final userName = prefs.getString(_userNameKey) ?? 'Гость';
    final showHints = prefs.getBool(_showHintsKey) ?? true;
    emit(SettingsState(
      isDarkTheme: isDarkTheme,
      userName: userName,
      showHints: showHints,
    ));
  }

  Future<void> _onToggleTheme(ToggleTheme event, Emitter<SettingsState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final newTheme = !state.isDarkTheme;
    await prefs.setBool(_isDarkThemeKey, newTheme);
    emit(state.copyWith(isDarkTheme: newTheme));
  }

  Future<void> _onUpdateName(UpdateName event, Emitter<SettingsState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userNameKey, event.name);
    emit(state.copyWith(userName: event.name));
  }

  Future<void> _onToggleHints(ToggleHints event, Emitter<SettingsState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final newHints = !state.showHints;
    await prefs.setBool(_showHintsKey, newHints);
    emit(state.copyWith(showHints: newHints));
  }
}