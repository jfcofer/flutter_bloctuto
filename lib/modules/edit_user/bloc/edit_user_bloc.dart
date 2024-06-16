import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:users_repository/users_repository.dart';

part 'edit_user_event.dart';
part 'edit_user_state.dart';

class EditUserBloc extends Bloc<EditUserEvent, EditUserState> {
  EditUserBloc({
    required UsersRepository usersRepository,
    required User? initialUser,
  })  : _usersRepository = usersRepository,
        super(
          EditUserState(
            initialUser: initialUser,
            name: initialUser?.name ?? '',
            email: initialUser?.email ?? '',
          ),
        ) {
    on<EditUserNameChanged>(_onNameChanged);
    on<EditUserEmailChanged>(_onEmailChanged);
    on<EditUserSubmitted>(_onSubmitted);
  }

  final UsersRepository _usersRepository;

  void _onNameChanged(EditUserNameChanged event, Emitter<EditUserState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _onEmailChanged(
    EditUserEmailChanged event,
    Emitter<EditUserState> emit,
  ) {
    emit(state.copyWith(email: event.email));
  }

  Future<void> _onSubmitted(
    EditUserSubmitted event,
    Emitter<EditUserState> emit,
  ) async {
    emit(state.copyWith(status: EditUserStatus.loading));
    final user = (state.initialUser ?? User(name: '', email: '')).copyWith(
      name: state.name,
      email: state.email,
    );
    try {
      await _usersRepository.saveUser(user);
      emit(state.copyWith(status: EditUserStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditUserStatus.failure));
    }
  }
}
