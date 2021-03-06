import 'package:flutter/material.dart';
import 'package:flutter_local_db/pages/widgets/dashboard_card.dart';

bool dashBoadCardMatcher({Widget widget, String title, IconData icon}) {
  if(widget is DashboardCard && widget.title == title && widget.icon == icon) return true;
  else return false;
}

bool textFieldByLabelTextMatcher({Widget widget, String labelText}) {
  if(widget is TextField) {
    return widget.decoration.labelText == labelText;
  }
  return false;
}