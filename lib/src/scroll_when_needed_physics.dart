import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ScrollWhenNeededPhysics extends ScrollPhysics {
  final TargetPlatform targetPlatform;

  const ScrollWhenNeededPhysics({this.targetPlatform, ScrollPhysics parent})
      : super(parent: parent);

  @override
  ScrollWhenNeededPhysics applyTo(ScrollPhysics ancestor) {
    return ScrollWhenNeededPhysics(
      targetPlatform: targetPlatform,
      parent: buildParent(ancestor),
    );
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    assert(() {
      if (value == position.pixels) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary(
              '$runtimeType.applyBoundaryConditions() was called redundantly.'),
          ErrorDescription(
              'The proposed new position, $value, is exactly equal to the current position of the '
              'given ${position.runtimeType}, ${position.pixels}.\n'
              'The applyBoundaryConditions method should only be called when the value is '
              'going to actually change the pixels, otherwise it is redundant.'),
          DiagnosticsProperty<ScrollPhysics>(
              'The physics object in question was', this,
              style: DiagnosticsTreeStyle.errorProperty),
          DiagnosticsProperty<ScrollMetrics>(
              'The position object in question was', position,
              style: DiagnosticsTreeStyle.errorProperty)
        ]);
      }
      return true;
    }());
    if (value < position.pixels &&
        position.pixels <= position.minScrollExtent) {
      if (position.maxScrollExtent != 0 && value < position.maxScrollExtent) {
        if (targetPlatform == TargetPlatform.iOS) {
          return super.applyBoundaryConditions(position, value);
        }
      }
      return value - position.pixels;
    }
    if (position.maxScrollExtent <= position.pixels &&
        position.pixels < value) {
      if (position.maxScrollExtent != 0 && value >= position.maxScrollExtent) {
        if (targetPlatform == TargetPlatform.iOS) {
          return super.applyBoundaryConditions(position, value);
        }
      }
      return value - position.pixels;
    }
    if (value < position.minScrollExtent &&
        position.minScrollExtent < position.pixels) {
      return value - position.minScrollExtent;
    }
    if (position.pixels < position.maxScrollExtent &&
        position.maxScrollExtent < value) {
      return value - position.maxScrollExtent;
    }
    return 0.0;
  }

  @override
  bool shouldAcceptUserOffset(ScrollMetrics position) => true;
}
