/// Users Table Constants
class UsersTable {
  ///Name of the users table
  ///Returns a [String]
  static String get usersTableName => 'USERS';

  ///'id' field for the users table
  ///Returns a [String]
  static String get usersID => 'id';

  ///'name' field for the users table
  ///Returns a [String]
  static String get usersName => 'name';

  ///'email' field for the users table
  ///Returns a [String]
  static String get usersEmail => 'email';

  ///SQL script used to create the users table
  static String get usersTableScript => '''
  CREATE TABLE IF NOT EXISTS $usersTableName  (
    $usersID TEXT PRIMARY KEY,
    $usersName TEXT NOT NULL,
    $usersEmail TEXT NOT NULL
  )
''';
}
