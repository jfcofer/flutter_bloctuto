import 'package:database_users_api/src/users_table.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

///Database Provider
class DatabaseProvider {
  ///[DatabaseProvider] constructor
  ///
  ///If already created, returns the same  [DatabaseProvider] instance
  factory DatabaseProvider() {
    return _instance;
  }

  DatabaseProvider._internal();
  static final DatabaseProvider _instance = DatabaseProvider._internal();

  Database? _database;

  static const _databaseName = 'usersDatabase_debug.db';
  static const _databaseVersion = 1;

  ///Access to the SQLITE database
  ///
  ///Returns [Database]
  Future<Database> get database async {
    return _database ??= await _createDatabase();
  }

  Future<void> _initDatabase(Database database, int version) async {
    await database.execute(UsersTable.usersTableScript);
  }

  Future<Database> _createDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    final database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _initDatabase,
    );
    return database;
  }
}
