import 'package:flutter/material.dart';
import 'package:flutter_users_bloc_sqflite/app/router/app_router.dart';
import 'package:flutter_users_bloc_sqflite/l10n/l10n.dart';

class HomeMenuTile extends StatelessWidget {
  const HomeMenuTile({
    required this.iconData,
    required this.title,
    required this.onTap,
    super.key,
  });

  final void Function()? onTap;
  final IconData iconData;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 150,
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 50,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeMenuUsersTile extends StatelessWidget {
  const HomeMenuUsersTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return HomeMenuTile(
      onTap: () => const UsersOverviewRoute().go(context),
      iconData: Icons.person,
      title: l10n.homeMenuUsersTile,
    );
  }
}
