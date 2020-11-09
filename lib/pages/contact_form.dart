import 'package:flutter/material.dart';
import 'package:flutter_local_db/models/contact.dart';
import 'package:flutter_local_db/services/database/dao/contact_dao.dart';
import 'package:flutter_local_db/widgets/app_dependencies.dart';

class ContactForm extends StatefulWidget {

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('New contact'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full name',
                  hintText: 'Type the contact name here'
                ),
                style: TextStyle(
                  fontSize: 24
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  controller: _accountController,
                  decoration: InputDecoration(
                    labelText: 'Account number',
                    hintText: '000000-0'
                  ),
                  style: TextStyle(
                    fontSize: 24
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () => _validateForm(dependencies.contactDao),
                    child: Text('Create'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _validateForm(ContactDao contactDao) async {
    if(_formKey.currentState.validate()) {
      Contact newContact = Contact(
        0,
        _nameController.text,
        int.tryParse(_accountController.text),
      );

      await contactDao.insert(contact: newContact);
      Navigator.pop(context);
    }
  }
}