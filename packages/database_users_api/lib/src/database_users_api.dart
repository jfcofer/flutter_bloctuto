import 'dart:async';
import 'package:database_users_api/src/database_provider.dart';
import 'package:database_users_api/src/users_table.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:users_api/users_api.dart';

/// {@template database_users_api}
/// API que conecta los requests de un usuario con la Base de Datos
/// {@endtemplate}
class DatabaseUsersApi implements UsersApi {
  /// {@macro database_users_api}
  DatabaseUsersApi({DatabaseProvider? databaseProvider})
      : _databaseProvider = databaseProvider ?? DatabaseProvider() {
    _init();
  }

  final DatabaseProvider _databaseProvider;

  final _userStreamController = BehaviorSubject<List<User>>.seeded(const []);

  Future<void> _init() async {
    final users = await _getAllUsersFromDatabase();
    _userStreamController.add(users);
  }

  @override
  Stream<List<User>> getUsers() => _userStreamController.asBroadcastStream();

  @override
  Future<void> saveUser(User user) async {
    final users = [..._userStreamController.value];
    final userIndex = users.indexWhere((element) => element == user);
    if (userIndex >= 0) {
      users[userIndex] = user;
    } else {
      users.add(user);
    }
    _userStreamController.add(users);
    await _saveUserFromDatabase(user);
  }

  @override
  Future<void> deleteUser(String id) async {
    final users = [..._userStreamController.value];
    final userIndex = users.indexWhere((element) => element.id == id);
    if (userIndex == -1) {
      throw UserNotFoundException();
    } else {
      users.removeAt(userIndex);
      _userStreamController.add(users);
      await _deleteUserFromDatabase(id);
    }
  }

  Future<void> _saveUserFromDatabase(User user) async {
    final database = await _databaseProvider.database;
    final result = await database.insert(
      UsersTable.usersTableName,
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    if (result == 0) {
      throw UserNotFoundException();
    }
  }

  Future<void> _deleteUserFromDatabase(String id) async {
    final database = await _databaseProvider.database;
    final result = await database.delete(
      UsersTable.usersTableName,
      where: '${UsersTable.usersID} = ?',
      whereArgs: [id],
    );
    if (result == 0) {
      throw UserNotFoundException();
    }
  }

  Future<List<User>> _getAllUsersFromDatabase() async {
    final database = await _databaseProvider.database;
    final result = await database.query(UsersTable.usersTableName);
    return result.map(User.fromJson).toList();
  }
}
