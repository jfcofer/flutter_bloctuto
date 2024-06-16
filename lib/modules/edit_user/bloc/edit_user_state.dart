part of 'edit_user_bloc.dart';

enum EditUserStatus { initial, loading, success, failure }

extension EditUserStatusX on EditUserStatus {
  bool get isLoadingOrSucces => [
        EditUserStatus.loading,
        EditUserStatus.success,
      ].contains(this);
}

final class EditUserState extends Equatable {
  const EditUserState({
    this.status = EditUserStatus.initial,
    this.initialUser,
    this.name = '',
    this.email = '',
  });

  final EditUserStatus status;
  final User? initialUser;
  final String name;
  final String email;

  bool get isNewUser => initialUser == null;

  EditUserState copyWith({
    EditUserStatus? status,
    User? initialUser,
    String? name,
    String? email,
  }) {
    return EditUserState(
      status: status ?? this.status,
      initialUser: initialUser ?? this.initialUser,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [
        status,
        initialUser,
        name,
        email,
      ];
}
