import 'package:flutter/material.dart';

class FastColumn extends Column {
  const FastColumn(List<Widget> children) : super(key: null, children: children);

  const FastColumn._({
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

  FastColumn copyWith({
    double? spacing,
    Key? key,
    MainAxisAlignment? mainAxisAlignment,
    MainAxisSize? mainAxisSize,
    CrossAxisAlignment? crossAxisAlignment,
    TextDirection? textDirection,
    VerticalDirection? verticalDirection,
    TextBaseline? textBaseline,
  }) =>
      FastColumn._(
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

  FastColumn setSpacing(double spacing) => copyWith(spacing: spacing);

  FastColumn setMainAxisAlignment(MainAxisAlignment mainAxisAlignment) =>
      copyWith(mainAxisAlignment: mainAxisAlignment);

  FastColumn setMainAxisSize(MainAxisSize mainAxisSize) => copyWith(mainAxisSize: mainAxisSize);

  FastColumn setCrossAxisAlignment(CrossAxisAlignment crossAxisAlignment) =>
      copyWith(crossAxisAlignment: crossAxisAlignment);

  FastColumn setTextDirection(TextDirection textDirection) => copyWith(textDirection: textDirection);

  FastColumn setVerticalDirection(VerticalDirection verticalDirection) =>
      copyWith(verticalDirection: verticalDirection);

  FastColumn setTextBaseline(TextBaseline textBaseline) => copyWith(textBaseline: textBaseline);

  FastColumn setKey(Key key) => copyWith(key: key);
}
