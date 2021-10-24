import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tesla_app/presentation/core/assets.dart';
import 'package:tesla_app/presentation/core/constants.dart';

import '../air_conditioning_mode.dart';

class AirConditioningModeRadioGroup extends StatelessWidget {
  final BoxConstraints constraints;
  final AirConditioningMode currentMode;
  final void Function(AirConditioningMode) onChange;

  const AirConditioningModeRadioGroup({
    Key? key,
    required this.constraints,
    required this.currentMode,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AirConditioningModeRadioButton(
              constraints: constraints,
              isSelected: currentMode == AirConditioningMode.cool,
              iconSource: Assets.svgs.coolShape,
              label: 'Cool',
              color: kPrimaryColor,
              onPress: () => onChange(AirConditioningMode.cool),
            ),
            const SizedBox(
              width: kDefaultPadding,
            ),
            _AirConditioningModeRadioButton(
              constraints: constraints,
              isSelected: currentMode == AirConditioningMode.heat,
              iconSource: Assets.svgs.heatShape,
              label: 'Heat',
              color: kSecondaryColor,
              onPress: () => onChange(AirConditioningMode.heat),
            ),
          ],
        ),
      ],
    );
  }
}

class _AirConditioningModeRadioButton extends StatefulWidget {
  final BoxConstraints constraints;
  final bool isSelected;
  final String iconSource;
  final String label;
  final Color color;
  final VoidCallback onPress;

  const _AirConditioningModeRadioButton({
    Key? key,
    required this.constraints,
    required this.isSelected,
    required this.iconSource,
    required this.label,
    required this.color,
    required this.onPress,
  }) : super(key: key);

  @override
  State<_AirConditioningModeRadioButton> createState() =>
      _AirConditioningModeRadioButtonState();
}

class _AirConditioningModeRadioButtonState
    extends State<_AirConditioningModeRadioButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _iconWidth;
  late final Animation<double> _opacity;
  late final Animation<Color?> _color;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _iconWidth = Tween<double>(
      begin: widget.constraints.maxWidth * 0.12,
      end: widget.constraints.maxWidth * 0.17,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutBack,
    ));

    _opacity = Tween<double>(
      begin: 0.6,
      end: 1,
    ).animate(_animationController);

    _color = ColorTween(
      begin: Colors.grey,
      end: widget.color,
    ).animate(_animationController);

    if (widget.isSelected) {
      _animationController.value = 1;
    }

    super.initState();
  }

  @override
  void didUpdateWidget(covariant _AirConditioningModeRadioButton oldWidget) {
    widget.isSelected
        ? _animationController.forward()
        : _animationController.reverse();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: widget.onPress,
          child: Opacity(
            opacity: _opacity.value,
            child: Column(
              children: [
                SvgPicture.asset(
                  widget.iconSource,
                  width: _iconWidth.value,
                  color: _color.value,
                ),
                const SizedBox(height: kDefaultPadding / 2),
                Text(
                  widget.label.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _color.value,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
