import 'package:flutter/material.dart';
import 'package:tesla_app/presentation/core/constants.dart';
import 'package:tesla_app/presentation/screens/battery/battery_screen.dart';
import 'package:tesla_app/presentation/screens/lock/lock_screen.dart';
import 'package:tesla_app/presentation/screens/temperature/temperature_screen.dart';
import 'package:tesla_app/presentation/widgets/widgets.dart';

import 'home_controller.dart';
import 'widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _homeController = HomeController();
  final _carController = CarController();

  late AnimationController _lockAnimationController;
  late AnimationController _batteryAnimationController;
  late AnimationController _temperatureAnimationController;

  @override
  void initState() {
    _lockAnimationController = AnimationController(
      vsync: this,
      duration: kDefaultDuration,
      value: 1,
    );

    _batteryAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _temperatureAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    super.initState();
  }

  @override
  void dispose() {
    _lockAnimationController.dispose();
    _batteryAnimationController.dispose();
    _temperatureAnimationController.dispose();
    _carController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _homeController,
        // _carController,
      ]),
      builder: (context, _) {
        return Scaffold(
          bottomNavigationBar: BottomTabBar(
            selectedTabIndex: _homeController.selectedBottomTabIndex,
            onTap: (index) async {
              Future Function()? forward;
              Future Function()? reverse;

              if (index == 0) {
                forward = () => _lockAnimationController.forward();
              } else if (_homeController.selectedBottomTabIndex == 0) {
                reverse = () => _lockAnimationController.reverse();
              }

              if (index == 1) {
                forward = () => _batteryAnimationController.forward();
              } else if (_homeController.selectedBottomTabIndex == 1) {
                reverse = () => _batteryAnimationController.reverse();
              }

              if (index == 2) {
                forward = () async {
                  await _carController.move(CarPosition.right);
                  await _temperatureAnimationController.forward();
                  _carController.isInsideColorVisible = true;
                };
              } else if (_homeController.selectedBottomTabIndex == 2) {
                reverse = () async {
                  _carController.isInsideColorVisible = false;
                  await _temperatureAnimationController.reverse();
                  await _carController.move(CarPosition.center);
                };
              }

              if (reverse != null) {
                await reverse();
              }

              _homeController.changeBottomTabIndex(index);

              if (forward != null) {
                await forward();
              }
            },
          ),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    CarBlueprint(
                      constraints: constraints,
                      carController: _carController,
                    ),
                    LockScreen(
                      constraints: constraints,
                      animationController: _lockAnimationController,
                    ),
                    BatteryScreen(
                      constraints: constraints,
                      animationController: _batteryAnimationController,
                    ),
                    TemperatureScreen(
                      constraints: constraints,
                      animationController: _temperatureAnimationController,
                      carController: _carController,
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
