import 'package:flutter/material.dart';
import 'package:tesla_app/presentation/core/constants.dart';
import 'package:tesla_app/presentation/widgets/car_blueprint.dart';

import 'temperature_controller.dart';
import 'widgets/widgets.dart';

class TemperatureScreen extends StatefulWidget {
  final CarController carController;

  final BoxConstraints constraints;
  final AnimationController animationController;

  final Animation<double> _position;
  final Animation<double> _opacity;

  TemperatureScreen({
    Key? key,
    required this.constraints,
    required this.animationController,
    required this.carController,
  })  : _position = Tween<double>(
          begin: 20.0,
          end: 0,
        ).animate(CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        )),
        _opacity = Tween<double>(
          begin: 0,
          end: 1,
        ).animate(CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        )),
        super(key: key);

  @override
  State<TemperatureScreen> createState() => _TemperatureScreenState();
}

class _TemperatureScreenState extends State<TemperatureScreen> {
  late final TemperatureController _temperatureController;

  @override
  void initState() {
    _temperatureController = TemperatureController(
      carController: widget.carController,
    );
    super.initState();
  }

  @override
  void dispose() {
    _temperatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _temperatureController,
        widget.animationController,
      ]),
      builder: (context, _) {
        return widget.animationController.value == 0
            ? const SizedBox()
            : Scaffold(
                backgroundColor: Colors.transparent,
                body: Stack(
                  children: [
                    Positioned(
                      top: widget._position.value,
                      child: Opacity(
                        opacity: widget._opacity.value,
                        child: Container(
                          padding: const EdgeInsets.only(left: kDefaultPadding),
                          width: widget.constraints.maxWidth,
                          height: widget.constraints.maxHeight,
                          child: Stack(
                            children: [
                              Positioned(
                                top: widget.constraints.maxHeight * 0.115,
                                child: AirConditioningModeRadioGroup(
                                  constraints: widget.constraints,
                                  currentMode:
                                      _temperatureController.currentMode,
                                  onChange: _temperatureController
                                      .changeAirConditioningMode,
                                ),
                              ),
                              Positioned(
                                top: widget.constraints.maxHeight * 0.45,
                                child: TemperatureSelector(
                                  constraints: widget.constraints,
                                  value: _temperatureController.temperature,
                                  onIncreasePress: _temperatureController
                                      .increaseTemperature,
                                  onDecreasePress: _temperatureController
                                      .decreaseTemperature,
                                ),
                              ),
                              const Positioned(
                                bottom: kDefaultPadding,
                                child: TemperatureStatus(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
