part of 'users_overview_bloc.dart';

sealed class UsersOverviewEvent extends Equatable {
  const UsersOverviewEvent();

  @override
  List<Object> get props => [];
}

class UsersOverviewSubscriptionRequested extends UsersOverviewEvent {
  const UsersOverviewSubscriptionRequested();
}

class UsersOverviewUserDeleted extends UsersOverviewEvent {
  const UsersOverviewUserDeleted({required this.user});

  final User user;

  @override
  List<Object> get props => [user];
}

class UsersOverviewUndoDeletionRequested extends UsersOverviewEvent {
  const UsersOverviewUndoDeletionRequested();
}
