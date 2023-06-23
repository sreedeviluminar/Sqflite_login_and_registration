import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  //create database
  static Future<sql.Database> OpenDb() async {
    return sql.openDatabase('datauser', version: 1,
        onCreate: (sql.Database db, int version) async {
          await createTable(db);
        });
  }

  //create Table
  static Future<void> createTable(sql.Database db) async {
    await db.execute("""CREATE TABLE user(
       id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
       name TEXT,
       email TEXT,
       password TEXT
      )""");
  }

  //create new user
  static Future<int> AddNewUser(String name, String email, String password) async {
    final db = await SQLHelper.OpenDb();
    final data = {'name': name, 'email': email, 'password': password};
    final id = db.insert('user', data);
    return id;
  }
/// user found in db for login
  static Future<List<Map>> CheckLogin(String email, String password) async {
    final db = await SQLHelper.OpenDb();
    final data = await db.rawQuery(
        "SELECT * FROM user WHERE email= '$email' AND password = '$password' ");
   // print(data.toString());
    if (data.isNotEmpty) {
      return data;
    }
    return data;
  }

  ///check user already exist for registration
  static Future<List<Map>> userFound(String uname, String eemail) async {
    final db = await SQLHelper.OpenDb();
    final data = await db.rawQuery(
        "SELECT * FROM user WHERE name= '$uname' AND email = '$eemail' ");
    if (data.isNotEmpty) {
      return data;
    }
    return data;
  }

  /// fetch all the users in db
  static Future<List<Map<String ,dynamic>>> getAll() async {
    final db = await SQLHelper.OpenDb();
    final data = db.rawQuery("SELECT * FROM user");
    return data;
  }

  ///
  static Future<void> Deleteuser(int id) async {
    final db = await SQLHelper.OpenDb();
    db.delete('user', where: 'id = ?', whereArgs: [id]);
  }

  ///update a single contact
  static Future<int> update(int id, String name, String email) async {
    final db = await SQLHelper.OpenDb();
    final newdata = {
      'name'  : name,
      'email': email,
    };
    final newid = await db.update('user', newdata, where: 'id =?', whereArgs: [id]);
    return newid;
  }
}
