import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_users_bloc_sqflite/modules/edit_user/bloc/edit_user_bloc.dart';
import 'package:flutter_users_bloc_sqflite/modules/edit_user/view/widgets/widgets.dart';
import 'package:users_repository/users_repository.dart';

class EditUserPage extends StatelessWidget {
  const EditUserPage({required User? initialUser, super.key})
      : _initialUser = initialUser;

  final User? _initialUser;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditUserBloc(
        initialUser: _initialUser,
        usersRepository: context.read<UsersRepository>(),
      ),
      child:  const _EditUserPageView(),
      
    );
  }
}

class _EditUserPageView extends StatelessWidget {
  const _EditUserPageView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: editUserAppBar(),
      body: const EditUserForm(),
      floatingActionButton: const SaveUserButton(),
    );
  }
}
