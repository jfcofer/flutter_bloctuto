import 'package:flutter/material.dart';

/// {@template theme_api}
/// Interfaz para el API del tema de la aplicacion
/// {@endtemplate}
abstract class ThemeApi {
  /// {@macro theme_api}
  const ThemeApi();

  /// Returns the [ThemeMode] configured for the app
  Stream<ThemeMode> getThemeMode();

  /// Setter for the ThemeMode
  Future<void> setThemeMode(ThemeMode themeMode);
}
