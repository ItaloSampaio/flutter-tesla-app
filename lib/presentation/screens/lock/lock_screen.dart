import 'package:flutter/material.dart';
import 'package:tesla_app/presentation/screens/lock/lock_controller.dart';

import 'widgets/widgets.dart';

class LockScreen extends StatelessWidget {
  final _lockController = LockController();
  final Animation<double> _doorPosition;
  final Animation<double> _hoodPosition;
  final Animation<double> _trunkPosition;

  final BoxConstraints constraints;
  final AnimationController animationController;

  LockScreen({
    Key? key,
    required this.constraints,
    required this.animationController,
  })  : _doorPosition = Tween<double>(
          begin: constraints.maxWidth / 2,
          end: constraints.maxWidth * 0.04,
        ).animate(animationController),
        _hoodPosition = Tween<double>(
          begin: constraints.maxHeight / 2,
          end: constraints.maxHeight * 0.13,
        ).animate(animationController),
        _trunkPosition = Tween<double>(
          begin: constraints.maxHeight / 2,
          end: constraints.maxHeight * 0.17,
        ).animate(animationController),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _lockController,
        animationController,
      ]),
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: [
                buildLockButton(
                  carLock: CarLock.leftDoor,
                  left: _doorPosition.value,
                ),
                buildLockButton(
                  carLock: CarLock.rightDoor,
                  right: _doorPosition.value,
                ),
                buildLockButton(
                  carLock: CarLock.hood,
                  top: _hoodPosition.value,
                ),
                buildLockButton(
                  carLock: CarLock.trunk,
                  bottom: _trunkPosition.value,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildLockButton({
    required CarLock carLock,
    double? left,
    double? right,
    double? top,
    double? bottom,
  }) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: Opacity(
        opacity: animationController.value,
        child: LockButton(
          isLocked: _lockController.isLocked(carLock),
          onPress: () => _lockController.toggleCarLock(carLock),
        ),
      ),
    );
  }
}
