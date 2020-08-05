import 'package:flutter/material.dart';

class EmptyListPlaceHolder extends StatelessWidget {
  final IconData icon;
  final String message;

  const EmptyListPlaceHolder({
    Key key,
    @required this.icon,
    @required this.message,
  }) :
  assert(message != null),
  super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Icon(icon),
          Text(message)
        ],
      ),
    );
  }
}