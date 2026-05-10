import 'package:flutter/material.dart';

import '../../constants/app_dimensions.dart';
import '../../constants/app_strings.dart';
import '../../models/subject.dart';
import '../../utils/theme_helpers.dart';

class SubjectStatsWidget extends StatelessWidget {
  final Subject subject;

  const SubjectStatsWidget({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: AppDimensions.subjectStatsPadding,
      width: double.infinity,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Column(
        children: [
          Text(subject.icon, style: textTheme.displaySmall),
          Text(
            AppStrings.averageValue(subject.average),
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              final isActive = index < subject.stars;
              return Icon(
                isActive ? Icons.star : Icons.star_border,
                size: AppDimensions.largeIconSize,
                color: ThemeHelpers.getStarColor(context, isActive: isActive),
              );
            }, growable: false),
          ),
          Text(
            subject.status.label,
            style: textTheme.titleMedium?.copyWith(
              color: ThemeHelpers.getStatusColor(context, subject.status),
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(AppStrings.gradesCount(subject.grades.length)),
        ],
      ),
    );
  }
}
