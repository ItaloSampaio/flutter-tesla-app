import 'package:flutter/material.dart';
import 'package:tesla_app/presentation/core/constants.dart';
import 'package:tesla_app/presentation/screens/lock/lock_controller.dart';

import 'widgets/widgets.dart';

class LockScreen extends StatefulWidget {
  final bool isVisible;

  const LockScreen({
    Key? key,
    required this.isVisible,
  }) : super(key: key);

  @override
  _LockScreenState createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  final _lockController = LockController();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _lockController,
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      buildLockButton(
                        carLock: CarLock.leftDoor,
                        left: widget.isVisible
                            ? constraints.maxWidth * 0.04
                            : constraints.maxWidth / 2,
                      ),
                      buildLockButton(
                        carLock: CarLock.rightDoor,
                        right: widget.isVisible
                            ? constraints.maxWidth * 0.04
                            : constraints.maxWidth / 2,
                      ),
                      buildLockButton(
                        carLock: CarLock.hood,
                        top: widget.isVisible
                            ? constraints.maxHeight * 0.13
                            : constraints.maxHeight / 2,
                      ),
                      buildLockButton(
                        carLock: CarLock.trunk,
                        bottom: widget.isVisible
                            ? constraints.maxHeight * 0.17
                            : constraints.maxHeight / 2,
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        });
  }

  Widget buildLockButton({
    required CarLock carLock,
    double? left,
    double? right,
    double? top,
    double? bottom,
  }) {
    return AnimatedPositioned(
      duration: kDefaultDuration,
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: AnimatedOpacity(
        duration: kDefaultDuration,
        opacity: widget.isVisible ? 1 : 0,
        child: LockButton(
          isLocked: _lockController.isLocked(carLock),
          onPress: () => _lockController.toggleCarLock(carLock),
        ),
      ),
    );
  }
}
