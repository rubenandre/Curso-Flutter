import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:agenda_contactos/model/Contact.dart';
import 'contact_columns.dart';

class ContactHelper {

  static final ContactHelper _instance = ContactHelper.internal();

  factory ContactHelper() => _instance;

  ContactHelper.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  Future<Database> initDB() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "contacts.db");
    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async {
      await db.execute(
        "CREATE TABLE contactTable("
            "$ContactColumns.idColumn INTEGER PRIMARY KEY, "
            "$ContactColumns.nameColumn TEXT, "
            "$ContactColumns.emailColumn TEXT, "
            "$ContactColumns.phoneColumn TEXT, "
            "$ContactColumns.imgColumn TEXT)"
      );
    });
  }

}