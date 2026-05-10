import 'package:flutter/material.dart';

import '../constants/app_dimensions.dart';
import '../constants/app_strings.dart';

class EmptyStateWidget extends StatelessWidget {
  final String message;
  final String subMessage;

  const EmptyStateWidget({
    super.key,
    this.message = AppStrings.noDataYet,
    this.subMessage = AppStrings.tapPlusToAdd,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox,
            size: AppDimensions.emptyStateIconSize,
            color: colorScheme.outlineVariant,
          ),
          const SizedBox(height: AppDimensions.spacing16),
          Text(
            message,
            style: textTheme.titleLarge?.copyWith(color: colorScheme.outline),
          ),
          const SizedBox(height: AppDimensions.spacing8),
          Text(
            subMessage,
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.outline),
          ),
        ],
      ),
    );
  }
}
