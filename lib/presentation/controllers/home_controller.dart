import 'package:flutter/material.dart';

enum CarLock { hood, leftDoor, rightDoor, trunk }

class HomeController extends ChangeNotifier {
  final _carLocks = {
    CarLock.hood: true,
    CarLock.leftDoor: true,
    CarLock.rightDoor: true,
    CarLock.trunk: true,
  };

  int _selectedBottomTabIndex = 0;

  int get selectedBottomTabIndex => _selectedBottomTabIndex;

  bool isLocked(CarLock carLock) => _carLocks[carLock] ?? true;

  void toggleCarLock(CarLock carLock) {
    _carLocks[carLock] = !(_carLocks[carLock] ?? true);
    notifyListeners();
  }

  void changeBottomTabIndex(int index) {
    _selectedBottomTabIndex = index;
    notifyListeners();
  }
}
