import 'package:flutter/material.dart';
import 'package:flutter_users_bloc_sqflite/l10n/l10n.dart';

AppBar homeAppBar(BuildContext context) {
  final l10n = context.l10n;
  return AppBar(
    title: Text(l10n.homePageTitle),
  );
}
