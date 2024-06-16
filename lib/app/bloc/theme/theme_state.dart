part of 'theme_bloc.dart';

enum ThemeStatus {
  initial,
  loading,
  success,
  failure,
}

class ThemeState extends Equatable {
  const ThemeState({
    this.status = ThemeStatus.initial,
    this.themeMode = ThemeMode.system,
  });
  final ThemeStatus status;
  final ThemeMode themeMode;

  ThemeState copyWith({ThemeStatus? status, ThemeMode? themeMode}) {
    return ThemeState(
      status: status ?? this.status,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object?> get props => [status, themeMode];
}
