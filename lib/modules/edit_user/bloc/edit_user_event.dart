part of 'edit_user_bloc.dart';

sealed class EditUserEvent extends Equatable {
  const EditUserEvent();

  @override
  List<Object> get props => [];
}

final class EditUserNameChanged extends EditUserEvent {
  const EditUserNameChanged({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

final class EditUserEmailChanged extends EditUserEvent {
  const EditUserEmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

final class EditUserSubmitted extends EditUserEvent {
  const EditUserSubmitted();
}
