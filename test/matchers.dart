import 'package:flutter/material.dart';
import 'package:flutter_local_db/pages/widgets/dashboard_card.dart';

bool dashBoadCardMatcher({Widget widget, String title, IconData icon}) {
  if(widget is DashboardCard && widget.title == title && widget.icon == icon) return true;
  else return false;
}