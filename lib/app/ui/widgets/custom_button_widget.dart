import 'package:flutter/material.dart';

import '../theme/app_color.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    Key? key,
    required this.child,
    required this.onTap,
    required this.color,
    this.width,
  }) : super(key: key);
  final VoidCallback onTap;
  final Color color;
  final Widget child;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: color,
          boxShadow: [
            BoxShadow(
              color: kBlackColor.withOpacity(0.5),
              blurRadius: 6,
              offset: const Offset(-3, 4),
            ),
          ],
        ),
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: child,
      ),
    );
  }
}
