import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tesla_app/presentation/core/assets.dart';
import 'package:tesla_app/presentation/core/constants.dart';

final List<String> _iconSources = [
  Assets.svgs.lock,
  Assets.svgs.charge,
  Assets.svgs.temp,
  Assets.svgs.tyre,
];

class BottomTabBar extends StatelessWidget {
  final int selectedTabIndex;
  final ValueChanged<int> onTap;

  const BottomTabBar({
    Key? key,
    required this.selectedTabIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedTabIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      onTap: onTap,
      items: List.generate(
        _iconSources.length,
        (index) => BottomNavigationBarItem(
          icon: SvgPicture.asset(
            _iconSources[index],
            color: selectedTabIndex == index ? kPrimaryColor : Colors.white54,
          ),
          label: '',
        ),
      ),
    );
  }
}
