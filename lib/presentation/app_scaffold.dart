import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:movieverse/presentation/common/app_scroll_behavior.dart';
import 'package:movieverse/presentation/styles/app_theme.dart';

import '../main.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.child});
  final Widget child;
  static AppStyle get style => _style;
  static AppStyle _style = AppStyle();

  @override
  Widget build(BuildContext context) {
    // Listen to the device size, and update AppStyle when it changes
    MediaQuery.of(context);
    appLogic.handleAppSizeChanged(context);
    // Set default timing for animations in the app
    Animate.defaultDuration = _style.times.fast;
    // Create a style object that will be passed down the widget tree
    _style = AppStyle(screenSize: context.size);
    return KeyedSubtree(
      key: ValueKey($styles.scale),
      child: Theme(
        data: $styles.theme.toThemeData(),
        // Provide a default texts style to allow Hero's to render text properly
        child: DefaultTextStyle(
          style: $styles.text.titleMedium,
          // Use a custom scroll behavior across entire app
          child: ScrollConfiguration(
            behavior: AppScrollBehavior(),
            child: child,
          ),
        ),
      ),
    );
  }
}
