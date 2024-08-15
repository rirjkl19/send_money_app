import 'package:flutter/material.dart';

mixin AppDialogHelper on Widget {
  void showAsModalBottomSheet(BuildContext context, {bool isDismissible = true}) {
    showModalBottomSheet(
      isDismissible: isDismissible,
      context: context,
      builder: (context) => this,
    );
  }
}
