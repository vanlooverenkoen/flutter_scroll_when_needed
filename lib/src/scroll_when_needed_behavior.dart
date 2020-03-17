import 'package:flutter/material.dart';

class ScrollWhenNeededBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    final theme = Theme.of(context);
    final platform = theme.platform;
    final accentColor = theme.accentColor;
    return Theme(
      data: theme.copyWith(platform: TargetPlatform.iOS),
      child: GlowingOverscrollIndicator(
        child: Theme(
          data: theme.copyWith(platform: platform),
          child: child,
        ),
        axisDirection: axisDirection,
        color: accentColor,
        notificationPredicate: (results) =>
            results.metrics.maxScrollExtent != 0,
      ),
    );
  }
}
