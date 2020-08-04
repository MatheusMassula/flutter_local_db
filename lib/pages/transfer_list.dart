import 'package:flutter/material.dart';
import 'package:flutter_local_db/models/contact.dart';
import 'package:flutter_local_db/pages/contact_form.dart';
import 'package:flutter_local_db/pages/widgets/contact_tile.dart';
import 'package:flutter_local_db/services/database/dao/contact_dao.dart';

class TransferList extends StatefulWidget {
  @override
  _TransferListState createState() => _TransferListState();
}

class _TransferListState extends State<TransferList> {
  final ContactDao _contactDao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => _addContact(context),
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text('Transfer'),
        ),
        body: FutureBuilder(
          initialData: List(),
          future: _contactDao.getAll(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                final List<Contact> contactList = snapshot.data;
                return _buildcontactList(contactList);
                break;

              case ConnectionState.waiting:
                return _buildLoading();
                break;

              case ConnectionState.none:
                return Container();
                break;

              case ConnectionState.active:
                return Container();
                break;

              default:
                return Container();
            }
          },
        ));
  }

  Widget _buildcontactList(List<Contact> contactList) {
    return ListView.builder(
      itemCount: contactList.length,
      itemBuilder: (context, index) {
        return ContactTile(
          contact: contactList[index],
        );
      },
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[CircularProgressIndicator(), Text('Loading...')],
      ),
    );
  }

  void _addContact(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ContactForm())
    ).then(
      (value) {
        setState(() {
          
        });
      }
    );
  } 
}