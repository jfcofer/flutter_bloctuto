import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_repository/theme_repository.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({required ThemeRepository themeRepository})
      : _themeRepository = themeRepository,
        super(const ThemeState()) {
    on<ThemeModeRequested>(_onThemeModeRequested);
    on<ToggleThemeMode>(_onToggleThemeMode);
  }

  final ThemeRepository _themeRepository;

  Future<void> _onThemeModeRequested(
    ThemeModeRequested event,
    Emitter<ThemeState> emit,
  ) async {
    emit(state.copyWith(status: ThemeStatus.loading));
    await Future<void>.delayed(const Duration(seconds: 5));
    await emit.forEach<ThemeMode>(
      _themeRepository.getThemeMode(),
      onData: (themeMode) => state.copyWith(
        status: ThemeStatus.success,
        themeMode: themeMode,
      ),
      onError: (error, stackTrace) =>
          state.copyWith(status: ThemeStatus.failure),
    );
  }

  Future<void> _onToggleThemeMode(
    ToggleThemeMode event,
    Emitter<ThemeState> emit,
  ) async {
    await _themeRepository.setThemeMode(event.themeMode);
  }
}
