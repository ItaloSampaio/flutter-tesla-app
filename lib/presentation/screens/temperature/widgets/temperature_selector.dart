import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tesla_app/presentation/core/asset_paths.dart';
import 'package:tesla_app/presentation/core/constants.dart';

class TemperatureSelector extends StatelessWidget {
  final BoxConstraints constraints;
  final int value;
  final VoidCallback onIncreasePress;
  final VoidCallback onDecreasePress;

  const TemperatureSelector({
    Key? key,
    required this.constraints,
    required this.value,
    required this.onIncreasePress,
    required this.onDecreasePress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ArrowButton(
          constraints: constraints,
          direction: _ArrowButtonDirection.up,
          onPress: onIncreasePress,
        ),
        Text('$value°C', style: const TextStyle(fontSize: 80)),
        _ArrowButton(
          constraints: constraints,
          direction: _ArrowButtonDirection.down,
          onPress: onDecreasePress,
        ),
      ],
    );
  }
}

enum _ArrowButtonDirection { up, down }

class _ArrowButton extends StatelessWidget {
  final _ArrowButtonDirection direction;
  final VoidCallback onPress;

  const _ArrowButton({
    Key? key,
    required this.constraints,
    required this.direction,
    required this.onPress,
  }) : super(key: key);

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onPress,
      child: AnimatedContainer(
        duration: kDefaultDuration,
        width: 30,
        child: RotatedBox(
          quarterTurns: direction == _ArrowButtonDirection.up ? 0 : 2,
          child: SvgPicture.asset(
            AssetPaths.svgs.carretUp,
            width: constraints.maxWidth * 0.05,
          ),
        ),
      ),
    );
  }
}
