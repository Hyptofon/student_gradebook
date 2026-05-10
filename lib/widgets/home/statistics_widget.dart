import 'package:flutter/material.dart';

import '../../constants/app_dimensions.dart';
import '../../models/grade_status.dart';
import '../../utils/theme_helpers.dart';

class StatisticsWidget extends StatelessWidget {
  final Map<GradeStatus, int> statistics;

  const StatisticsWidget({super.key, required this.statistics});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppDimensions.statisticsPadding,
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: AppDimensions.spacing16,
        runSpacing: AppDimensions.spacing16,
        children: GradeStatus.gradedValues
            .map(
              (status) =>
                  _StatCard(status: status, value: statistics[status] ?? 0),
            )
            .toList(growable: false),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final GradeStatus status;
  final int value;

  const _StatCard({required this.status, required this.value});

  IconData get _icon => switch (status) {
    GradeStatus.a => Icons.sentiment_very_satisfied,
    GradeStatus.b => Icons.sentiment_satisfied,
    GradeStatus.c => Icons.sentiment_satisfied,
    GradeStatus.d => Icons.sentiment_neutral,
    GradeStatus.e => Icons.sentiment_neutral,
    GradeStatus.fx => Icons.sentiment_dissatisfied,
    GradeStatus.f => Icons.sentiment_very_dissatisfied,
    GradeStatus.noData => Icons.inbox,
  };

  @override
  Widget build(BuildContext context) {
    final color = ThemeHelpers.getStatusColor(context, status);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(
          status.shortLabel,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          value.toString(),
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        Icon(_icon, color: color),
      ],
    );
  }
}
