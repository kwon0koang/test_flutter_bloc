import 'package:flutter/material.dart';

enum BottomNavigationMenuType {
  home('HOME', Icon(Icons.home)),
  search('SEARCH', Icon(Icons.search)),
  menu('MENU', Icon(Icons.menu));

  final String label;
  final Icon icon;

  const BottomNavigationMenuType(this.label, this.icon);
}
