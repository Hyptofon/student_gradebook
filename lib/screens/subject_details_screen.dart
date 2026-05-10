import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_dimensions.dart';
import '../constants/app_strings.dart';
import '../models/grade.dart';
import '../models/grade_filters.dart';
import '../models/grade_form_data.dart';
import '../models/subject.dart';
import '../providers/gradebook_provider.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/section_header.dart';
import '../widgets/subject_details/add_grade_dialog.dart';
import '../widgets/subject_details/grade_filters_bar.dart';
import '../widgets/subject_details/grade_list_item.dart';
import '../widgets/subject_details/subject_stats_widget.dart';

class SubjectDetailsScreen extends StatefulWidget {
  final Subject subject;

  const SubjectDetailsScreen({super.key, required this.subject});

  @override
  State<SubjectDetailsScreen> createState() => _SubjectDetailsScreenState();
}

class _SubjectDetailsScreenState extends State<SubjectDetailsScreen> {
  GradeSortOption _sortOption = GradeSortOption.dateDesc;
  StatusFilter _statusFilter = StatusFilter.all;
  TypeFilter _typeFilter = TypeFilter.all;

  Future<void> _showAddGradeDialog(Subject subject) async {
    final formData = await showDialog<GradeFormData>(
      context: context,
      builder: (context) => AddGradeDialog(subjectName: subject.name),
    );

    if (!mounted || formData == null) {
      return;
    }

    context.read<GradebookProvider>().addGrade(subject.id, formData);
  }

  void _deleteGrade(int subjectId, int gradeId) {
    context.read<GradebookProvider>().deleteGrade(subjectId, gradeId);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text(AppStrings.gradeDeleted)));
  }

  List<Grade> _getFilteredAndSortedGrades(Subject subject) {
    return subject.grades
        .where(
          (grade) => _statusFilter.matches(grade) && _typeFilter.matches(grade),
        )
        .toList(growable: false)
      ..sort(
        (a, b) => switch (_sortOption) {
          GradeSortOption.dateDesc => b.date.compareTo(a.date),
          GradeSortOption.dateAsc => a.date.compareTo(b.date),
          GradeSortOption.scoreDesc => b.score.compareTo(a.score),
          GradeSortOption.scoreAsc => a.score.compareTo(b.score),
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GradebookProvider>();
    final subject = provider.subjects.firstWhere(
      (s) => s.id == widget.subject.id,
      orElse: () => widget.subject,
    );

    final grades = _getFilteredAndSortedGrades(subject);

    return Scaffold(
      appBar: AppBar(title: Text(subject.name)),
      body: Column(
        children: [
          SubjectStatsWidget(subject: subject),
          const SizedBox(height: AppDimensions.spacing8),
          GradeFiltersBar(
            sortOption: _sortOption,
            statusFilter: _statusFilter,
            typeFilter: _typeFilter,
            onSortChanged: (option) => setState(() => _sortOption = option),
            onStatusChanged: (filter) => setState(() => _statusFilter = filter),
            onTypeChanged: (filter) => setState(() => _typeFilter = filter),
          ),
          const SectionHeader(title: AppStrings.allGrades),
          Expanded(
            child: grades.isEmpty
                ? const EmptyStateWidget(
                    message: AppStrings.noGradesFound,
                    subMessage: AppStrings.changeFiltersOrAdd,
                  )
                : ListView.builder(
                    itemCount: grades.length,
                    itemBuilder: (context, index) {
                      final grade = grades[index];
                      return GradeListItem(
                        grade: grade,
                        onDismissed: () => _deleteGrade(subject.id, grade.id),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddGradeDialog(subject),
        child: const Icon(Icons.add),
      ),
    );
  }
}
