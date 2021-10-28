import 'package:flutter/material.dart';
import 'package:tesla_app/presentation/core/constants.dart';

class TyreStatus extends StatelessWidget {
  final double psi;
  final int temperature;
  final bool isLowPressure;
  final bool isInverted;

  const TyreStatus({
    Key? key,
    required this.psi,
    required this.temperature,
    this.isLowPressure = false,
    this.isInverted = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: isLowPressure
            ? kSecondaryColor.withOpacity(0.1)
            : Colors.grey.withOpacity(0.2),
        border: Border.all(
          width: 2,
          color: isLowPressure ? kSecondaryColor : kPrimaryColor,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: isInverted
            ? buildStatus(context).reversed.toList()
            : buildStatus(context),
      ),
    );
  }

  List<Widget> buildStatus(BuildContext context) {
    return [
      Text(
        '${psi}psi',
        style: Theme.of(context).textTheme.headline5,
      ),
      const SizedBox(height: kDefaultPadding / 2),
      Text('$temperature°C'),
      const Spacer(),
      if (isLowPressure)
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Low'.toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.white),
              ),
              TextSpan(
                text: '\nPressure'.toUpperCase(),
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
    ];
  }
}
