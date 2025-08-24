import 'package:flutter/material.dart';

class ModalBottomSheetPage<T> extends Page<T> {
  final WidgetBuilder builder;
  final bool isScrollControlled;
  final bool isDismissible;
  final bool enableDrag;
  final bool useSafeArea;
  final Color? backgroundColor;
  final double? elevation;
  final ShapeBorder? shape;
  final Clip? clipBehavior;
  final BoxConstraints? constraints;
  final Color? barrierColor;
  final String? barrierLabel;
  final AnimationStyle? sheetAnimationStyle;
  final Offset? anchorPoint;
  final AnimationController? transitionAnimationController;

  const ModalBottomSheetPage({
    required this.builder,
    this.isScrollControlled = false,
    this.isDismissible = true,
    this.enableDrag = true,
    this.useSafeArea = false,
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.clipBehavior,
    this.constraints,
    this.barrierColor,
    this.barrierLabel,
    this.sheetAnimationStyle,
    this.anchorPoint,
    this.transitionAnimationController,
    super.key,
  });

  @override
  Route<T> createRoute(BuildContext context) {
    return ModalBottomSheetRoute<T>(
      builder: builder,
      settings: this,
      backgroundColor: backgroundColor,
      barrierLabel: barrierLabel,
      modalBarrierColor: barrierColor,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
      constraints: constraints,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      useSafeArea: useSafeArea,
      anchorPoint: anchorPoint,
      sheetAnimationStyle: sheetAnimationStyle,
      transitionAnimationController: transitionAnimationController,
    );
  }
}
