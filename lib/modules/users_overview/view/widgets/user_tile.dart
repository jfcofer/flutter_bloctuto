import 'package:flutter/material.dart';
import 'package:users_repository/users_repository.dart';

class UserTile extends StatelessWidget {
  const UserTile({required this.user, super.key, this.onTap, this.onDismissed});

  final User user;
  final VoidCallback? onTap;
  final DismissDirectionCallback? onDismissed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dismissible(
      key: Key('userTile_Dismisible_${user.id}'),
      onDismissed: onDismissed,
      background: Container(
        alignment: Alignment.centerRight,
        color: theme.colorScheme.error,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: const Icon(Icons.delete),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
          user.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          user.email,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: onTap == null ? null : const Icon(Icons.chevron_right),
      ),
    );
  }
}
