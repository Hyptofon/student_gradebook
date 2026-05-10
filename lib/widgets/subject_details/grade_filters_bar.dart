import 'package:flutter/material.dart';

import '../../constants/app_dimensions.dart';
import '../../constants/filter_labels.dart';
import '../../models/grade_filters.dart';

class GradeFiltersBar extends StatelessWidget {
  final GradeSortOption sortOption;
  final StatusFilter statusFilter;
  final TypeFilter typeFilter;
  final ValueChanged<GradeSortOption> onSortChanged;
  final ValueChanged<StatusFilter> onStatusChanged;
  final ValueChanged<TypeFilter> onTypeChanged;

  const GradeFiltersBar({
    super.key,
    required this.sortOption,
    required this.statusFilter,
    required this.typeFilter,
    required this.onSortChanged,
    required this.onStatusChanged,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: AppDimensions.screenHorizontalPadding,
      child: Row(
        children: [
          DropdownButton<GradeSortOption>(
            value: sortOption,
            underline: const SizedBox(),
            items: GradeSortOption.values
                .map(
                  (option) => DropdownMenuItem(
                    value: option,
                    child: Text(option.label),
                  ),
                )
                .toList(growable: false),
            onChanged: (value) {
              if (value == null) {
                return;
              }
              onSortChanged(value);
            },
          ),
          const SizedBox(width: AppDimensions.spacing16),
          DropdownButton<StatusFilter>(
            value: statusFilter,
            underline: const SizedBox(),
            items: StatusFilter.values
                .map(
                  (filter) => DropdownMenuItem(
                    value: filter,
                    child: Text(filter.label),
                  ),
                )
                .toList(growable: false),
            onChanged: (value) {
              if (value == null) {
                return;
              }
              onStatusChanged(value);
            },
          ),
          const SizedBox(width: AppDimensions.spacing16),
          DropdownButton<TypeFilter>(
            value: typeFilter,
            underline: const SizedBox(),
            items: TypeFilter.values
                .map(
                  (filter) => DropdownMenuItem(
                    value: filter,
                    child: Text(filter.label),
                  ),
                )
                .toList(growable: false),
            onChanged: (value) {
              if (value == null) {
                return;
              }
              onTypeChanged(value);
            },
          ),
        ],
      ),
    );
  }
}
