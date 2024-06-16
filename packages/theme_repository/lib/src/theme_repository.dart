import 'package:flutter/material.dart';
import 'package:theme_api/theme_api.dart';

/// {@template theme_repository}
/// Repositorio para manejar el tema de la aplicacion
/// {@endtemplate}
class ThemeRepository {
  /// {@macro theme_repository}
  const ThemeRepository({
    required ThemeApi themeApi,
  }) : _themeApi = themeApi;

  final ThemeApi _themeApi;

  /// Returns the [ThemeMode] configured for the app
  Stream<ThemeMode> getThemeMode() => _themeApi.getThemeMode();

  /// Setter for the ThemeMode
  Future<void> setThemeMode(ThemeMode themeMode) =>
      _themeApi.setThemeMode(themeMode);
}
