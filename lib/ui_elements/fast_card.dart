import 'package:flutter/material.dart';

class FastCard extends StatelessWidget {
  final Color? color;
  final BoxShadow? shadow;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxConstraints? boxConstraints;
  final Clip? clip;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;
  final Widget? child;

  const FastCard({
    super.key,
    this.color,
    this.shadow,
    this.borderRadius,
    this.padding,
    this.margin,
    this.boxConstraints,
    this.clip,
    this.transform,
    this.transformAlignment,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      constraints: boxConstraints,
      clipBehavior: clip ?? Clip.none,
      transform: transform,
      transformAlignment: transformAlignment,
      decoration: ShapeDecoration(
        color: color ?? Theme.of(context).cardColor,
        shape: RoundedSuperellipseBorder(
            borderRadius: borderRadius != null ? BorderRadius.circular(borderRadius!) : BorderRadius.zero),
        shadows: shadow != null ? [shadow!] : null,
      ),
      child: child,
    );
  }
}

class TestWidget extends Container {
  TestWidget(Widget? child) : super(key: null, child: child);

  @override
  Widget build(BuildContext context) {
    return Container(child: child);
  }

  Container copyWith({
    Key? key,
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
    AlignmentGeometry? transformAlignment,
    Clip? clipBehavior,
    Widget? child,
  }) {
    return Container(
      key: key ?? super.key,
      alignment: alignment ?? super.alignment,
      padding: padding ?? super.padding,
      color: color ?? super.color,
      decoration: decoration ?? super.decoration,
      foregroundDecoration: foregroundDecoration ?? super.foregroundDecoration,
      width: width ?? super.constraints?.maxWidth,
      height: height ?? super.constraints?.maxHeight,
      constraints: constraints ?? super.constraints,
      margin: margin ?? super.margin,
      transform: transform ?? super.transform,
      transformAlignment: transformAlignment ?? super.transformAlignment,
      clipBehavior: clipBehavior ?? super.clipBehavior,
      child: child ?? super.child,
    );
  }

  Container setPadding(EdgeInsetsGeometry padding) => copyWith(padding: padding);

  Container setMargin(EdgeInsetsGeometry margin) => copyWith(margin: margin);

  Container setTransform(Matrix4 transform) => copyWith(transform: transform);

  Container setTransformAlignment(AlignmentGeometry transformAlignment) =>
      copyWith(transformAlignment: transformAlignment);

  Container setClip(Clip clip) => copyWith(clipBehavior: clip);

  Container setColor(Color color) => copyWith(color: color);

  Container setDecoration(Decoration decoration) => copyWith(decoration: decoration);

  Container setForegroundDecoration(Decoration foregroundDecoration) =>
      copyWith(foregroundDecoration: foregroundDecoration);

  Container setSize(double? width, double? height) => copyWith(width: width, height: height);

  Container setConstraints(BoxConstraints constraints) => copyWith(constraints: constraints);

  Container setAlignment(AlignmentGeometry alignment) => copyWith(alignment: alignment);

  Container setKey(Key key) => copyWith(key: key);
}
