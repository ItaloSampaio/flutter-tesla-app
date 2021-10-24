import 'package:flutter/material.dart';
import 'package:tesla_app/presentation/core/constants.dart';

class TemperatureStatus extends StatelessWidget {
  const TemperatureStatus({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Current Temperature'.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: kDefaultPadding),
        Row(
          children: [
            DefaultTextStyle(
              style: const TextStyle(fontWeight: FontWeight.w500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Inside'.toUpperCase()),
                  const Text(
                    '20°C',
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              ),
            ),
            const SizedBox(width: kDefaultPadding),
            DefaultTextStyle(
              style: TextStyle(
                color: Colors.grey[500]?.withOpacity(0.7),
                fontWeight: FontWeight.w500,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Outside'.toUpperCase()),
                  const Text(
                    '35°C',
                    style: TextStyle(fontSize: 22),
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
