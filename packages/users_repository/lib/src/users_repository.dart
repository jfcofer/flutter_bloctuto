import 'package:users_api/users_api.dart';

/// {@template users_repository}
/// Repositorio de los usuarios para las peticiones de la app.
/// {@endtemplate}
class UsersRepository {
  /// {@macro users_repository}
  const UsersRepository({required UsersApi usersApi}) : _usersApi = usersApi;

  final UsersApi _usersApi;

  ///Metodo que devuelve en [Stream] una lista de los usuarios
  Stream<List<User>> getUsers() => _usersApi.getUsers();

  ///Metodo para guardar un nuevo [User], o modificarlo si tiene el mismo id
  Future<void> saveUser(User user) => _usersApi.saveUser(user);

  ///Metodo para eliminar un [User] de la base segun su id,
  ///si no se encuentra el id, arroja un [UserNotFoundException]
  Future<void> deleteUser(String id) => _usersApi.deleteUser(id);
}
