import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_dimensions.dart';
import '../constants/app_strings.dart';
import '../models/subject.dart';
import '../models/subject_form_data.dart';
import '../providers/gradebook_provider.dart';
import '../routes/app_route_names.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/home/add_subject_dialog.dart';
import '../widgets/home/home_sort_menu.dart';
import '../widgets/home/overall_average_widget.dart';
import '../widgets/home/statistics_widget.dart';
import '../widgets/section_header.dart';
import '../widgets/subject_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _showAddSubjectDialog(BuildContext context) async {
    final formData = await showDialog<SubjectFormData>(
      context: context,
      builder: (context) => const AddSubjectDialog(),
    );

    if (!context.mounted || formData == null) {
      return;
    }

    context.read<GradebookProvider>().addSubject(formData);
  }

  Future<void> _openSubjectDetails(
    BuildContext context,
    Subject subject,
  ) async {
    await Navigator.of(
      context,
    ).pushNamed(AppRouteNames.subjectDetails, arguments: subject);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GradebookProvider>();
    final overallSummary = provider.overallSummary;
    final sortedSubjects = provider.sortedSubjects;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.myGrades),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          HomeSortMenu(
            selectedOption: provider.sortOption,
            onSelected: (option) =>
                context.read<GradebookProvider>().setSortOption(option),
          ),
        ],
      ),
      body: Column(
        children: [
          OverallAverageWidget(
            average: overallSummary.average,
            status: overallSummary.status,
            stars: overallSummary.stars,
          ),
          StatisticsWidget(statistics: provider.statistics),
          const SizedBox(height: AppDimensions.spacing8),
          const SectionHeader(title: AppStrings.subjects),
          Expanded(
            child: sortedSubjects.isEmpty
                ? const EmptyStateWidget()
                : ListView.builder(
                    itemCount: sortedSubjects.length,
                    itemBuilder: (context, index) {
                      final subject = sortedSubjects[index];
                      return SubjectCard(
                        subject: subject,
                        onTap: () => _openSubjectDetails(context, subject),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddSubjectDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
