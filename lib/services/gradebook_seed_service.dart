import '../constants/seed_constants.dart';
import '../models/grade.dart';
import '../models/grade_type.dart';
import '../models/subject.dart';

class GradebookSeedService {
  const GradebookSeedService._();

  static List<Subject> createInitialSubjects({required DateTime baseDate}) {
    return [
      Subject(
        id: SeedConstants.mathematicsId,
        name: SeedConstants.mathematicsName,
        icon: SeedConstants.mathematicsIcon,
        grades: [
          Grade(
            id: SeedConstants.midtermGradeId,
            score: SeedConstants.midtermScore,
            type: GradeType.exam,
            description: SeedConstants.midtermDescription,
            date: baseDate.subtract(
              const Duration(days: SeedConstants.midtermDaysAgo),
            ),
          ),
          Grade(
            id: SeedConstants.quizGradeId,
            score: SeedConstants.quizScore,
            type: GradeType.quiz,
            description: SeedConstants.quizDescription,
            date: baseDate.subtract(
              const Duration(days: SeedConstants.quizDaysAgo),
            ),
          ),
        ],
      ),
      Subject(
        id: SeedConstants.programmingId,
        name: SeedConstants.programmingName,
        icon: SeedConstants.programmingIcon,
        grades: [
          Grade(
            id: SeedConstants.projectGradeId,
            score: SeedConstants.projectScore,
            type: GradeType.project,
            description: SeedConstants.projectDescription,
            date: baseDate.subtract(
              const Duration(days: SeedConstants.projectDaysAgo),
            ),
          ),
        ],
      ),
      Subject(
        id: SeedConstants.physicsId,
        name: SeedConstants.physicsName,
        icon: SeedConstants.physicsIcon,
        grades: const [],
      ),
    ];
  }
}
