import 'package:flutter/material.dart';

import '../models/grade_status.dart';

class ThemeHelpers {
  const ThemeHelpers._();

  static Color getStatusColor(BuildContext context, GradeStatus status) {
    final colorScheme = Theme.of(context).colorScheme;
    return switch (status) {
      GradeStatus.a => colorScheme.tertiary,
      GradeStatus.b => colorScheme.primary,
      GradeStatus.c => colorScheme.primary,
      GradeStatus.d => colorScheme.secondary,
      GradeStatus.e => colorScheme.secondary,
      GradeStatus.fx => colorScheme.error,
      GradeStatus.f => colorScheme.error,
      _ => colorScheme.onSurfaceVariant,
    };
  }

  static Color getStarColor(BuildContext context, {required bool isActive}) {
    final colorScheme = Theme.of(context).colorScheme;
    return isActive ? colorScheme.tertiary : colorScheme.outlineVariant;
  }
}
