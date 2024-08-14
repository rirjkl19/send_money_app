import 'package:flutter/material.dart';

extension AppWidgetStateProperty<T> on WidgetStateProperty<T> {
  /// A custom resolver widget color resolver that returns a color based on the money send app color theme
  Color? Function(Set<WidgetState>) appResolverWith(Set<WidgetState> state) {
    return (state) {
      if (state.contains(WidgetState.disabled)) {
        return Colors.grey;
      } else if (state.contains(WidgetState.pressed)) {
        return Colors.blue[900];
      } else if (state.contains(WidgetState.hovered)) {
        return Colors.blue[200];
      } else {
        return Colors.blue;
      }
    };
  }
}
