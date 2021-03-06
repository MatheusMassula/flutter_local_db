import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_db/models/state/name.dart';

class NameContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => NameView();
}

class NameView extends StatelessWidget {
  final TextEditingController _nameTextEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameTextEditController.text = context.watch<NameCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Change name'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _nameTextEditController,
            decoration: InputDecoration(
              labelText: 'Desired name',
            ),
            style: TextStyle(fontSize: 24.0),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SizedBox(
              width: double.maxFinite,
              child: RaisedButton(
                onPressed: () {
                  context.read<NameCubit>().change(_nameTextEditController.text);
                  Navigator.pop(context);
                },
                child: Text('Change'),
              ),
            ),
          )
        ],
      )
    );
  }
}