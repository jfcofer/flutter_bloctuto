import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:users_repository/users_repository.dart';

part 'users_overview_event.dart';
part 'users_overview_state.dart';

class UsersOverviewBloc extends Bloc<UsersOverviewEvent, UsersOverviewState> {
  UsersOverviewBloc({required UsersRepository usersRepository})
      : _usersRepository = usersRepository,
        super(const UsersOverviewState()) {
    on<UsersOverviewSubscriptionRequested>(
      _onUsersOverviewSubscriptionRequested,
    );
    on<UsersOverviewUserDeleted>(_onUsersOverviewUserDeleted);
    on<UsersOverviewUndoDeletionRequested>(
      _onUsersOverviewUndoDeletionRequested,
    );
  }

  final UsersRepository _usersRepository;

  Future<void> _onUsersOverviewSubscriptionRequested(
    UsersOverviewSubscriptionRequested event,
    Emitter<UsersOverviewState> emit,
  ) async {
    emit(state.copyWith(status: UsersOverviewStatus.loading));
    await emit.forEach(
      _usersRepository.getUsers(),
      onData: (data) =>
          state.copyWith(status: UsersOverviewStatus.success, users: data),
      onError: (error, stackTrace) => state.copyWith(
        status: UsersOverviewStatus.failure,
      ),
    );
  }

  Future<void> _onUsersOverviewUserDeleted(
    UsersOverviewUserDeleted event,
    Emitter<UsersOverviewState> emit,
  ) async {
    emit(state.copyWith(lastDeletedUser: event.user));
    await _usersRepository.deleteUser(event.user.id);
  }

  Future<void> _onUsersOverviewUndoDeletionRequested(
    UsersOverviewUndoDeletionRequested event,
    Emitter<UsersOverviewState> emit,
  ) async {
    assert(
      state.lastDeletedUser != null,
      'Last deleted user can not be null.',
    );
    final user = state.lastDeletedUser!;
    emit(state.copyWith(lastDeletedUser: null));
    await _usersRepository.saveUser(user);
  }
}
