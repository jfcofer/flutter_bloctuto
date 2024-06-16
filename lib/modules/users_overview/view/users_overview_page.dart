import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_users_bloc_sqflite/app/router/app_router.dart';
import 'package:flutter_users_bloc_sqflite/modules/users_overview/bloc/users_overview_bloc.dart';
import 'package:flutter_users_bloc_sqflite/modules/users_overview/view/widgets/widgets.dart';
import 'package:users_repository/users_repository.dart';

class UsersOverviewPage extends StatelessWidget {
  const UsersOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersOverviewBloc(
        usersRepository: context.read<UsersRepository>(),
      )..add(const UsersOverviewSubscriptionRequested()),
      child: const UsersOverviewView(),
    );
  }
}

class UsersOverviewView extends StatelessWidget {
  const UsersOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: usersOverviewAppBar(),
      body: const _UsersOverviewBody(),
      floatingActionButton: const AddUserFloatingActionButton(),
    );
  }
}

class _UsersOverviewBody extends StatelessWidget {
  const _UsersOverviewBody();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UsersOverviewBloc, UsersOverviewState>(
          listenWhen: (previous, current) {
            return previous.status != current.status;
          },
          listener: (context, state) {
            if (state.status == UsersOverviewStatus.failure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    content: Text('Error'),
                  ),
                );
            }
          },
        ),
        BlocListener<UsersOverviewBloc, UsersOverviewState>(
          listenWhen: (previous, current) {
            return previous.lastDeletedUser != current.lastDeletedUser &&
                current.lastDeletedUser != null;
          },
          listener: (context, state) {
            final deletedUser = state.lastDeletedUser;
            final messenger = ScaffoldMessenger.of(context);
            messenger
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text('Deleted user: ${deletedUser?.name}'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      messenger.hideCurrentSnackBar();
                      context
                          .read<UsersOverviewBloc>()
                          .add(const UsersOverviewUndoDeletionRequested());
                    },
                  ),
                ),
              );
          },
        ),
      ],
      child: BlocBuilder<UsersOverviewBloc, UsersOverviewState>(
        builder: (context, state) {
          if (state.users.isEmpty) {
            if (state.status == UsersOverviewStatus.loading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state.status != UsersOverviewStatus.success) {
              return const SizedBox();
            }
          }
          return Scrollbar(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final user = state.users[index];
                return UserTile(
                  user: user,
                  onTap: () => EditUsersRoute($extra: user).go(context),
                  onDismissed: (_) {
                    return context
                        .read<UsersOverviewBloc>()
                        .add(UsersOverviewUserDeleted(user: user));
                  },
                );
              },
              itemCount: state.users.length,
            ),
          );
        },
      ),
    );
  }
}
