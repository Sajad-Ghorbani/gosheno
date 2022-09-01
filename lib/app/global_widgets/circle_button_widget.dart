import 'package:flutter/material.dart';

class CircleButtonWidget extends StatelessWidget {
  const CircleButtonWidget({
    Key? key,
    required this.color,
    required this.onTap,
    required this.height,
    this.width,
    required this.child,
  }) : super(key: key);
  final Color color;
  final VoidCallback onTap;
  final double height;
  final double? width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      color: color,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        onTap: onTap,
        child: Container(
          height: height,
          width: width,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}
