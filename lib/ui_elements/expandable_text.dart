import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;
  final TextStyle? style;
  final String? showLessText;
  final String? showMoreText;
  final Duration animationDuration;

  const ExpandableText({
    super.key,
    required this.text,
    this.maxLines = 3,
    this.style,
    this.showLessText,
    this.showMoreText,
    this.animationDuration = const Duration(milliseconds: 800),
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedSize(
          duration: widget.animationDuration,
          curve: Curves.fastEaseInToSlowEaseOut,
          child: Text(
            widget.text,
            style: widget.style,
            maxLines: _expanded ? null : widget.maxLines,
            overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
          ),
        ),
        AnimatedCrossFade(
          firstChild: GestureDetector(
            onTap: () {
              setState(() {
                _expanded = true;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                widget.showMoreText ?? 'Show more',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          secondChild: GestureDetector(
            onTap: () {
              setState(() {
                _expanded = false;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                widget.showLessText ?? 'Show less',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          crossFadeState: _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: widget.animationDuration,
        ),
      ],
    );
  }
}
