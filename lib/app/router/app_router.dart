import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_users_bloc_sqflite/app/bloc/theme/theme_bloc.dart';
import 'package:flutter_users_bloc_sqflite/modules/edit_user/edit_user.dart';
import 'package:flutter_users_bloc_sqflite/modules/home/home.dart';
import 'package:flutter_users_bloc_sqflite/modules/loading/loading.dart';
import 'package:flutter_users_bloc_sqflite/modules/settings/settings.dart';
import 'package:flutter_users_bloc_sqflite/modules/users_overview/users_overview.dart';
import 'package:go_router/go_router.dart';
import 'package:users_repository/users_repository.dart';

part 'app_router.g.dart';

abstract class AppRouter {
  static final router = GoRouter(
    routes: $appRoutes,
    debugLogDiagnostics: true,
    redirect: (BuildContext context, GoRouterState state) async {
      final themeStatus = context.read<ThemeBloc>().state.status;
      final isLoading = state.matchedLocation == const LoadingRoute().location;
      if (themeStatus == ThemeStatus.loading) {
        return const LoadingRoute().location;
      } else if (isLoading) {
        return const HomeRoute().location;
      }
      return null;
    },
  );
}

@TypedGoRoute<HomeRoute>(
  path: '/',
  name: 'home',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<UsersOverviewRoute>(
      path: 'users',
      name: 'usersOverview',
      routes: <TypedGoRoute<GoRouteData>>[
        TypedGoRoute<EditUsersRoute>(
          path: 'edit',
          name: 'editUser',
        ),
      ],
    ),
  ],
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}

@TypedGoRoute<LoadingRoute>(
  path: '/loading',
  name: 'loading',
)
class LoadingRoute extends GoRouteData {
  const LoadingRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoadingPage();
  }
}

@TypedGoRoute<SettingsRoute>(
  path: '/settings',
  name: 'settings',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<ThemeSettingsRoute>(
      path: 'theme',
      name: 'themeSettings',
    ),
  ],
)
class SettingsRoute extends GoRouteData {
  const SettingsRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsPage();
  }
}

class ThemeSettingsRoute extends GoRouteData {
  const ThemeSettingsRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ThemeSettingsPage();
  }
}

class UsersOverviewRoute extends GoRouteData {
  const UsersOverviewRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UsersOverviewPage();
  }
}

class EditUsersRoute extends GoRouteData {
  EditUsersRoute({this.$extra});
  final User? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EditUserPage(
      initialUser: $extra,
    );
  }
}
