import 'package:flutter/material.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final String message;

  const ProgressIndicatorWidget({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message?? 'Loading...',
              style: TextStyle(fontSize: 16.0),
            ),
          )
        ],
      ),
    );
  }
}