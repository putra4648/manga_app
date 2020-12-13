import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/widgets.dart';

class CustomStyleHook extends StyleHook {
  @override
  double get activeIconMargin => 10;

  @override
  double get activeIconSize => 40;

  @override
  double get iconSize => 20;

  @override
  TextStyle textStyle(Color color) {
    return TextStyle(
      color: color,
      fontSize: 14,
    );
  }
}
