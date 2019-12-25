import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:agenda_contactos/model/Contact.dart';
import 'contact_columns.dart';

class ContactHelper {

  static final ContactHelper _instance = ContactHelper.internal();
  static final String table = "contactTable";

  factory ContactHelper() => _instance;

  ContactHelper.internal();

  Database _db;

  //#region Database Configs
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
        "CREATE TABLE $table("
            "$ContactColumns.idColumn INTEGER PRIMARY KEY, "
            "$ContactColumns.nameColumn TEXT, "
            "$ContactColumns.emailColumn TEXT, "
            "$ContactColumns.phoneColumn TEXT, "
            "$ContactColumns.imgColumn TEXT)"
      );
    });
  }
  //#endregion

  //#region Manipulate Contact Methods

  Future<Contact> saveContact(Contact contact) async{
    Database dbContact = await db;
    contact.id = await dbContact.insert(table, contact.toMap());
    return contact;
  }

  Future<Contact> getContact(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(table,
      columns: [ContactColumns.idColumn.toString(), ContactColumns.nameColumn.toString(), ContactColumns.emailColumn.toString(), ContactColumns.phoneColumn.toString(), ContactColumns.imgColumn.toString()],
      where: "$ContactColumns.idColumn = ?",
      whereArgs: [id]);
    if (maps.length > 0) {
      return Contact.fromMap(maps.first);
    }
    return null;
  }
  //#endregion

}