import 'package:flutter/material.dart';

/// Base style for a text input
class BaseTextInputStyle {
  BaseTextInputStyle(this.theme, this.textTheme);
  final ColorScheme theme;
  final TextTheme textTheme;

  /// The style of the text in the input field
  late final InputDecoration inputDecoration = InputDecoration(
    hintStyle: textTheme.displaySmall,
    labelStyle: textTheme.displaySmall,
    fillColor: theme.primary,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
  );
}
