import 'package:flutter/material.dart';

class CircleButtonWidget extends StatelessWidget {
  const CircleButtonWidget({
    Key? key,
    required this.color,
    required this.onTap,
    required this.height,
    required this.width,
    required this.child,
  }) : super(key: key);
  final Color color;
  final VoidCallback onTap;
  final double height;
  final double width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(50)),
      color: color,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        onTap: onTap,
        child: Container(
          height: height,
          width: width,
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}
