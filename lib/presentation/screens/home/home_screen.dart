import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tesla_app/presentation/core/assets.dart';
import 'package:tesla_app/presentation/screens/lock/lock_screen.dart';

import 'home_controller.dart';
import 'widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final _homeController = HomeController();

  late AnimationController _batteryAnimationController;
  late Animation<double> _batteryAnimation;
  late Animation<double> _batteryStatusAnimation;

  @override
  void initState() {
    _setupBatteryAnimation();
    super.initState();
  }

  void _setupBatteryAnimation() {
    _batteryAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _batteryAnimation = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: const Interval(0.0, 0.5),
    );

    _batteryStatusAnimation = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: const Interval(0.6, 1.0),
    );
  }

  @override
  void dispose() {
    _batteryAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _homeController,
        _batteryAnimationController,
      ]),
      builder: (context, snapshot) {
        return Scaffold(
          bottomNavigationBar: BottomTabBar(
            selectedTabIndex: _homeController.selectedBottomTabIndex,
            onTap: (index) {
              if (index == 1) {
                _batteryAnimationController.forward();
              } else if (_homeController.selectedBottomTabIndex == 1) {
                _batteryAnimationController.reverse(from: 0.75);
              }

              _homeController.changeBottomTabIndex(index);
            },
          ),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: constraints.maxHeight * 0.1,
                      ),
                      child: SvgPicture.asset(
                        Assets.svgs.car,
                        width: double.infinity,
                      ),
                    ),
                    LockScreen(
                      isVisible: _homeController.selectedBottomTabIndex == 0,
                    ),
                    Opacity(
                      opacity: _batteryAnimation.value,
                      child: SvgPicture.asset(
                        Assets.svgs.battery,
                        width: constraints.maxWidth * 0.45,
                      ),
                    ),
                    Positioned(
                      top: 50 * (1 - _batteryStatusAnimation.value),
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      child: Opacity(
                        opacity: _batteryStatusAnimation.value,
                        child: BatteryStatus(constraints: constraints),
                      ),
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
