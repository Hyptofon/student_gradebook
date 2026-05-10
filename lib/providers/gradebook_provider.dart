import 'package:flutter/foundation.dart';

import '../models/average_summary.dart';
import '../models/grade.dart';
import '../models/grade_form_data.dart';
import '../models/grade_status.dart';
import '../models/subject.dart';
import '../models/subject_form_data.dart';
import '../services/gradebook_seed_service.dart';
import '../services/gradebook_statistics_service.dart';
import '../services/id_generator.dart';

enum SubjectSortOption { averageDesc, averageAsc }

class GradebookProvider extends ChangeNotifier {
  final List<Subject> _subjects;
  SubjectSortOption _sortOption = SubjectSortOption.averageDesc;

  GradebookProvider({List<Subject>? initialSubjects, DateTime? seedDate})
    : _subjects = List<Subject>.from(
        initialSubjects ??
            GradebookSeedService.createInitialSubjects(
              baseDate: seedDate ?? DateTime.now(),
            ),
      );

  SubjectSortOption get sortOption => _sortOption;

  List<Subject> get subjects => List.unmodifiable(_subjects);

  AverageSummary get overallSummary =>
      GradebookStatisticsService.calculateOverallSummary(_subjects);

  Map<GradeStatus, int> get statistics =>
      GradebookStatisticsService.calculateStatusCounts(_subjects);

  List<Subject> get sortedSubjects {
    return List<Subject>.from(_subjects)..sort(
      (a, b) => switch (_sortOption) {
        SubjectSortOption.averageDesc => b.average.compareTo(a.average),
        SubjectSortOption.averageAsc => a.average.compareTo(b.average),
      },
    );
  }

  void setSortOption(SubjectSortOption option) {
    if (_sortOption == option) {
      return;
    }

    _sortOption = option;
    notifyListeners();
  }

  void addSubject(SubjectFormData formData) {
    _subjects.add(
      Subject(
        id: IdGenerator.generate(),
        name: formData.name,
        icon: formData.icon,
      ),
    );
    notifyListeners();
  }

  void addGrade(int subjectId, GradeFormData formData) {
    final subject = _subjects.firstWhere((s) => s.id == subjectId);
    subject.addGrade(
      Grade(
        id: IdGenerator.generate(),
        score: formData.score,
        type: formData.type,
        description: formData.description,
        date: formData.date,
      ),
    );
    notifyListeners();
  }

  void deleteGrade(int subjectId, int gradeId) {
    final subject = _subjects.firstWhere((s) => s.id == subjectId);
    subject.removeGrade(gradeId);
    notifyListeners();
  }
}
