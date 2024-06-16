import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_users_bloc_sqflite/app/bloc/theme/theme_bloc.dart';
import 'package:flutter_users_bloc_sqflite/l10n/l10n.dart';

class ThemeSettingsPage extends StatelessWidget {
  const ThemeSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.themeSettingsPageTitle),
      ),
      body: const _ThemeSettingsBody(),
    );
  }
}

class _ThemeSettingsBody extends StatelessWidget {
  const _ThemeSettingsBody();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        ThemeOption(
          themeValue: ThemeMode.system,
        ),
        ThemeOption(
          themeValue: ThemeMode.dark,
        ),
        ThemeOption(
          themeValue: ThemeMode.light,
        ),
      ],
    );
  }
}

class ThemeOption extends StatelessWidget {
  const ThemeOption({
    required this.themeValue,
    super.key,
  });

  final ThemeMode themeValue;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = switch (themeValue) {
      ThemeMode.system => l10n.themeMode('system'),
      ThemeMode.dark => l10n.themeMode('dark'),
      ThemeMode.light => l10n.themeMode('light'),
    };

    final themeIcon = Icon(
      switch (themeValue) {
        ThemeMode.system => Icons.settings_cell_outlined,
        ThemeMode.dark => Icons.dark_mode_outlined,
        ThemeMode.light => Icons.light_mode_outlined,
      },
    );

    return RadioListTile.adaptive(
      value: themeValue,
      groupValue: context.select((ThemeBloc bloc) => bloc.state.themeMode),
      onChanged: (value) =>
          context.read<ThemeBloc>().add(ToggleThemeMode(themeMode: themeValue)),
      title: Text(textTheme),
      secondary: themeIcon,
    );
  }
}
