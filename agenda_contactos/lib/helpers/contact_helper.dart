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
    final path = join(databasesPath, "contactsruben.db");
    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async {
      await db.execute(
        "CREATE TABLE $table("
            "${ContactColumns.idColumn} INTEGER PRIMARY KEY, "
            "${ContactColumns.nameColumn} TEXT, "
            "${ContactColumns.emailColumn} TEXT, "
            "${ContactColumns.phoneColumn} TEXT, "
            "${ContactColumns.imgColumn} TEXT)"
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
      columns: [ContactColumns.idColumn, ContactColumns.nameColumn, ContactColumns.emailColumn, ContactColumns.phoneColumn, ContactColumns.imgColumn],
      where: "${ContactColumns.idColumn} = ?",
      whereArgs: [id]);
    if (maps.length > 0) {
      return Contact.fromMap(maps.first);
    }
    return null;
  }

  Future<bool> deleteContact (int id) async {
    Database dbContact = await db;
    int res = await dbContact.delete(table,
        where: "${ContactColumns.idColumn} = ?",
        whereArgs: [id]);
    return res == 0 ? false : true;
  }

  Future<bool> updateContact (Contact contact) async{
    Database dbContact = await db;
    int res = await dbContact.update(table,
        contact.toMap(),
        where: "${ContactColumns.idColumn} = ?",
        whereArgs: [contact.id]);
    return res == 0 ? false : true;
  }

  Future<List<Contact>> getAllContacts() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $table");
    List<Contact> listContact = List();
    listMap.forEach((m) => listContact.add(Contact.fromMap(m)));
    return listContact;
  }

  Future<int> getNumber() async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(await dbContact.rawQuery("SELECT COUNT(*) FROM $table"));
  }

  Future close() async {
    Database dbContact = await db;
    await dbContact.close();
  }
  //#endregion
}