import 'package:agenda_contactos/helpers/contact_helper.dart';
import 'package:agenda_contactos/model/Contact.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ContactHelper helper = ContactHelper();


  @override
  void initState() {
    super.initState();

    Contact c = Contact();
    c.name = "Elio";
    c.email = "elio@teste.pt";
    c.phone = "987654321";
    c.img = "imgtest";

    helper.saveContact(c);

  helper.getAllContacts().then((list) {
    print(list);
  });

  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
