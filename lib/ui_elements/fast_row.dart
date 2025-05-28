import 'package:flutter/material.dart';

class FastRow extends Row {
  const FastRow(List<Widget> children) : super(key: null, children: children);

  const FastRow._({
    required super.spacing,
    super.key,
    required super.mainAxisAlignment,
    required super.mainAxisSize,
    required super.crossAxisAlignment,
    super.textDirection,
    required super.verticalDirection,
    super.textBaseline,
    required super.children,
  });

  FastRow copyWith({
    double? spacing,
    Key? key,
    MainAxisAlignment? mainAxisAlignment,
    MainAxisSize? mainAxisSize,
    CrossAxisAlignment? crossAxisAlignment,
    TextDirection? textDirection,
    VerticalDirection? verticalDirection,
    TextBaseline? textBaseline,
  }) =>
      FastRow._(
        key: key,
        spacing: spacing ?? super.spacing,
        mainAxisAlignment: mainAxisAlignment ?? super.mainAxisAlignment,
        mainAxisSize: mainAxisSize ?? super.mainAxisSize,
        crossAxisAlignment: crossAxisAlignment ?? super.crossAxisAlignment,
        textDirection: textDirection ?? super.textDirection,
        verticalDirection: verticalDirection ?? super.verticalDirection,
        textBaseline: textBaseline ?? super.textBaseline,
        children: children,
      );

  FastRow setSpacing(double spacing) => copyWith(spacing: spacing);

  FastRow setMainAxisAlignment(MainAxisAlignment mainAxisAlignment) => copyWith(mainAxisAlignment: mainAxisAlignment);

  FastRow setMainAxisSize(MainAxisSize mainAxisSize) => copyWith(mainAxisSize: mainAxisSize);

  FastRow setCrossAxisAlignment(CrossAxisAlignment crossAxisAlignment) =>
      copyWith(crossAxisAlignment: crossAxisAlignment);

  FastRow setTextDirection(TextDirection textDirection) => copyWith(textDirection: textDirection);

  FastRow setVerticalDirection(VerticalDirection verticalDirection) => copyWith(verticalDirection: verticalDirection);

  FastRow setTextBaseline(TextBaseline textBaseline) => copyWith(textBaseline: textBaseline);

  FastRow setKey(Key key) => copyWith(key: key);
}
