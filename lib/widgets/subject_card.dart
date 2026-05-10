import 'package:flutter/material.dart';

import '../constants/app_dimensions.dart';
import '../constants/app_strings.dart';
import '../models/subject.dart';
import '../utils/theme_helpers.dart';

class SubjectCard extends StatelessWidget {
  final Subject subject;
  final VoidCallback onTap;

  const SubjectCard({super.key, required this.subject, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing16,
        vertical: AppDimensions.spacing8,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppDimensions.cardBorderRadius,
        child: Padding(
          padding: AppDimensions.cardPadding,
          child: Row(
            children: [
              Text(subject.icon, style: textTheme.headlineMedium),
              const SizedBox(width: AppDimensions.spacing16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subject.name,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spacing4),
                    Text(
                      AppStrings.gradesCount(subject.grades.length),
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    subject.average.toStringAsFixed(1),
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: List.generate(5, (index) {
                      final isActive = index < subject.stars;
                      return Icon(
                        isActive ? Icons.star : Icons.star_border,
                        size: AppDimensions.smallIconSize,
                        color: ThemeHelpers.getStarColor(
                          context,
                          isActive: isActive,
                        ),
                      );
                    }, growable: false),
                  ),
                  Text(
                    subject.status.label,
                    style: textTheme.bodySmall?.copyWith(
                      color: ThemeHelpers.getStatusColor(
                        context,
                        subject.status,
                      ),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
