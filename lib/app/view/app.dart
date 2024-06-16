import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_users_bloc_sqflite/app/bloc/theme/theme_bloc.dart';
import 'package:flutter_users_bloc_sqflite/app/router/app_router.dart';
import 'package:flutter_users_bloc_sqflite/l10n/l10n.dart';
import 'package:flutter_users_bloc_sqflite/theme/theme.dart';
import 'package:theme_repository/theme_repository.dart';
import 'package:users_repository/users_repository.dart';

class App extends StatelessWidget {
  const App({
    required this.themeRepository,
    required this.usersRepository,
    super.key,
  });

  final UsersRepository usersRepository;
  final ThemeRepository themeRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: usersRepository,
        ),
        RepositoryProvider.value(
          value: themeRepository,
        ),
      ],
      child: BlocProvider(
        create: (context) => ThemeBloc(themeRepository: themeRepository)
          ..add(const ThemeModeRequested()),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ThemeBloc, ThemeState>(
      listenWhen: (previous, current) {
        return previous.status != current.status &&
            current.status != ThemeStatus.loading;
      },
      listener: (context, state) {
        AppRouter.router.refresh();
      },
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: LighTheme.theme,
        darkTheme: DarkTheme.theme,
        themeMode: context.select((ThemeBloc bloc) => bloc.state.themeMode),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerDelegate: AppRouter.router.routerDelegate,
        routeInformationParser: AppRouter.router.routeInformationParser,
        routeInformationProvider: AppRouter.router.routeInformationProvider,
      ),
    );
  }
}
