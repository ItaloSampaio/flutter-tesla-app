import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tesla_app/presentation/core/asset_paths.dart';
import 'package:tesla_app/presentation/core/constants.dart';

class CarBlueprint extends StatelessWidget {
  final BoxConstraints constraints;
  final CarController carController;
  final Size size;

  CarBlueprint({
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
        final color = carController.insideColor == CarInsideColor.primary
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
                        opacity: carController.isInsideColorVisible ? 1 : 0,
                        child: _InsideColor(size: size, color: color),
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

class _InsideColor extends StatelessWidget {
  final Size size;
  final Color color;

  const _InsideColor({
    Key? key,
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
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
    );
  }
}

enum CarPosition { center, right }
enum CarInsideColor { primary, secondary }

class CarController extends ChangeNotifier {
  CarPosition _position = CarPosition.center;
  Completer? _moveCompleter;
  CarInsideColor _insideColor = CarInsideColor.primary;
  bool _isInsideColorVisible = false;

  CarPosition get position => _position;

  bool get isInsideColorVisible => _isInsideColorVisible;

  CarInsideColor get insideColor => _insideColor;

  set isInsideColorVisible(bool value) {
    _isInsideColorVisible = value;
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

  void changeInsideColor(CarInsideColor insideColor) {
    _insideColor = insideColor;
    notifyListeners();
  }
}
