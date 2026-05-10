import 'package:flutter/material.dart';

import '../../constants/app_dimensions.dart';
import '../../constants/app_strings.dart';
import '../../models/grade_status.dart';
import '../../utils/theme_helpers.dart';

class OverallAverageWidget extends StatelessWidget {
  final double average;
  final GradeStatus status;
  final int stars;

  const OverallAverageWidget({
    super.key,
    required this.average,
    required this.status,
    required this.stars,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: AppDimensions.summaryPadding,
      color: colorScheme.surfaceContainerHighest,
      width: double.infinity,
      child: Column(
        children: [
          Text(AppStrings.overallAverage, style: textTheme.titleMedium),
          Text(
            average.toStringAsFixed(1),
            style: textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              final isActive = index < stars;
              return Icon(
                isActive ? Icons.star : Icons.star_border,
                size: AppDimensions.mediumIconSize,
                color: ThemeHelpers.getStarColor(context, isActive: isActive),
              );
            }, growable: false),
          ),
          Text(
            status.label,
            style: textTheme.titleMedium?.copyWith(
              color: ThemeHelpers.getStatusColor(context, status),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
