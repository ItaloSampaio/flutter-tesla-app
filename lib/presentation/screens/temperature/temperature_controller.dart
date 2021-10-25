import 'package:flutter/material.dart';
import 'package:tesla_app/presentation/widgets/car_blueprint.dart';

import 'air_conditioning_mode.dart';

class TemperatureController extends ChangeNotifier {
  final CarController carController;
  AirConditioningMode _currentMode = AirConditioningMode.cool;
  int _temperature = 20;

  TemperatureController({
    required this.carController,
  });

  AirConditioningMode get currentMode => _currentMode;

  int get temperature => _temperature;

  void changeAirConditioningMode(AirConditioningMode mode) {
    _currentMode = mode;
    carController.changeInsideColor(
      _currentMode == AirConditioningMode.cool
          ? CarInsideColor.primary
          : CarInsideColor.secondary,
    );
    notifyListeners();
  }

  void increaseTemperature() {
    _temperature++;
    notifyListeners();
  }

  void decreaseTemperature() {
    _temperature--;
    notifyListeners();
  }
}
