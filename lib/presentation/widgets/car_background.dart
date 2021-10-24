import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tesla_app/presentation/core/asset_paths.dart';
import 'package:tesla_app/presentation/core/constants.dart';

class CarBackground extends StatelessWidget {
  final BoxConstraints constraints;
  final CarController carController;
  final Size size;

  CarBackground({
    Key? key,
    required this.constraints,
    required this.carController,
  })  : size = Size(
          constraints.maxWidth * 0.554,
          constraints.maxHeight * 0.799,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: carController,
      builder: (_, child) {
        final color = carController.color == CarColor.primary
            ? kPrimaryColor
            : kSecondaryColor;

        return Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              right: carController.position == CarPosition.right
                  ? -constraints.maxWidth / 2
                  : 0,
              onEnd: carController._onMoveEnd,
              child: SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: Stack(
                  children: [
                    Align(
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: carController.isColorVisible ? 1 : 0,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          width: size.width,
                          height: size.height / 1.03,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(100),
                            ),
                            gradient: LinearGradient(
                              colors: [
                                color.withOpacity(0.01),
                                color.withOpacity(0.3),
                                color.withOpacity(0.01),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(child: child),
                  ],
                ),
              ),
            ),
          ],
        );
      },
      child: SvgPicture.asset(
        AssetPaths.svgs.car,
        width: size.width,
        height: size.height,
      ),
    );
  }
}

enum CarPosition { center, right }
enum CarColor { primary, secondary }

class CarController extends ChangeNotifier {
  CarPosition _position = CarPosition.center;
  Completer? _moveCompleter;
  CarColor _color = CarColor.primary;
  bool _isColorVisible = false;

  CarPosition get position => _position;

  bool get isColorVisible => _isColorVisible;

  CarColor get color => _color;

  set isColorVisible(bool value) {
    _isColorVisible = value;
    notifyListeners();
  }

  Future<void> move(CarPosition position) {
    _position = position;
    _moveCompleter = Completer();
    notifyListeners();
    return _moveCompleter!.future;
  }

  void _onMoveEnd() {
    _moveCompleter?.complete();
  }

  void changeBackgroundColor(CarColor color) {
    _color = color;
    notifyListeners();
  }
}
