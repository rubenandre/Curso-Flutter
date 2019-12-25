import 'package:agenda_contactos/helpers/contact_columns.dart';

class Contact {
  int id;
  String name;
  String email;
  String phone;
  String img;

  Contact.fromMap(Map map) {
    this.id = map[ContactColumns.idColumn.toString()];
    this.name = map[ContactColumns.nameColumn.toString()];
    this.email = map[ContactColumns.emailColumn.toString()];
    this.phone = map[ContactColumns.phoneColumn.toString()];
    this.img = map[ContactColumns.imgColumn.toString()];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      ContactColumns.nameColumn.toString(): name,
      ContactColumns.emailColumn.toString(): email,
      ContactColumns.phoneColumn.toString(): phone,
      ContactColumns.imgColumn.toString(): img,
    };

    if (id != null) {
      map[ContactColumns.idColumn.toString()] = id;
    }

    return map;
  }

  @override
  String toString() {
    return "Contact {id: $id, name: $name, email: $email, phone: $phone, img: $img}";
  }
}