import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tesla_app/presentation/core/assets.dart';

import 'widgets/battery_status.dart';

class BatteryScreen extends StatelessWidget {
  final BoxConstraints constraints;
  final AnimationController animationController;

  final Animation<double> _batteryOpacity;
  final Animation<double> _statusPosition;

  BatteryScreen({
    Key? key,
    required this.constraints,
    required this.animationController,
  })  : _batteryOpacity = CurvedAnimation(
          parent: animationController,
          curve: const Interval(0.0, 0.5),
        ),
        _statusPosition = CurvedAnimation(
          parent: animationController,
          curve: const Interval(0.6, 1.0),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, _) {
        return animationController.value == 0
            ? const SizedBox()
            : Scaffold(
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  child: Stack(
                    children: [
                      Center(
                        child: Opacity(
                          opacity: _batteryOpacity.value,
                          child: SvgPicture.asset(
                            Assets.svgs.battery,
                            width: constraints.maxWidth * 0.45,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 50 * (1 - _statusPosition.value),
                        height: constraints.maxHeight,
                        width: constraints.maxWidth,
                        child: Opacity(
                          opacity: _statusPosition.value,
                          child: BatteryStatus(constraints: constraints),
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
