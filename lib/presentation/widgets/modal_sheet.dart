import 'package:diego_yangua_movies/core/utils/colors.dart';
import 'package:flutter/material.dart';

/// A custom modal sheet widget that can be used to display a bottom sheet with a
/// transparent background. It takes a child widget as input and wraps it in a
/// decorated box to apply the desired styling and padding.
class CustomModalSheet<T> extends StatelessWidget {
  const CustomModalSheet({super.key, required this.child});

  /// The child widget to be displayed inside the modal sheet.
  final Widget child;

  /// Shows the custom modal sheet with the provided child widget.
  ///
  /// The modal sheet will be displayed as a bottom sheet with a transparent
  /// background and scroll control enabled. The child widget will be wrapped in
  /// a decorated box to apply the desired styling and padding.
  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
  }) async =>
      await showModalBottomSheet<T>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => CustomModalSheet(child: child),
      );

  /// Builds the widget tree for the custom modal sheet.
  ///
  /// The decorated box is used to apply the desired styling and padding to the
  /// child widget. The child widget is wrapped in a safe area to ensure that it
  /// is not obscured by the system UI.
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Decorations.kSecondaryColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: SafeArea(child: child),
      ),
    );
  }
}
