import 'package:flutter/material.dart';

class ProgressView extends StatelessWidget {
  const ProgressView({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Text('Loading...')
        ],
      ),
    ),
  );
}