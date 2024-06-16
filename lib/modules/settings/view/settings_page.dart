import 'package:flutter/material.dart';
import 'package:flutter_users_bloc_sqflite/app/router/app_router.dart';
import 'package:flutter_users_bloc_sqflite/l10n/l10n.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  static String get routeName => 'settings';

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsPageTitle),
      ),
      body: const _SettingsPageBody(),
      bottomNavigationBar: const _SettingsBottomAppBar(),
    );
  }
}

class _SettingsPageBody extends StatelessWidget {
  const _SettingsPageBody();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ListView(
      children: [
        ListTile(
          title: Text(l10n.settingsMenuThemeTileDescription),
          subtitle: Text(l10n.settingsMenuThemeTileDescription),
          trailing: Icon(Icons.adaptive.arrow_forward),
          onTap: () => const ThemeSettingsRoute().go(context),
        ),
      ],
    );
  }
}

class _SettingsBottomAppBar extends StatelessWidget {
  const _SettingsBottomAppBar();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () => const HomeRoute().go(context),
            icon: const Icon(
              Icons.home_outlined,
            ),
          ),
          IconButton(
            isSelected: true,
            onPressed: () => const SettingsRoute().go(context),
            icon: const Icon(
              Icons.settings_outlined,
            ),
          ),
        ],
      ),
    );
  }
}
