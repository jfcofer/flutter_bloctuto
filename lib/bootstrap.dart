import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:database_users_api/database_users_api.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_users_bloc_sqflite/app/app.dart';
import 'package:local_storage_theme_api/local_storage_theme_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:theme_repository/theme_repository.dart';
import 'package:users_repository/users_repository.dart';


typedef AppBuilder = FutureOr<Widget> Function(
  ThemeRepository themeRepository,
  UsersRepository usersRepository,
);

Future<void> bootstrap({
  required AppBuilder builder,
}) async {
  Bloc.observer = AppBlocObserver();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      final themeApi =
          LocalStorageThemeApi(plugin: await SharedPreferences.getInstance());

      final usersApi = DatabaseUsersApi();

      final themeRepository = ThemeRepository(themeApi: themeApi);

      final usersRepository = UsersRepository(usersApi: usersApi);
      runApp(
        await builder(
          themeRepository,
          usersRepository,
        ),
      );
    },
    (error, stack) => log(error.toString(), stackTrace: stack),
  );
}
