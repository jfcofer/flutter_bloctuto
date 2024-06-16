import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_users_bloc_sqflite/app/router/app_router.dart';
import 'package:flutter_users_bloc_sqflite/modules/edit_user/bloc/edit_user_bloc.dart';

class EditUserForm extends StatelessWidget {
  const EditUserForm({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<EditUserBloc, EditUserState>(
          listenWhen: (previous, current) {
            return previous.status != current.status &&
                current.status == EditUserStatus.success;
          },
          listener: (context, state) => const UsersOverviewRoute().go(context),
        ),
        BlocListener<EditUserBloc, EditUserState>(
          listenWhen: (previous, current) {
            return previous.status != current.status &&
                current.status == EditUserStatus.failure;
          },
          listener: (context, state) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: BlocBuilder<EditUserBloc, EditUserState>(
                    builder: (context, state) {
                      if (!state.isNewUser) {
                        return const Text('Editing Failed');
                      }
                      return const Text('Saving Failed');
                    },
                  ),
                ),
              );
          },
        ),
      ],
      child: const _FormInputs(),
    );
  }
}

class _FormInputs extends StatelessWidget {
  const _FormInputs();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            _NameInput(),
            SizedBox(
              height: 10,
            ),
            _EmailInput(),
          ],
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditUserBloc, EditUserState>(
      buildWhen: (previous, current) {
        return previous.name != current.name;
      },
      builder: (context, state) {
        return TextFormField(
          key: const Key('EditForm_NameField'),
          initialValue: state.name,
          decoration: InputDecoration(
            enabled: !state.status.isLoadingOrSucces,
            hintText: state.initialUser?.name ?? '',
            labelText: 'Name',
          ),
          onChanged: (name) => context.read<EditUserBloc>().add(
                EditUserNameChanged(name: name),
              ),
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditUserBloc, EditUserState>(
      buildWhen: (previous, current) {
        return previous.email != current.email;
      },
      builder: (context, state) {
        return TextFormField(
          key: const Key('EditForm_EmailField'),
          initialValue: state.email,
          decoration: InputDecoration(
            enabled: !state.status.isLoadingOrSucces,
            hintText: state.initialUser?.email ?? '',
            labelText: 'Email',
          ),
          onChanged: (email) => context.read<EditUserBloc>().add(
                EditUserEmailChanged(email: email),
              ),
        );
      },
    );
  }
}
