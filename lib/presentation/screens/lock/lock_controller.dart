import 'package:flutter/material.dart';

enum CarLock { hood, leftDoor, rightDoor, trunk }

class LockController extends ChangeNotifier {
  final _carLocks = {
    CarLock.hood: true,
    CarLock.leftDoor: true,
    CarLock.rightDoor: true,
    CarLock.trunk: true,
  };

  bool isLocked(CarLock carLock) {
    return _carLocks[carLock] ?? true;
  }

  void toggleCarLock(CarLock carLock) {
    _carLocks[carLock] = !(_carLocks[carLock] ?? true);
    notifyListeners();
  }
}
