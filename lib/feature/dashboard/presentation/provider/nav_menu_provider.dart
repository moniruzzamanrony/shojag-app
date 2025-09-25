import 'package:app/core/config/provider/base_provider.dart';
import 'package:app/core/utils/enums/main_menu.dart';
import 'package:flutter/material.dart';

class NavMenuProvider extends BaseProvider {
  MainMenu selectedMainMenu = MainMenu.home;

  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

  void updateMainMenu(MainMenu menu) {
    selectedMainMenu = menu;
    notify();
  }

  @override
  void notify() => notifyListeners();

  @override
  void resetAll() {
    selectedMainMenu = MainMenu.home;
  }
}
