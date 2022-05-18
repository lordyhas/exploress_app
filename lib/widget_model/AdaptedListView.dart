import 'package:utils_component/utils_component.dart';

import 'BooleanBuilder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdaptedScrollView extends StatelessWidget {
  final Key? key;
  final Axis scrollDirection;
  final Size? size;
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final List<Widget> children;

  const AdaptedScrollView({
      Key? key,
      this.size,
      this.scrollDirection = Axis.vertical,
      this.controller,
      this.physics,
      this.padding,
      this.children = const <Widget>[],
  }): this.key = key;

  @override
  Widget build(BuildContext context) {
    bool check = kIsWeb || (this.size == null)
        ? false : this.size!.width > 420;

    return Container(
      child: SingleChildScrollView(
        key: this.key,
        scrollDirection: this.scrollDirection,
        controller: this.controller,
        padding: this.padding,
        physics: this.physics,
        child: BooleanBuilder(
          check: check,
          ifTrue: Wrap( children: children,) ,
          ifFalse: Column(children: children,),
        ),
      ),
    );
  }
}
