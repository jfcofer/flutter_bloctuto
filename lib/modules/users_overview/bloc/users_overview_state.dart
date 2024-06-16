part of 'users_overview_bloc.dart';

enum UsersOverviewStatus { initial, loading, success, failure }

final class UsersOverviewState extends Equatable {
  const UsersOverviewState({
    this.status = UsersOverviewStatus.initial,
    this.users = const [],
    this.lastDeletedUser,
  });

  final UsersOverviewStatus status;
  final List<User> users;
  final User? lastDeletedUser;

  UsersOverviewState copyWith({
    UsersOverviewStatus? status,
    List<User>? users,
    User? lastDeletedUser,
  }) {
    return UsersOverviewState(
      status: status ?? this.status,
      users: users ?? this.users,
      lastDeletedUser: lastDeletedUser ?? this.lastDeletedUser,
    );
  }

  @override
  List<Object?> get props => [status, users, lastDeletedUser];
}
