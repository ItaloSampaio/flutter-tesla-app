import 'package:flutter/material.dart';
import 'package:tesla_app/presentation/core/constants.dart';

import 'widgets/widgets.dart';

class TyreScreen extends StatelessWidget {
  final List<Animation<double>> _animations;

  final AnimationController animationController;

  TyreScreen({
    Key? key,
    required this.animationController,
  })  : _animations = List.generate(
          4,
          (index) => Tween<double>(
            begin: 0,
            end: 1,
          ).animate(
            CurvedAnimation(
              parent: animationController,
              curve: Interval(index * 0.25, (index + 1) * 0.25),
            ),
          ),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, bhild) {
        return animationController.value == 0
            ? const SizedBox()
            : Scaffold(
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  child: SizedBox.expand(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding,
                        horizontal: kDefaultPadding,
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Transform.scale(
                                    scale: _animations[0].value,
                                    child: const TyreStatus(
                                      psi: 23.6,
                                      temperature: 56,
                                      isLowPressure: true,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: kDefaultPadding),
                                Expanded(
                                  child: Transform.scale(
                                    scale: _animations[1].value,
                                    child: const TyreStatus(
                                      psi: 35.0,
                                      temperature: 41,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: kDefaultPadding),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Transform.scale(
                                    scale: _animations[2].value,
                                    child: const TyreStatus(
                                      psi: 34.6,
                                      temperature: 41,
                                      isInverted: true,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: kDefaultPadding),
                                Expanded(
                                  child: Transform.scale(
                                    scale: _animations[3].value,
                                    child: const TyreStatus(
                                      psi: 34.8,
                                      temperature: 42,
                                      isInverted: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
