import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_api/theme_api.dart';

/// {@template local_storage_theme_api}
/// Implementacion para el almacenamiento local del tema de la aplicacion
/// {@endtemplate}
class LocalStorageThemeApi implements ThemeApi {
  /// {@macro local_storage_theme_api}
  LocalStorageThemeApi({required SharedPreferences plugin}) : _plugin = plugin {
    _init();
  }

  void _init() {
    final themeModeString = _getValue(themeModeCollectionKey);
    if (themeModeString != null) {
      final themeMode = _themeModeFromString(themeModeString);
      _themeStreamController.add(themeMode);
    } else {
      _themeStreamController.add(ThemeMode.system);
    }
  }

  final _themeStreamController =
      BehaviorSubject<ThemeMode>.seeded(ThemeMode.system);

  ///Key for SharedPreferences saving
  ///Shouldn't be visible on production
  @visibleForTesting
  static const themeModeCollectionKey = '__theme_mode_collection_key__';

  final SharedPreferences _plugin;

  String? _getValue(String key) => _plugin.getString(key);

  Future<void> _setValue(String key, String value) {
    return _plugin.setString(key, value);
  }

  ThemeMode _themeModeFromString(String themeModeString) {
    switch (themeModeString) {
      case _ThemeModeValues.dark:
        return ThemeMode.dark;
      case _ThemeModeValues.light:
        return ThemeMode.light;
      case _ThemeModeValues.system:
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }

  String _themeModeToString(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.dark:
        return _ThemeModeValues.dark;
      case ThemeMode.light:
        return _ThemeModeValues.light;
      case ThemeMode.system:
        return _ThemeModeValues.system;
    }
  }

  @override
  Stream<ThemeMode> getThemeMode() =>
      _themeStreamController.asBroadcastStream();

  @override
  Future<void> setThemeMode(ThemeMode themeMode) {
    _themeStreamController.add(themeMode);
    return _setValue(themeModeCollectionKey, _themeModeToString(themeMode));
  }
}

sealed class _ThemeModeValues {
  static const system = 'system';
  static const light = 'light';
  static const dark = 'dark';
}
