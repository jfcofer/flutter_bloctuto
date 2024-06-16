import 'package:flutter/material.dart';
import 'package:flutter_users_bloc_sqflite/app/router/app_router.dart';

class HomeBottomAppBar extends StatelessWidget {
  const HomeBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            isSelected: true,
            onPressed: () => const HomeRoute().go(context),
            icon: const Icon(
              Icons.home_outlined,
            ),
          ),
          IconButton(
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
