import 'package:flutter/material.dart';
import 'package:flutter_users_bloc_sqflite/app/router/app_router.dart';

class AddUserFloatingActionButton extends StatelessWidget {
  const AddUserFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => EditUsersRoute().go(context),
      child: const Icon(Icons.add),
    );
  }
}
