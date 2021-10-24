import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tesla_app/presentation/core/assets.dart';
import 'package:tesla_app/presentation/core/constants.dart';
import 'package:tesla_app/presentation/screens/battery/battery_screen.dart';
import 'package:tesla_app/presentation/screens/lock/lock_screen.dart';

import 'home_controller.dart';
import 'widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _homeController = HomeController();

  late AnimationController _lockAnimationController;
  late AnimationController _batteryAnimationController;

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

    super.initState();
  }

  @override
  void dispose() {
    _lockAnimationController.dispose();
    _batteryAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _homeController,
      builder: (context, snapshot) {
        return Scaffold(
          bottomNavigationBar: BottomTabBar(
            selectedTabIndex: _homeController.selectedBottomTabIndex,
            onTap: (index) async {
              TickerFuture Function()? forward;
              TickerFuture Function()? reverse;

              if (index == 0) {
                forward = () => _lockAnimationController.forward();
              } else if (_homeController.selectedBottomTabIndex == 0) {
                reverse = () => _lockAnimationController.reverse();
              }

              if (index == 1) {
                forward = () => _batteryAnimationController.forward();
              } else if (_homeController.selectedBottomTabIndex == 1) {
                reverse = () => _batteryAnimationController.reverse(from: 0.75);
              }

              try {
                if (reverse != null) {
                  await reverse().orCancel;
                }

                _homeController.changeBottomTabIndex(index);

                if (forward != null) {
                  await forward().orCancel;
                }
              } on TickerCanceled {
                // ignore: avoid_print
                print('Canceled animation');
              }
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
                      constraints: constraints,
                      animationController: _lockAnimationController,
                    ),
                    BatteryScreen(
                      constraints: constraints,
                      animationController: _batteryAnimationController,
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
