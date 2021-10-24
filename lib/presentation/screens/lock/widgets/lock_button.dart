import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tesla_app/presentation/core/asset_paths.dart';
import 'package:tesla_app/presentation/core/constants.dart';

class LockButton extends StatelessWidget {
  final bool isLocked;
  final VoidCallback? onPress;

  const LockButton({
    Key? key,
    required this.isLocked,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: AnimatedSwitcher(
        duration: kDefaultDuration,
        switchInCurve: Curves.easeInOutBack,
        transitionBuilder: (child, animation) =>
            ScaleTransition(scale: animation, child: child),
        child: isLocked
            ? SvgPicture.asset(
                AssetPaths.svgs.lockRounded,
                key: const ValueKey('lock'),
              )
            : SvgPicture.asset(
                AssetPaths.svgs.unlockRounded,
                key: const ValueKey('unlock'),
              ),
      ),
    );
  }
}
