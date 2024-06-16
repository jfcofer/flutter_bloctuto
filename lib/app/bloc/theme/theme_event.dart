part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();
  @override
  List<Object?> get props => [];
}

class ThemeModeRequested extends ThemeEvent {
  const ThemeModeRequested();
}

class ToggleThemeMode extends ThemeEvent {
  const ToggleThemeMode({required this.themeMode});
  final ThemeMode themeMode;
  @override
  List<Object?> get props => [themeMode];
}
