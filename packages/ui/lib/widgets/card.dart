import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  const MyCard({super.key, this.borderRadius, this.child});

  final Widget? child;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: borderRadius ?? BorderRadius.circular(16),
      color: Theme.of(context).cardColor,
      child: child,
    );
  }
}
