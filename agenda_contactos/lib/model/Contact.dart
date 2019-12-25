import 'package:agenda_contactos/helpers/contact_columns.dart';

class Contact {
  int id;
  String name;
  String email;
  String phone;
  String img;

  Contact();

  Contact.fromMap(Map map) {
    this.id = map[ContactColumns.idColumn];
    this.name = map[ContactColumns.nameColumn];
    this.email = map[ContactColumns.emailColumn];
    this.phone = map[ContactColumns.phoneColumn];
    this.img = map[ContactColumns.imgColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      ContactColumns.nameColumn: name,
      ContactColumns.emailColumn: email,
      ContactColumns.phoneColumn: phone,
      ContactColumns.imgColumn: img,
    };

    if (id != null) {
      map[ContactColumns.idColumn] = id;
    }

    return map;
  }

  @override
  String toString() {
    return "Contact {id: $id, name: $name, email: $email, phone: $phone, img: $img}";
  }
}