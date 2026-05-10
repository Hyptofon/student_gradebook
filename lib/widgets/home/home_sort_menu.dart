import 'package:flutter/material.dart';

import '../../constants/filter_labels.dart';
import '../../providers/gradebook_provider.dart';

class HomeSortMenu extends StatelessWidget {
  final SubjectSortOption selectedOption;
  final ValueChanged<SubjectSortOption> onSelected;

  const HomeSortMenu({
    super.key,
    required this.selectedOption,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SubjectSortOption>(
      initialValue: selectedOption,
      icon: const Icon(Icons.sort),
      onSelected: onSelected,
      itemBuilder: (context) => SubjectSortOption.values
          .map(
            (option) => PopupMenuItem<SubjectSortOption>(
              value: option,
              child: Text(option.label),
            ),
          )
          .toList(growable: false),
    );
  }
}
