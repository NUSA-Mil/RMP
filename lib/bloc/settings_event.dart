part of 'settings_bloc.dart';

abstract class SettingsEvent {}

class LoadSettings extends SettingsEvent {}

class ToggleTheme extends SettingsEvent {}

class UpdateName extends SettingsEvent {
  final String name;
  UpdateName(this.name);
}

class ToggleHints extends SettingsEvent {}