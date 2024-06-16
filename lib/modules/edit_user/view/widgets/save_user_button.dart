import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_users_bloc_sqflite/modules/edit_user/bloc/edit_user_bloc.dart';

class SaveUserButton extends StatelessWidget {
  const SaveUserButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditUserBloc, EditUserState>(
      builder: (context, state) {
        return FloatingActionButton(
          tooltip: 'Save User',
          onPressed: state.status.isLoadingOrSucces
              ? null
              : () => context.read<EditUserBloc>().add(
                    const EditUserSubmitted(),
                  ),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: state.status.isLoadingOrSucces
              ? const CircularProgressIndicator()
              : const Icon(Icons.check_rounded),
        );
      },
    );
  }
}
