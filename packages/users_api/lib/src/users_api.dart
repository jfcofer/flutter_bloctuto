import 'package:users_api/src/models/user.dart';

/// {@template users_api}
/// Interfaz para el API que da acceso a la lista los usuarios
/// {@endtemplate}
abstract class UsersApi {
  /// {@macro users_api}
  const UsersApi();

  /// Metodo que devuelve en [Stream] una lista de los usuarios
  Stream<List<User>> getUsers();

  ///Metodo para guardar un nuevo [User], o modificarlo si tiene el mismo id
  Future<void> saveUser(User user);

  ///Metodo para eliminar un [User] de la base segun su id,
  ///si no se encuentra el id, arroja un [UserNotFoundException]
  Future<void> deleteUser(String id);
}

///Excepcion si no encuentra el de un [User]
class UserNotFoundException implements Exception {}
