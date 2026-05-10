import 'package:flutter/material.dart';
import 'package:student_gradebook/models/grade_type.dart';

import '../../constants/app_dimensions.dart';
import '../../models/grade.dart';
import '../../services/date_formatter.dart';
import '../../utils/theme_helpers.dart';

class GradeListItem extends StatelessWidget {
  final Grade grade;
  final VoidCallback onDismissed;

  const GradeListItem({
    super.key,
    required this.grade,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Dismissible(
      key: ValueKey(grade.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismissed(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: AppDimensions.deleteBackgroundPadding,
        color: colorScheme.error,
        child: Icon(Icons.delete, color: colorScheme.onError),
      ),
      child: _GradeCard(grade: grade),
    );
  }
}

class _GradeCard extends StatelessWidget {
  final Grade grade;

  const _GradeCard({required this.grade});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: ListTile(
        leading: Icon(grade.type.icon),
        title: Text(grade.description),
        subtitle: Text(DateFormatter.dayMonthYear(grade.date)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              grade.scoreText,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              grade.status.label,
              style: textTheme.labelSmall?.copyWith(
                color: ThemeHelpers.getStatusColor(context, grade.status),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
