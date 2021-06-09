import 'package:flutter/cupertino.dart';

class StoryModel extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void add() {
    _counter = _counter + 1;
    notifyListeners();
  }

  void clear() {
    _counter = 0;
    notifyListeners();
  }
}
