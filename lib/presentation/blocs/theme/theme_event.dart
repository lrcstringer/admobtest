part of 'theme_bloc.dart';

@freezed
abstract class ThemeEvent with _$ThemeEvent {
  const factory ThemeEvent.loadSavedTheme() = _LoadSavedTheme;
  const factory ThemeEvent.setThemeMode(ThemeMode mode) = _SetThemeMode;
}
