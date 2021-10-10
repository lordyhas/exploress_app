import 'package:flutter/material.dart';

class AdaptedContainer extends StatelessWidget {
  AdaptedContainer(
      {Key? key,
      AlignmentGeometry? alignment,
      EdgeInsetsGeometry? padding,
      Color? color,
      Decoration? decoration,
      Decoration? foregroundDecoration,
      double? width,
      double? height,
      BoxConstraints? constraints,
      EdgeInsetsGeometry? margin,
      Matrix4? transform,
        Widget? child,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ConstrainedBox(
        constraints: BoxConstraints(),
        child: null,
      ),
    );
  }
}
