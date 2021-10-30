import 'package:flutter/material.dart';
import 'package:tesla_app/presentation/screens/lock/lock_controller.dart';

import 'widgets/widgets.dart';

class LockScreen extends StatefulWidget {
  final Animation<double> _doorPosition;
  final Animation<double> _hoodPosition;
  final Animation<double> _trunkPosition;
  final Animation<double> _opacity;

  final BoxConstraints constraints;
  final AnimationController animationController;

  LockScreen({
    Key? key,
    required this.constraints,
    required this.animationController,
  })  : _doorPosition = Tween<double>(
          begin: constraints.maxWidth / 2,
          end: constraints.maxWidth * 0.04,
        ).animate(CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        )),
        _hoodPosition = Tween<double>(
          begin: constraints.maxHeight / 2,
          end: constraints.maxHeight * 0.13,
        ).animate(CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        )),
        _trunkPosition = Tween<double>(
          begin: constraints.maxHeight / 2,
          end: constraints.maxHeight * 0.17,
        ).animate(CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        )),
        _opacity = Tween<double>(
          begin: 0,
          end: 1,
        ).animate(CurvedAnimation(
          parent: animationController,
          curve: const Interval(0.1, 1, curve: Curves.easeInOut),
        )),
        super(key: key);

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  final _lockController = LockController();

  @override
  void dispose() {
    _lockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _lockController,
        widget.animationController,
      ]),
      builder: (context, _) {
        return widget.animationController.value == 0
            ? const SizedBox()
            : Scaffold(
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      buildLockButton(
                        carLock: CarLock.leftDoor,
                        left: widget._doorPosition.value,
                      ),
                      buildLockButton(
                        carLock: CarLock.rightDoor,
                        right: widget._doorPosition.value,
                      ),
                      buildLockButton(
                        carLock: CarLock.hood,
                        top: widget._hoodPosition.value,
                      ),
                      buildLockButton(
                        carLock: CarLock.trunk,
                        bottom: widget._trunkPosition.value,
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
        opacity: widget._opacity.value,
        child: LockButton(
          isLocked: _lockController.isLocked(carLock),
          onPress: () => _lockController.toggleCarLock(carLock),
        ),
      ),
    );
  }
}
