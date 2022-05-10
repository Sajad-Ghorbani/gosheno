import 'package:flutter/material.dart';

import '../theme/app_color.dart';

class ScoresWidget extends StatelessWidget {
  const ScoresWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        children: const [
          Icon(
            Icons.star,
            color: kAmberColor,
            size: 20,
          ),
          Icon(
            Icons.star,
            color: kAmberColor,
            size: 20,
          ),
          Icon(
            Icons.star,
            color: kAmberColor,
            size: 20,
          ),
          Icon(
            Icons.star_rounded,
            color: kAmberColor,
            size: 20,
          ),
          Icon(
            Icons.star_half_rounded,
            color: kAmberColor,
            size: 20,
          ),
        ],
      ),
    );
  }
}
