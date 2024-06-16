import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_users_bloc_sqflite/modules/edit_user/bloc/edit_user_bloc.dart';

AppBar editUserAppBar() {
  return AppBar(
    title: BlocBuilder<EditUserBloc, EditUserState>(
      builder: (context, state) {
        if (!state.isNewUser) {
          return Text('Edit user: ${state.name}');
        }
        return const Text('Add user');
      },
    ),
  );
}
