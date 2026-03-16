import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';
part 'theme_bloc.freezed.dart';

@injectable
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SharedPreferences _prefs;
  static const _key = 'theme_mode';

  ThemeBloc(this._prefs) : super(const ThemeState()) {
    on<_LoadSavedTheme>(_onLoadSavedTheme);
    on<_SetThemeMode>(_onSetThemeMode);
  }

  void _onLoadSavedTheme(
    _LoadSavedTheme event,
    Emitter<ThemeState> emit,
  ) {
    final index = _prefs.getInt(_key) ?? 2; // default dark
    final mode = (index >= 0 && index < ThemeMode.values.length)
        ? ThemeMode.values[index]
        : ThemeMode.dark;
    emit(state.copyWith(themeMode: mode));
  }

  Future<void> _onSetThemeMode(
    _SetThemeMode event,
    Emitter<ThemeState> emit,
  ) async {
    emit(state.copyWith(themeMode: event.mode));
    await _prefs.setInt(_key, event.mode.index);
  }
}
