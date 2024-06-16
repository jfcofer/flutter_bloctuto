import 'package:flutter_users_bloc_sqflite/app/app.dart';
import 'package:flutter_users_bloc_sqflite/bootstrap.dart';

void main() async {

  await bootstrap(
    builder: (
      themeRepository,
      usersRepository,
    ) {
      return App(
        themeRepository: themeRepository,
        usersRepository: usersRepository,
      );
    },
  );
}
