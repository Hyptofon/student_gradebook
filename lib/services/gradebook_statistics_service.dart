import '../models/average_summary.dart';
import '../models/grade_status.dart';
import '../models/subject.dart';

class GradebookStatisticsService {
  const GradebookStatisticsService._();

  static AverageSummary calculateOverallSummary(List<Subject> subjects) {
    final gradedSubjects = subjects
        .where((subject) => subject.grades.isNotEmpty)
        .toList(growable: false);

    if (gradedSubjects.isEmpty) {
      return (average: 0.0, status: GradeStatus.noData, stars: 0);
    }

    final average =
        gradedSubjects.fold<double>(
          0.0,
          (sum, subject) => sum + subject.average,
        ) /
        gradedSubjects.length;

    return (
      average: average,
      status: GradeStatus.fromScore(average),
      stars: Subject.starsForAverage(average, hasGrades: true),
    );
  }

  static Map<GradeStatus, int> calculateStatusCounts(List<Subject> subjects) {
    final grades = subjects
        .expand((subject) => subject.grades)
        .toList(growable: false);

    return Map<GradeStatus, int>.unmodifiable(
      Map<GradeStatus, int>.fromEntries(
        GradeStatus.gradedValues.map(
          (status) => MapEntry(
            status,
            grades.where((grade) => grade.status == status).length,
          ),
        ),
      ),
    );
  }
}
