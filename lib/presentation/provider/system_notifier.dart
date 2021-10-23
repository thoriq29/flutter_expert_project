import 'package:ditonton/common/state_enum.dart';
import 'package:flutter/foundation.dart';

class SystemNotifier extends ChangeNotifier {

  MenuState _menuState = MenuState.Movie;
  MenuState get menuState => _menuState;

  setMenuState(val) {
    _menuState = val;
    notifyListeners();
  }
}