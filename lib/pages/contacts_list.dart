import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: ListView(
        children: List.generate(20, (index) => 
          Card(
            child: ListTile(
              title: Text(
                'Name $index',
                style: TextStyle(fontSize: 24),
              ),
              subtitle: Text(
                '${index + 1000}',
                style: TextStyle(fontSize: 16),
              ),
            ),
          )
        ),
      ),
    );
  }
}