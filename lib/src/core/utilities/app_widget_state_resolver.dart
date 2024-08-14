import 'package:flutter/material.dart';

final class AppWidgetStateResolver {
  const AppWidgetStateResolver._();

  /// A custom widget color resolver that returns a color based on the money send app color theme
  static Color? appColorResolver(Set<WidgetState> state) {
    if (state.contains(WidgetState.disabled)) {
      return Colors.grey;
    } else if (state.contains(WidgetState.pressed)) {
      return Colors.blue[900];
    } else if (state.contains(WidgetState.hovered)) {
      return Colors.blue[200];
    } else {
      return Colors.blue;
    }
  }
}
