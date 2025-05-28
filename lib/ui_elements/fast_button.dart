import 'package:fast/extensions/color_extensions.dart';
import 'package:flutter/material.dart';

class FastButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final dynamic child;
  final Color? color;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  const FastButton(
    this.child, {
    super.key,
    text,
    this.onPressed,
    this.color,
    this.backgroundColor,
    this.padding,
  });

  @override
  State<FastButton> createState() => _FastButtonState();
}

class _FastButtonState extends State<FastButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) => setState(() => isPressed = false),
      onTapCancel: () => setState(() => isPressed = false),
      child: Padding(
        padding: widget.padding ?? const EdgeInsets.all(8),
        child: switch (widget.child) {
          String() => _buildStringButton(),
          Text() => _buildTextButton(),
          Icon() => _buildIconButton(),
          Widget() => widget.child,
          _ => SizedBox.shrink(),
        },
      ),
    );
  }
}

extension on _FastButtonState {
  Widget _buildStringButton() {
    final color = widget.color ?? Colors.blue;

    return Text(
      widget.child as String,
      style: TextStyle(
        color: isPressed ? color.darken() : color,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );
  }

  Widget _buildTextButton() {
    final color = widget.color ?? Colors.blue;

    return Text(
      (widget.child as Text).data ?? '',
      style: (widget.child as Text).style?.copyWith(color: isPressed ? color.darken() : color) ??
          TextStyle(
            color: isPressed ? color.darken() : color,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
      textAlign: (widget.child as Text).textAlign,
      softWrap: (widget.child as Text).softWrap,
      overflow: (widget.child as Text).overflow,
      textDirection: (widget.child as Text).textDirection,
      locale: (widget.child as Text).locale,
      strutStyle: (widget.child as Text).strutStyle,
      textWidthBasis: (widget.child as Text).textWidthBasis,
      maxLines: (widget.child as Text).maxLines,
      semanticsLabel: (widget.child as Text).semanticsLabel,
      textHeightBehavior: (widget.child as Text).textHeightBehavior,
    );
  }

  Widget _buildIconButton() {
    final color = widget.color ?? (widget.child as Icon).color;

    return Icon(
      (widget.child as Icon).icon,
      color: isPressed ? color?.darken() : color,
      size: (widget.child as Icon).size,
      semanticLabel: (widget.child as Icon).semanticLabel,
      shadows: (widget.child as Icon).shadows,
      textDirection: (widget.child as Icon).textDirection,
    );
  }
}
